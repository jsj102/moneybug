package com.multi.moneybug.tagBoard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class TagBoardService {
	@Autowired
	TagBoardDAO tagBoardDAO;

	
	public void insert(TagBoardDTO tagBoardDTO ) {
		tagBoardDAO.insert(tagBoardDTO);
	}

	public List<TagBoardDTO> list(TagBoardPageDTO pageDTO) {
		return tagBoardDAO.list(pageDTO);
	}
	public List<TagBoardDTO> todaylist(TagBoardDTO tagBoardDTO) {
		return tagBoardDAO.todaylist(tagBoardDTO);
	}
	public List<TagBoardDTO> weeklylist(TagBoardDTO tagBoardDTO) {
		return tagBoardDAO.weeklylist(tagBoardDTO);
	}
	public List<TagBoardDTO> plmilist(int seq) {
		return tagBoardDAO.plmilist(seq);
	}
	public List<TagBoardDTO> taglist(TagBoardPageDTO pageDTO) {
		return tagBoardDAO.taglist(pageDTO);
	}
	public List<TagBoardDTO> searchlist(TagBoardPageDTO pageDTO) {
		return tagBoardDAO.searchlist(pageDTO);
	}
	
	public TagBoardDTO one(int seq) {
		return tagBoardDAO.one(seq);
	}
	
	public int update(TagBoardDTO tagBoardDTO) {
		return tagBoardDAO.update(tagBoardDTO);
	}
	

	public int delete(int seq) {
		return tagBoardDAO.delete(seq);
		
	}
	
	public int count() {
		return tagBoardDAO.count();
	}
	public int tagcount(String boardType) {
		return tagBoardDAO.tagcount(boardType);
	}
	public int searchcount(TagBoardPageDTO tagBoardPageDTO) {
		return tagBoardDAO.searchcount(tagBoardPageDTO);
	}

	public int updateViews(Long seq) {
		return tagBoardDAO.updateViews(seq);
	}

	public TagBoardDTO getBoardById(Long seq) {
	    return tagBoardDAO.getBoardById(seq);
	}


	
}
