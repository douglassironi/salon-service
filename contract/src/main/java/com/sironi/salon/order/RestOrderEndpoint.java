package com.sironi.salon.order;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("salon/v1/order")
public class RestOrderEndpoint {

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public void Client(){
        System.out.println("teste");
    }
}
