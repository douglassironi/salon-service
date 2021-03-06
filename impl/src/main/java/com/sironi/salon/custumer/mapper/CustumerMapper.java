package com.sironi.salon.custumer.mapper;


import com.sironi.salon.custumer.models.CustomerModel;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CustumerMapper {
    @Select("SELECT * FROM pessoas WHERE CODIGO = #{id}")
    CustomerModel getCustumerById(@Param("id") Long id);

    @Select("SELECT * FROM pessoas WHERE nome = #{name}")
    List<CustomerModel> getCustumerByName(@Param("name") String name);


    @Select("SELECT * FROM pessoas")
    List<CustomerModel> getAllCustumer();


    @Insert("insert into pessoas (codigo, " +
            "tipo_pessoa, " +
            "nome," +
            "data_nasc," +
            "cpf_cnpj," +
            "rg_insc," +
            "endereco," +
            "bairro," +
            "cep," +
            "telefone," +
            "celular," +
            "email," +
            "cidade," +
            "uf)" +
            "values (pessoas_seq.nextval," +
            "#{customer.tipo_pessoa ,jdbcType=NVARCHAR}," +
            "#{customer.nome ,jdbcType=NVARCHAR}," +
            "#{customer.data_nasc ,jdbcType=DATE}," +
            "#{customer.cpf_cnpj ,jdbcType=NVARCHAR}," +
            "#{customer.rg_insc ,jdbcType=NVARCHAR}," +
            "#{customer.endereco ,jdbcType=NVARCHAR}," +
            "#{customer.bairro ,jdbcType=NVARCHAR}," +
            "#{customer.cep ,jdbcType=NVARCHAR}," +
            "#{customer.telefone ,jdbcType=NVARCHAR}," +
            "#{customer.celular ,jdbcType=NVARCHAR}," +
            "#{customer.email ,jdbcType=NVARCHAR}," +
            "#{customer.cidade ,jdbcType=NVARCHAR}," +
            "#{customer.uf ,jdbcType=NVARCHAR })")
    void setCustumer(@Param("customer") CustomerModel customer);
}
