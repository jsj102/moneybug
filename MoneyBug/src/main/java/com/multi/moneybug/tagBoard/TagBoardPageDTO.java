package com.multi.moneybug.tagBoard;

import lombok.Data;

@Data
public class TagBoardPageDTO {
    private int start;
    private int end;
    private int page;
    private String searchKeyword;
    private String boardType;
    

    public void setStartEnd(int page, int totalCount) {
        // 페이지당 표시할 게시글 수
        int itemsPerPage = 10;
        // 총 페이지 수
        int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);

        this.page = page;
        
        // 페이지 번호가 총 페이지 수를 초과하지 않도록 보정
        if (page > totalPages) {
            page = totalPages;
        }

        // 마지막 게시글 번호 계산
        int lastItem = totalCount;
        // 현재 페이지에서 표시할 게시글 수만큼 뺀 값이 마지막 게시글 번호가 됨
        int lastItemOnPage = lastItem - (itemsPerPage * (page - 1));

        // start와 end 설정
        start = Math.max(lastItemOnPage - (itemsPerPage - 1), 1);
        end = lastItemOnPage;
    }
}

