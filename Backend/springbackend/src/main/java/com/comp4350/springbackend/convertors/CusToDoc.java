package com.comp4350.springbackend.convertors;

import com.comp4350.springbackend.model.Customer;
import org.bson.Document;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.util.ArrayList;

import static org.apache.tomcat.util.codec.binary.Base64.encodeBase64String;

@Component
public class CusToDoc implements Converter<Customer, Document> {
    @Override
    public Document convert(Customer customer) {
        Document doc = new Document();
        if(customer.getUsername()!=null)
            doc.append("username", customer.getUsername());
        if(customer.getPassword()!=null)
            doc.append("password", customer.getPassword());
        if(customer.getOrders()!=null)
            doc.append("orders", new ArrayList<>());
        if(customer.getSalt()!=null)
            doc.append("salt", encodeBase64String(customer.getSalt()));
        return doc;
    }
}
