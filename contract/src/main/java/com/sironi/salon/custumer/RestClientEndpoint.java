package com.sironi.salon.custumer;


import com.sironi.salon.custumer.mapper.CustumerMapper;
import com.sironi.salon.custumer.models.CustomerModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("salon/v1/custumer")
public class RestClientEndpoint {
    @Autowired
    private CustumerMapper custumerMapper;

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public List<CustomerModel> listCustumer(){
        return custumerMapper.getAllCustumer();
    }

    @RequestMapping(value = "/",method = RequestMethod.POST)
    public void addCustumer(@RequestBody(required = true) CustomerModel customerModel){
        custumerMapper.setCustumer(customerModel);
    }

}
