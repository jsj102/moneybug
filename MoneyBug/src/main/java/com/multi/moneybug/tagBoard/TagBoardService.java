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
	
	
}
