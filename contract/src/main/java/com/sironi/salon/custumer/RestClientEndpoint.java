package com.sironi.salon.custumer;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("salon/v1/custumer")
public class RestClientEndpoint {

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public void Client(){
        System.out.println("teste");
    }
}
