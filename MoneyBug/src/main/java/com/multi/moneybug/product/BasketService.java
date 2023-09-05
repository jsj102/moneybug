package com.multi.moneybug.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BasketService {
    @Autowired
    BasketDAO basketDAO;

    public List<BasketDTO> getAllBaskets(String userId) {
        List<BasketDTO> basketList = basketDAO.getAllBaskets(userId);
        return basketList;
    }

    public void addToBasket(String userId, int productId, int productCount) {
        BasketDTO basket = new BasketDTO();
        basket.setUserId(userId);
        basket.setProductId(productId);
        basket.setProductCount(productCount);

        // 상품을 장바구니에 추가하는 DAO 메서드 호출
        basketDAO.addToBasket(basket);
    }

    public boolean checkProductInBasket(String userId, int productId) {
        return basketDAO.checkProductInBasket(userId, productId);
    }

    public void updateProductInBasket(String userId, int productId, int count) {
        BasketDTO basket = new BasketDTO();
        basket.setUserId(userId);
        basket.setProductId(productId);
        basket.setProductCount(count);

        basketDAO.updateProductInBasket(basket);
    }
    
    public List<BasketDTO> getOrderlists(List<Integer> selectedSeqs) {
        List<BasketDTO> basketList = basketDAO.getOrderlists(selectedSeqs);
        return basketList;
    }

    public void updateProductCount(String userId, int productId, int seq, int newCount) {
        basketDAO.updateProductCount(userId,productId,seq,newCount);
    }

    public void deleteProductFromBasket(String userId, int productId, int seq) {
        // userId, productId, seq를 이용하여 해당 상품을 장바구니에서 삭제하는 DAO 메서드 호출
        basketDAO.deleteProductFromBasket(userId, productId, seq);
    }

    public List<Integer> getSeqList() {
        return basketDAO.getSeqList();
    }
}

