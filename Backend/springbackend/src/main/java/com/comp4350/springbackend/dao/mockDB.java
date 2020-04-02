package com.comp4350.springbackend.dao;

import com.comp4350.springbackend.model.Customer;
import com.comp4350.springbackend.model.Order;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Repository("mockDB")
public class mockDB implements Database {

    private List<Customer> customerList = new ArrayList<>();

    @Override
    public int createCustomer(Customer cus) {
        if(customerList.stream()
        .noneMatch(customer -> customer.getUsername().equals(cus.getUsername()))){
            customerList.add(cus);
            return 1;
        }
        return 0;

    }

    @Override
    public int login(Customer cus) {
        if(customerList.stream()
                .noneMatch(customer ->
                        customer.getPassword().equals(cus.getPassword()) &&
                        customer.getUsername().equals(cus.getUsername()))){
            return 0;
        }
        return 1;
    }

    @Override
    public int insertOrder(Order order, String username) {
        Optional<Customer> customerMaybe = customerList.stream()
                .filter(customer ->
                        customer.getUsername().equals(username))
                .findFirst();
        if(!customerMaybe.isPresent()){
            return 0;
        }
        customerMaybe.get().addOrder(order);
        return 1;
    }

    @Override
    public List<Order> selectAllOrderByUsername(String username) {
        Optional<Customer> maybe =customerList.stream()
                .filter(customer -> customer.getUsername().equals(username))
                .findFirst();
        return maybe.map(Customer::getOrders).orElse(null);
    }

    @Override
    public byte[] getSalt(String username){
        Optional<Customer> maybe = customerList.stream()
                .filter(customer -> customer.getUsername().equals(username))
                .findFirst();
        return maybe.map(Customer::getSalt).orElse(null);
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
        Optional<Customer> maybe =customerList.stream()
                .filter(customer -> customer.getUsername().equals(username))
                .findFirst();
        if(maybe.isPresent()){
            maybe.get().deleteOrder(UUID.fromString(orderID));
        }
        return 1;
    }

    public void resetDB(){
        customerList = new ArrayList<>();
    }
/*
    @Override
    public List<Order> selectOrderByUsername(String phoneNumber) {
        return orderList.stream()
                .filter(order -> order.getPhoneNumber().equals(phoneNumber))
                .collect(Collectors.toList());
    }

    @Override
    public Optional<Order> selectOrderByID(UUID id) {
        return orderList.stream()
                .filter(order -> order.getOrderID().equals(id))
                .findFirst();
    }

    @Override
    public List<Order> selectOrderByLastName(String lastName) {
        return orderList.stream()
                .filter(order -> order.getLastName().equals(lastName))
                .collect(Collectors.toList());
    }

    @Override
    public int updateOrderByID(UUID id, Order newOrder) {
        return selectOrderByID(id)
                .map(order-> {
                    int indexOfOrderUpdate = DB.indexOf(order);
                    if(indexOfOrderUpdate>=0){
                        Order originalOrder = DB.get(indexOfOrderUpdate);
                        DB.set(indexOfOrderUpdate,updateOrder(originalOrder,newOrder));
                        return 1;
                    }else{
                        return 0;
                    }
                }).orElse(0);
    }

    @Override
    public int deleteOrderByID(UUID id) {
        Optional<Order> orderMaybe = selectOrderByID(id);
        if(orderMaybe.isEmpty()){
            return 0;
        }
        DB.remove(orderMaybe.get());
        return 1;
    }

    private Order updateOrder(Order origin ,Order newOrder){
        if(newOrder.getPhoneNumber()!=null){
            origin.setPhoneNumber(newOrder.getPhoneNumber());
        }
        if(newOrder.getFirstName()!=null){
            origin.setFirstName(newOrder.getFirstName());
        }
        if(newOrder.getLastName()!=null){
            origin.setLastName(newOrder.getLastName());
        }
        if(newOrder.getQty()!=0){
            origin.setQty(newOrder.getQty());
        }
        return origin;
    }
    */

}
