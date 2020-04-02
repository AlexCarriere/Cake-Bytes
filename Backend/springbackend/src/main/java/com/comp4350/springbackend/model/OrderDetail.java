package com.comp4350.springbackend.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class OrderDetail {
    private String base;
    private String icing;
    private String deco;
    private String otherRequest;

    public OrderDetail(@JsonProperty("base") String base,
                       @JsonProperty("icing") String icing,
                       @JsonProperty("deco") String deco,
                       @JsonProperty("other_request") String otherRequest) {
        this.base = base;
        this.icing = icing;
        this.deco = deco;
        this.otherRequest = otherRequest;
    }

    public String toString(){
        return String.format("{base:%s,icing:%s,deco:%s,other_request:%s}",base,icing,deco,otherRequest);
    }

    public void update(OrderDetail d){
        if(d.getBase()!=null && d.getBase().length()>0){
            base = d.getBase();
        }
        if(d.getIcing()!=null && d.getIcing().length()>0){
            icing = d.getIcing();
        }
        if(d.getDeco()!=null && d.getDeco().length()>0){
            deco = d.getDeco();
        }
        if(d.getOtherRequest()!=null && d.getOtherRequest().length()>0){
            otherRequest = d.getOtherRequest();
        }
    }

    public String getBase() {
        return base;
    }

    public void setBase(String base) {
        this.base = base;
    }

    public String getIcing() {
        return icing;
    }

    public void setIcing(String icing) {
        this.icing = icing;
    }

    public String getDeco() {
        return deco;
    }

    public void setDeco(String deco) {
        this.deco = deco;
    }

    public String getOtherRequest() {
        return otherRequest;
    }

    public void setOtherRequest(String otherRequest) {
        this.otherRequest = otherRequest;
    }
}
