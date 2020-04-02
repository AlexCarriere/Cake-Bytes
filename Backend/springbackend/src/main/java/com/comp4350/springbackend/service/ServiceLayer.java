package com.comp4350.springbackend.service;

import com.comp4350.springbackend.security.PasswordHashing;
import com.comp4350.springbackend.dao.Database;
import com.comp4350.springbackend.model.Customer;
import com.comp4350.springbackend.model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

@Service
public class ServiceLayer {
    private final Database database;
    private final PasswordHashing hs;


    @Autowired
    public ServiceLayer(@Qualifier("mongoDB") Database database, PasswordHashing hs){
        this.database = database;
        this.hs = hs;

//        createCustomer(new Customer("abc","1234"));
    }

    public int createCustomer(Customer cus){
        byte[] salt = hs.createSalt();
        cus.setSalt(salt);
        String password = cus.getPassword();
        try{
            cus.setPassword(hs.generateHash(password, salt));
        }catch (Exception e){
            return 0;
        }
        return database.createCustomer(cus);
    }

    public int login(Customer cus){
        byte[] salt = database.getSalt(cus.getUsername());
        if(salt == null){
            salt = new byte[0];
        }
        String password = cus.getPassword();
        try{
            cus.setPassword(hs.generateHash(password, salt));
        }catch (Exception e){
            return 0;
        }
        return database.login(cus);
    }


    public int insertOrder(Order order, String username){
        return database.insertOrder(order, username);
    }

    public List<Order> selectAllOrderByUsername(String username){
        List<Order> ret = database.selectAllOrderByUsername(username);
        if(ret != null)
            ret.sort(Comparator.comparing(Order::getTimestamp).reversed());
        return ret;
    }

    public Order getOrderByID(String username, String orderID){
        return database.getOrderByID(username, orderID);
    }

    public int updateOrderByID(String username, String orderID, Order order){
        return database.updateOrderByID(username, orderID, order);
    }

    public int deleteOrderByID(String username, String orderID){
        return database.deleteOrderByID(username, orderID);
    }

    public void resetDB(){
        (database).resetDB();
    }

/*
    public List<Order> selectOrderByUsername(String phoneNumber) {
        return database.selectOrderByUsername(phoneNumber);
    }

    public Optional<Order> selectOrderByID(UUID id) {
        return database.selectOrderByID(id);
    }

    public List<Order> selectOrderByLastName(String lastName) {
        return database.selectOrderByLastName(lastName);
    }

    public int updateOrderByID(UUID id, Order newOrder){
        return database.updateOrderByID(id,newOrder);
    }

    public int deleteOrderByID(UUID id){
        return database.deleteOrderByID(id);
    }
*/
}
