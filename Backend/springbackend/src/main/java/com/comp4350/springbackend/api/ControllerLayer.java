package com.comp4350.springbackend.api;

import com.comp4350.springbackend.model.Customer;
import com.comp4350.springbackend.model.Order;
import com.comp4350.springbackend.security.TokenManager;
import com.comp4350.springbackend.service.ServiceLayer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;
import java.sql.Timestamp;
import java.util.Date;

@CrossOrigin
@RequestMapping
@RestController
public class ControllerLayer {
    private final ServiceLayer service;
    private final TokenManager tokenManager;

    @Autowired
    public ControllerLayer(ServiceLayer service, TokenManager tokenManager){
        this.service = service;
        this.tokenManager = tokenManager;
    }

    @PostMapping(path="register")
    public ResponseEntity<?> createCustomer(@Valid @NotNull @RequestBody Customer cus){
        System.out.println(cus.toString());
        if(service.createCustomer(cus)==1){
            return ResponseEntity.ok(tokenManager.generateToken(cus));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Username exists");
    }


    @PostMapping(path="login")
    public ResponseEntity<?> login(@RequestBody Customer cus){
        if(cus != null && service.login(cus)==1){
            return ResponseEntity.ok(tokenManager.generateToken(cus));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username/password.");
    }



    @PostMapping(path="order/{username}")
    public ResponseEntity<?> insertOrder(@Valid @RequestBody Order order, @PathVariable("username") String username){
        order.setOrderID(UUID.randomUUID());
        Timestamp ts=new Timestamp(System.currentTimeMillis());
        Date date = ts;
        order.setTimestamp((date.toString()).substring(0,19));
        if(order.getStatus()== null)
            order.setStatus("Processing");
        if(service.insertOrder(order, username)==1){
            return ResponseEntity.ok(order);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username");
    }

    @GetMapping(path="order/{username}")
    public ResponseEntity<?> selectAllOrderByUsername(@PathVariable("username") String username){
        List<Order> orders = service.selectAllOrderByUsername(username);
        if(orders != null){
            return ResponseEntity.ok(orders);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username");
    }

    @GetMapping(path="order/{username}/{orderID}")
    public ResponseEntity<?> getOrderByID(@PathVariable("username") String username, @PathVariable("orderID")String orderID){
        Order order = service.getOrderByID(username, orderID);
        if(order != null){
            return ResponseEntity.ok(order);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username/orderID");
    }

    @PostMapping(path="order/{username}/{orderID}")
    public ResponseEntity<?> updateOrderByID(@PathVariable("username") String username, @PathVariable("orderID") String orderID, @RequestBody Order order){
        int ret = service.updateOrderByID(username, orderID, order);
        if(ret == 1){
            return ResponseEntity.ok(order);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("unknown username/orderID");
    }

    @DeleteMapping(path="order/{username}/{orderID}")
    public ResponseEntity<?> deleteOrderByID(@PathVariable("username") String username, @PathVariable("orderID") String orderID){
        int res = service.deleteOrderByID(username,orderID);
        if(res == 0){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid username/orderID");
        }
        else{
            return ResponseEntity.ok("deleted");
        }
    }

    @PostMapping(path="resetdb")
    public ResponseEntity<?> resetDB(){
        service.resetDB();
        return ResponseEntity.ok("db reset success!");
    }
/*
    @GetMapping(path="phoneNumber/{phoneNumber}")
    public List<Order> selectOrderByPhoneNumber(@PathVariable("phoneNumber") String phoneNumber) {
        return service.selectOrderByPhoneNumber(phoneNumber);
    }

    @GetMapping(path="id/{id}")
    public Order selectOrderByID(@PathVariable("id") UUID id) {
        return service.selectOrderByID(id).orElse(null);
    }

    @GetMapping(path={"lastName/{lastName}"})
    public List<Order> selectOrderByLastName(@PathVariable("lastName") String lastName) {
        return service.selectOrderByLastName(lastName);
    }

    @PutMapping(path="id/{id}")
    public void updateOrderByID(@PathVariable UUID id, @RequestBody Order newOrder){
        newOrder.setOrderID(id);
        service.updateOrderByID(id,newOrder);
    }

    @DeleteMapping(path="id/{id}")
    public void deleteOrderByID(@PathVariable UUID id){
        service.deleteOrderByID(id);
    }
*/
}
