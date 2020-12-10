package com.sironi.salon.employer.mapper;


import com.sironi.salon.employer.models.EmployerModel;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface EmployerMapper {
    @Select("SELECT * FROM pessoas WHERE CODIGO = #{id} and tipo_pessoa = 'A'")
    EmployerModel getEmployerById(@Param("id") Long id);

    @Select("SELECT * FROM pessoas WHERE nome = #{name} and tipo_pessoa = 'A'")
    List<EmployerModel> getCustumerByName(@Param("name") String name);


    @Select("SELECT * FROM pessoas where  tipo_pessoa = 'A'")
    List<EmployerModel> getAllCustumer();


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
    void setCustumer(@Param("customer") EmployerModel customer);
}
