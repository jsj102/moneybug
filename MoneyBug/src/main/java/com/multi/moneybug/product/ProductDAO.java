package com.multi.moneybug.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public List<OrderListDTO> orderlist(OrderListDTO orderListDTO) {
		return my.selectList("product.orderList");
	}

	public int updateOrderStatus(String orderNumber, String newStatus) {
	    Map<String, String> paramMap = new HashMap<String, String>(); // 타입 인자 명시
	    paramMap.put("orderNumber", orderNumber);
	    paramMap.put("newStatus", newStatus);
	    
	    return my.update("product.updateOrder", paramMap);
	}

	public List<OrderListDTO> myOrderList(String userId) {
		return my.selectList("product.myOrderList",userId);
	}

	public int payOrder(OrderListDTO orderListDTO) {
		return my.insert("product.orderInsert", orderListDTO);
	}

	public int delete(int productId) {
		return my.delete("product.delete", productId);
	}

	public int updateProducts(ProductDTO productDTO) {
		return my.update("product.update", productDTO);
	}


}