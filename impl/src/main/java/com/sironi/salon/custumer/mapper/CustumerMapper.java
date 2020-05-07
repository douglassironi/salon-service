package com.sironi.salon.custumer.mapper;


import com.sironi.salon.custumer.models.CustumerModel;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CustumerMapper {
    @Select("SELECT * FROM CLIENTES WHERE CODIGO = #{id}")
    CustumerModel getCustumerById(@Param("id") Long id);

    @Select("SELECT * FROM CLIENTES WHERE nome = #{name}")
    List<CustumerModel> getCustumerByName(@Param("name") String name);
}
