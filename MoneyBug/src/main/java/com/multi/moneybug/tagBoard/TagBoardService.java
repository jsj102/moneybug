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

	public List<TagBoardDTO> list(TagBoardDTO tagBoardDTO) {
		return tagBoardDAO.tagBoardList(tagBoardDTO);
	}
	
	public TagBoardDTO one(int SEQ) {
		return tagBoardDAO.one(SEQ);
	}
	
	public int update(TagBoardDTO tagBoardDTO) {
		return tagBoardDAO.update(tagBoardDTO);
	}

	public int delete(int seq) {
		return tagBoardDAO.delete(seq);
		
	}
	
	
}
