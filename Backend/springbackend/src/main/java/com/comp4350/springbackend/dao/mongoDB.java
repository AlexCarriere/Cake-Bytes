package com.comp4350.springbackend.dao;

import com.comp4350.springbackend.convertors.CusToDoc;
import com.comp4350.springbackend.convertors.DocToOrder;
import com.comp4350.springbackend.convertors.OrderToDoc;
import com.comp4350.springbackend.model.Customer;
import com.comp4350.springbackend.model.Order;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import java.util.*;

import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;
import static org.apache.tomcat.util.codec.binary.Base64.decodeBase64;

@Repository("mongoDB")
public class mongoDB implements Database {

    MongoClientURI uri;
    MongoClient mongoClient;
    MongoDatabase DB;
    MongoCollection<Document> customers;
    OrderToDoc orderToDocConverter;
    DocToOrder docToOrderConverter;
    CusToDoc cusToDoc;

    @Autowired
    public mongoDB(OrderToDoc orderToDocConverter, DocToOrder docToOrderConverter, CusToDoc cusToDoc) {
        uri = new MongoClientURI( "mongodb://cupcakebyte:1234@clustercakebyte-shard-00-00-yh0f0.mongodb.net:27017,clustercakebyte-shard-00-01-yh0f0.mongodb.net:27017,clustercakebyte-shard-00-02-yh0f0.mongodb.net:27017/test?ssl=true&replicaSet=ClusterCakeByte-shard-0&authSource=admin&retryWrites=true");
        mongoClient = new MongoClient(uri);
        DB = mongoClient.getDatabase("cakeBytes");
        customers = DB.getCollection("Customers");
        this.orderToDocConverter = orderToDocConverter;
        this.docToOrderConverter = docToOrderConverter;
        this.cusToDoc = cusToDoc;

    }

    @Override
    public int createCustomer(Customer cus) {
        if(findUsername(cus.getUsername())==0){
            customers.insertOne(cusToDoc.convert(cus));
            return 1;
        }
        return 0;
    }

    @Override
    public int login(Customer cus) {
        for (Document cur : customers.find(and(eq("username", cus.getUsername()), eq("password", cus.getPassword())))) {
            return 1;
        }
        return 0;
    }

    public int findUsername(String username) {
        for (Document cur : customers.find(eq("username",username))){
            return 1;
        }
        return 0;
    }

    @Override
    public List<Order> selectAllOrderByUsername(String username) {
        List<Order> ret = new ArrayList<>();
        for (Document cur : customers.find(eq("username",username))) {
            for(Document order: (List<Document>)cur.get("orders")){
                ret.add(docToOrderConverter.convert(order));
            }
        }
        return ret;
    }

    @Override
    public int insertOrder(Order order, String username) {
        if(findUsername(username)==1){
            customers.updateOne(eq("username", username), new Document("$push",new Document("orders", orderToDocConverter.convert(order))));
            return 1;
        }
        return 0;
    }

    @Override
    public byte[] getSalt(String username){
        for (Document cur : customers.find(eq("username",username))){
            try {
                byte[] salts = decodeBase64((String)cur.get("salt"));
                return salts;
            }catch (Exception e){
                return null;
            }
        }
        return null;
    }

    @Override
    public Order getOrderByID(String username, String orderID){
        List<Order> orders = selectAllOrderByUsername(username);
        if(orders != null){
            Optional<Order> op = orders.stream().filter(order->order.getOrderID().toString().equals(orderID)).findFirst();
            if(op.isPresent())
                return op.get();
        }
        return null;
    }

    @Override
    public int updateOrderByID(String username, String orderID, Order orderUpdate){
        List<Order> orders = selectAllOrderByUsername(username);
        if(orders != null){
            Optional<Order> op = orders.stream().filter(order->order.getOrderID().toString().equals(orderID)).findFirst();
            if(op.isPresent()){
                op.get().update(orderUpdate);
                Document filter = new Document("username",username).append("orders.order_id",orderID);
                Document update = new Document("$set", new Document("orders.$", orderToDocConverter.convert(op.get())));
                customers.updateOne(filter, update);
                return 1;
            }

        }
        return 0;
    }

    @Override
    public int deleteOrderByID(String username, String orderID){
        Order orderMaybe = getOrderByID(username, orderID);
        if(orderMaybe == null){
            return 0;
        }
        Document filter = new Document("username",username);
        Document update = new Document("$pull", new Document("orders", new Document("order_id", orderID)));
        customers.updateOne(filter, update);
        return 1;
    }

    @Override
    public void resetDB(){
        customers.drop();
    }
    /*

    @Override
    public List<Order> selectAllOrder() {
        List<Order> ret = new ArrayList<>();
        for (Document cur : orders.find()) {
            ret.add(docToOrderConverter.convert(cur));
        }
        return ret;
    }

    @Override
    public List<Order> selectOrderByPhoneNumber(String phoneNumber) {
        List<Order> ret = new ArrayList<>();
        for (Document cur : orders.find(eq("phoneNumber",phoneNumber))) {
            ret.add(docToOrderConverter.convert(cur));
        }
        return ret;
    }

    @Override
    public Optional<Order> selectOrderByID(UUID id) {
        Document doc = orders.find(eq("id",id.toString())).first();
        Order select = docToOrderConverter.convert(doc);
        return Optional.of(select);
    }

    @Override
    public List<Order> selectOrderByLastName(String lastName) {
        List<Order> ret = new ArrayList<>();
        for (Document cur : orders.find(eq("lastName",lastName))) {
            ret.add(docToOrderConverter.convert(cur));
        }
        return ret;
    }

    @Override
    public int updateOrderByID(UUID id, Order newOrder) {
        Document doc = new Document();
        if(newOrder.getPhoneNumber()!=null){
            doc.append("phoneNumber",newOrder.getPhoneNumber());
        }
        if(newOrder.getFirstName()!=null){
            doc.append("firstName",newOrder.getFirstName());
        }
        if(newOrder.getLastName()!=null){
            doc.append("lastName",newOrder.getLastName());
        }
        if(newOrder.getQty()!=0){
            doc.append("qty",newOrder.getQty());
        }
        orders.updateOne(eq("id", id.toString()), new Document("$set", doc));
        return 1;
    }

    @Override
    public int deleteOrderByID(UUID id) {
        orders.deleteOne(eq("id", id.toString()));
        return 1;
    }

*/
}




