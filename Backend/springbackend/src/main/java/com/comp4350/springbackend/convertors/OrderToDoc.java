package com.comp4350.springbackend.convertors;

import com.comp4350.springbackend.model.Order;
import com.comp4350.springbackend.model.OrderDetail;
import org.bson.Document;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

@Component
public class OrderToDoc implements Converter<Order, Document> {

    @Override
    public Document convert(Order order) {
        Document doc = new Document();
        if(order.getOrderID()!=null)
            doc.append("order_id", order.getOrderID().toString());
        if(order.getFirstName()!=null)
            doc.append("first_name", order.getFirstName());
        if(order.getLastName()!=null)
            doc.append("last_name",  order.getLastName());
        if(order.getTimestamp()!=null)
            doc.append("timestamp",  order.getTimestamp());
        if(order.getStatus()!=null)
            doc.append("status",  order.getStatus());
        if(order.getDetail()!=null)
            doc.append("detail", detailToDoc(order.getDetail()));
        if(order.getAmount()!=0)
            doc.append("amount", order.getAmount());
        return doc;
    }
    public Document detailToDoc(OrderDetail detail){
        Document doc = new Document();
        if(detail.getBase()!=null)
            doc.append("base",detail.getBase());
        if(detail.getIcing()!=null)
            doc.append("icing",detail.getIcing());
        if(detail.getDeco()!=null)
            doc.append("deco",detail.getDeco());
        if(detail.getOtherRequest()!=null)
            doc.append("other_request",detail.getOtherRequest());
        return doc;
    }

}