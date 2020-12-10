package com.sironi.salon.custumer.models;

import com.sironi.salon.person.custumer.models.PersonModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CustomerModel extends PersonModel {
    String  tipo_pessoa = "C";
}
