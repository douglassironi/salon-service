package com.sironi.salon.product.mapper;

import com.sironi.salon.product.model.ProductModel;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;

import java.util.List;


@MapperScan
public interface ProductMapper {

    @Select(value = "Select codigo, " +
            "               descricao," +
            "               percentual_comissao as percentualComissao, " +
            "               valor_compra valorCompra," +
            "               valor_venda valorVenda," +
            "               quantidade_minima quantidadeMinima," +
            "               quantidade_atual quantidadeAtual   " +
            "          from produtos " +
            "          where descricao like '%'|| #{description ,jdbcType=NVARCHAR}||'%'")
    List<ProductModel> getProductByDescription(@Param("description") String description);

    @Select(value = "Select codigo, " +
            "               descricao," +
            "               percentual_comissao as percentualComissao, " +
            "               valor_compra valorCompra," +
            "               valor_venda valorVenda," +
            "               quantidade_minima quantidadeMinima," +
            "               quantidade_atual quantidadeAtual   " +
            "          from produtos " +
            "          where codigo = #{id,jdbcType=INTEGER}")

    ProductModel getProductById(@Param("id") Long id);

    @Insert("insert into produtos (codigo, " +
            "descricao, " +
            "percentual_comissao," +
            "valor_compra," +
            "valor_venda," +
            "quantidade_minima," +
            "quantidade_atual)" +
            "values (produtos_seq.nextval," +
            "#{product.descricao ,jdbcType=NVARCHAR}," +
            "#{product.percentualComissao ,jdbcType=INTEGER, numericScale=2}," +
            "#{product.valorCompra ,jdbcType=DOUBLE,numericScale=2}," +
            "#{product.valorVenda ,jdbcType=DOUBLE,numericScale=2}," +
            "#{product.quantidadeMinima ,jdbcType=DOUBLE}," +
            "#{product.quantidadeAtual ,jdbcType=DOUBLE, })")
    void setProduct(@Param("product") ProductModel product);

}
