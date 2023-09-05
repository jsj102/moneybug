package com.multi.moneybug.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    ProductDAO productDAO; // ProductDAO를 주입

    public List<ProductDTO> getAllProducts(ProductPageDTO productpageDTO) {
        return productDAO.getAllProducts(productpageDTO);
    }
    
    public ProductDTO getProductById(int productId) {
    	ProductDTO productDTO = productDAO.getProductById(productId);
    	return productDTO;
    }
    
	public List<ProductDTO> getProductsByIds(List<Integer> productIds) {
		List<ProductDTO> productByIdList = productDAO.getProductsByIds(productIds);
		return productByIdList;
	}
    
    public List<ProductDTO> list(ProductDTO productDTO) {
    	return productDAO.list(productDTO);
    }

	public void insertNewProduct(ProductDTO productDTO) {
		productDAO.insert(productDTO);
	}

	public int count() {
		return productDAO.count();
	}

	public List<OrderListDTO> orderlist(OrderListDTO orderListDTO) {
		return productDAO.orderlist(orderListDTO);
	}

	public boolean updateOrderStatus(String orderNumber, String newStatus) {
	    int rowsAffected = productDAO.updateOrderStatus(orderNumber, newStatus);
	    return rowsAffected > 0; // 업데이트된 행이 있을 경우 true 반환
	}

	public List<OrderListDTO> myOrderList(String userId) {
		return productDAO.myOrderList(userId);
	}

	public int payOrder(OrderListDTO orderListDTO) {
		return productDAO.payOrder(orderListDTO);
		
	}

	public int goManageDelete(int productId) {
		return productDAO.delete(productId);
	}

	public int updateProduct(ProductDTO productDTO) {
		return productDAO.updateProducts(productDTO);
	}

}