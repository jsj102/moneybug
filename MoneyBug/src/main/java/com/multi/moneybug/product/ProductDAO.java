package com.multi.moneybug.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	@Autowired
	SqlSessionTemplate my;
	
	public List<ProductDTO> getAllProducts(ProductPageDTO productpageDTO) {
		return my.selectList("product.product_List", productpageDTO);
	}
	
	public ProductDTO getProductById(int productId) {
		ProductDTO productDTO = my.selectOne("product.product_detail", productId);
		return productDTO;
	}
	
	 public List<ProductDTO> getProductsByIds(List<Integer> productIds) {
	        return my.selectList("product.getProductsByIds", productIds);
	 }

	public List<ProductDTO> list(ProductDTO productDTO) {
		return my.selectList("product.manageList");
	}

	public void insert(ProductDTO productDTO) {
		my.insert("product.insert", productDTO);
	}

	public int count() {
		return my.selectOne("product.count");
	}
}