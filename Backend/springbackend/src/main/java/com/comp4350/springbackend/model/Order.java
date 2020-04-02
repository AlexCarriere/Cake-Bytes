package com.comp4350.springbackend.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.NotBlank;
import java.util.UUID;

public class Order {
    private UUID orderID;
    @NotBlank
    private String firstName;
    private String lastName;
    private String timestamp;
    private String status;
    private OrderDetail detail;
    private int amount;


    public Order(@JsonProperty("order_id") UUID orderID,
                 @JsonProperty("first_name") String firstName,
                 @JsonProperty("last_name") String lastName,
                 String timestamp,
                 @JsonProperty("status") String status,
                 @JsonProperty("detail") OrderDetail detail,
                 @JsonProperty("amount") int amount) {
        this.orderID = orderID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.timestamp = timestamp;
        this.status = status;
        this.detail = detail;
        this.amount = amount;
    }

    public String toString(){
        return String.format("{order_id:%s,first_name:%s,last_name:%s,timestamp:%s,detail:%s,amount:%s,}",
                            orderID,firstName,lastName,timestamp,detail,amount);
    }

    public void update(Order o){
        if(o.getFirstName()!=null && o.getFirstName().length()>0){
            firstName = o.getFirstName();
        }
        if(o.getLastName()!=null && o.getLastName().length()>0){
            lastName = o.getLastName();
        }
        if(o.getDetail()!=null){
            detail.update(o.getDetail());
        }
        if(o.getAmount()!=0 && o.getAmount()!=amount){
            amount = o.getAmount();
        }
        if(o.getStatus()!=null && o.getStatus().length()>0){
            status = o.getStatus();
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public UUID getOrderID() {
        return orderID;
    }

    public void setOrderID(UUID orderID) {
        this.orderID = orderID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public OrderDetail getDetail() {
        return detail;
    }

    public void setDetail(OrderDetail detail) {
        this.detail = detail;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
