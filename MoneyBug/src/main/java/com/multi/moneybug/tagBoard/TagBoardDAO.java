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
		
		public List<TagBoardDTO> list(TagBoardPageDTO pageDTO) {
	        return my.selectList("tagboard.list",pageDTO);
	    }
		public List<TagBoardDTO> todaylist(TagBoardDTO tagBoardDTO) {
			return my.selectList("tagboard.todaylist",tagBoardDTO);
		}
		public List<TagBoardDTO> weeklylist(TagBoardDTO tagBoardDTO) {
			return my.selectList("tagboard.weeklylist",tagBoardDTO);
		}
		public List<TagBoardDTO> plmilist(int seq) {
			return my.selectList("tagboard.plmilist",seq);
		}
		public List<TagBoardDTO> taglist(TagBoardPageDTO pageDTO) {
			return my.selectList("tagboard.taglist",pageDTO);
		}
		public List<TagBoardDTO> searchlist(TagBoardPageDTO pageDTO) {
			return my.selectList("tagboard.searchlist",pageDTO);
		}
		
		public TagBoardDTO one(int seq) {
			return my.selectOne("tagboard.one", seq);
		}
		
		public int update(TagBoardDTO tagBoardDTO) {
			return my.update("tagboard.update", tagBoardDTO);
		}
		
		public int updateViews(Long boardId) {
		    return my.update("tagboard.updateViews", boardId);
		}
		
		public TagBoardDTO getBoardById(Long seq) {
		    return my.selectOne("tagboard.getBoardById", seq);
		}
		
		public int delete(int seq) {
			return my.delete("tagboard.delete", seq);
		}
		
		public int count() {
			return my.selectOne("tagboard.count");
		}
		public int tagcount() {
			return my.selectOne("tagboard.tagcount");
		}
		public int searchcount() {
			return my.selectOne("tagboard.searchcount");
		}
		
//확인 		
}


