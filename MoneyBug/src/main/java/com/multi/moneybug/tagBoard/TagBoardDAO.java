package com.multi.moneybug.tagBoard;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class TagBoardDAO {
	//mybatis di해주어야 함.	
		@Autowired
		SqlSessionTemplate my;
		
		
		public void insert(TagBoardDTO tagBoardDTO) {
			//mybatis 호출해서 db 처리 다 전담시킴.
			my.insert("tagboard.insert", tagBoardDTO);
		}
		
		public List<TagBoardDTO> tagBoardList(TagBoardDTO tagBoardDTO) {
	        return my.selectList("tagboard.list",tagBoardDTO);
	    }
		
		public TagBoardDTO one(int seq) {
			return my.selectOne("tagboard.one", seq);
		}
		
		public int update(TagBoardDTO tagBoardDTO) {
			return my.update("tagboard.update", tagBoardDTO);
		}
		
		public int delete(int seq) {
			return my.delete("tagboard.delete", seq);
		}
		
		
//확인 		
}


