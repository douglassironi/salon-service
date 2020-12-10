package com.sironi.salon.employer.models;

import com.sironi.salon.person.custumer.models.PersonModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@EqualsAndHashCode(callSuper=false)
public class EmployerModel extends PersonModel {
    String  tipo_pessoa = "A";
}
