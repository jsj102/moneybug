package com.multi.moneybug.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	@Autowired
	SqlSessionTemplate my;
	
	public List<ProductDTO> getAllProducts(ProductDTO productDTO) {
		return my.selectList("product.product_List", productDTO);
	}

}
