package com.multi.moneybug.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BasketDAO {
    @Autowired
    SqlSessionTemplate my;

    public List<BasketDTO> getAllBaskets(String userId) {
        return my.selectList("basket.basket_List", userId);
    }

    public void addToBasket(BasketDTO basket) {
        my.insert("basket.addToBasket", basket);
    }
    
    public boolean checkProductInBasket(String userId, int productId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("userId", userId);
        parameters.put("productId", productId);

        int count = my.selectOne("basket.checkProductInBasket", parameters);
        return count > 0;
    }
    
    public void updateProductInBasket(BasketDTO basket) {
        my.update("basket.updateProductInBasket", basket);
    }

	public List<BasketDTO> getOrderlists(List<Integer> selectedSeqs) {
		return my.selectList("basket.order_List", selectedSeqs);
	}

	public void updateProductCount(String userId, int productId, int seq, int newCount) {
		Map<String, Object> parameters = new HashMap<>();
        parameters.put("userId", userId);
        parameters.put("productId", productId);
        parameters.put("seq", seq);
        parameters.put("newCount", newCount);
        
        my.update("basket.updateBasket",parameters);
    }

	public void deleteProductFromBasket(String userId, int productId, int seq) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userId", userId);
	    params.put("productId", productId);
	    params.put("seq", seq);
	    my.delete("basket.deleteProductFromBasket", params);
	}

	public List<Integer> getSeqList() {
		return my.selectList("basket.seqList");
	}

}