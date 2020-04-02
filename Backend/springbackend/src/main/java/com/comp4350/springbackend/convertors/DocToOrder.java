package com.comp4350.springbackend.convertors;

import com.comp4350.springbackend.model.Order;
import com.comp4350.springbackend.model.OrderDetail;
import org.bson.Document;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class DocToOrder implements Converter<Document, Order> {

    @Override
    public Order convert(Document doc) {
        Order order = new Order(
                UUID.fromString(((String)doc.get("order_id"))),
                ((String)doc.get("first_name")),
                ((String)doc.get("last_name")),
                ((String)doc.get("timestamp")),
                ((String)doc.get("status")),
                docToDetail((Document) doc.get("detail")),
                ((int)doc.get("amount")));
        return order;
    }

    public OrderDetail docToDetail(Document doc){
        return new OrderDetail((String)doc.get("base"),
                (String)doc.get("icing"),
                (String)doc.get("deco"),
                (String)doc.get("other_request"));
    }

}