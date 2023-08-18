package com.multi.moneybug.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    ProductDAO productDAO; // ProductDAO를 주입

    public List<ProductDTO> getAllProducts(ProductDTO productDTO) {
        // ProductDAO를 사용하여 상품 리스트를 조회
        List<ProductDTO> productList = productDAO.getAllProducts(productDTO);

        return productList;
    }
    
    public ProductDTO getProductById(int product_id) {
    	return productDAO.getProductById(product_id);
    }
}