package com.comp4350.springbackend.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class Customer {
    @NotBlank
    private String username;
    private String password;
    private List<Order> orders;
    private byte[] salt;


    public Customer(@JsonProperty("username") String username,
                    @JsonProperty("password") String password) {
        this.username = username;
        this.password = password;
        orders = new ArrayList<>();
    }
    public byte[] getSalt() {
        return salt;
    }

    public void setSalt(byte[] salt) {
        this.salt = salt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void addOrder(Order order){
        orders.add(order);
    }

    public List<Order> getOrders(){
        return orders;
    }

    public void deleteOrder(UUID orderID){
        orders.removeIf(order -> order.getOrderID().equals(orderID));
    }

    @Override
    public String toString() {
        return "Customer{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
