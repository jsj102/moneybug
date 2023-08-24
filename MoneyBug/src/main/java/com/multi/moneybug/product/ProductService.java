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

}