package com.sironi.salon.product.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductModel {
    Long codigo;
    String descricao;
    Double percentualComissao;
    Double valorCompra;
    Double valorVenda;
    Integer quantidadeMinima;
    Integer quantidadeAtual;
}
