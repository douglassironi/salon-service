package com.sironi.salon.product;


import com.sironi.salon.product.mapper.ProductMapper;
import com.sironi.salon.product.model.ProductModel;
import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.annotation.MapperScans;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("salon/v1/product")
@CrossOrigin(origins = "*")
public class RestProductEndpoint {

    @Autowired
    private  ProductMapper productMapper;

    @RequestMapping(value = "/",method = RequestMethod.GET)
    public List<ProductModel> Client(){
        return  productMapper.getProductByDescription("");

    }

    @RequestMapping(value = "/{id}",method = RequestMethod.GET)
    public ProductModel getById(@PathVariable(name = "id") Long id){
         return productMapper.getProductById(id);
    }

    @RequestMapping(value = "/",method = RequestMethod.POST)
    public void addClient(@RequestBody(required = true) ProductModel productModel){
         productMapper.setProduct(productModel);

    }

}


