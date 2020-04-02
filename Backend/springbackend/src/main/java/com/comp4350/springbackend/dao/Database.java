package com.comp4350.springbackend.dao;

import com.comp4350.springbackend.model.Customer;
import com.comp4350.springbackend.model.Order;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface Database {
    int createCustomer(Customer cus);

    int login(Customer cus);

    int insertOrder(Order order, String username);

    List<Order> selectAllOrderByUsername(String username);

    byte[] getSalt(String username);

    Order getOrderByID(String username, String orderID);

    int updateOrderByID(String username, String orderID, Order order);

    int deleteOrderByID(String username, String orderID);

    void resetDB();

//
  //  List<Order> selectOrderByUsername(String username);
//
//    Optional<Order> selectOrderByID(UUID id);
//
//    List<Order> selectOrderByLastName(String lastName);
//
//    int updateOrderByID(UUID id, Order newOrder);
//
//    int deleteOrderByID(UUID id);


}
