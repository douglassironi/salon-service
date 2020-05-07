package com.sironi.salon.custumer.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CustumerModel {
    Integer codigo;
    String  nome;
    String  telefone;
}
