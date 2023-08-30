package com.multi.moneybug.log;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LogDAO {
	@Autowired
	SqlSessionTemplate my;

	public void insert(LogDTO logDTO) {
		my.insert("log.insert", logDTO);
	}

	public LogDTO readOneLevel(LogLevel level) {
		return my.selectOne("log.readOneLevel", level);
	}

	public LogDTO readOneType(LogType type) {
		return my.selectOne("log.readOneType", type);
	}

	public List<LogDTO> readList() {
		return my.selectOne("log.readList");
	}
	
	public void delete() {
		my.delete("log.delete");
	}
}
