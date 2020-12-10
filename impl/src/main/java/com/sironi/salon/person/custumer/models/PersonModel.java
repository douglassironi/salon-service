package com.sironi.salon.person.custumer.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PersonModel {
    Integer codigo;
    String  nome;
    Date    data_nasc;
    String  cpf_cnpj;
    String  rg_insc;
    String  endereco;
    String  bairro;
    String  cep;
    String  telefone;
    String  celular;
    String  email;
    String  cidade;
    String  uf;
}
