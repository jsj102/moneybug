package com.multi.moneybug.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LogController {
	
	@Autowired
	LogService logService;
	
	@RequestMapping("log/test")
	public void insert(LogDTO logDTO) {
		logDTO = logService.logBuilder(LogLevel.Info, LogType.ETC, "이거는 우리가 넣을코드");
		logService.logInfoConsole(logDTO);
	}
	
}
