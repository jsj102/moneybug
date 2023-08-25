package com.multi.moneybug.log;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 김영웅 <br>
 * 
 *         로그 서비스
 */
@Service
@Slf4j
@EnableScheduling
public class LogService {

	@Autowired
	LogDAO logDAO;

	/**
	 * 로그를 생성하는 메서드입니다.
	 *
	 * @param level   로그의 분류
	 * @param type    로그의 유형
	 * @param content 로그의 내용 (필요한 정보 작성)
	 */
	public LogDTO logBuilder(LogLevel level, LogType type, String content) {
		LogDTO customLog = new LogDTO();
		customLog.setContent(content);
		customLog.setLevel(level);
		customLog.setType(type);
		logDAO.insert(customLog);
		return customLog;
	}

	// 콘솔에 로그를 찍고 싶으면 이거 사용하세요
	public void logErrorConsole(LogDTO customLog) {
		log.error(customLog.getContent());
	}

	public void logWarningConsole(LogDTO customLog) {
		log.warn(customLog.getContent());
	}

	public void logInfoConsole(LogDTO customLog) {
		log.info(customLog.getContent());
	}

	public void logTraceConsole(LogDTO customLog) {
		log.trace(customLog.getContent());
	}

	public void insertLog(LogDTO customLog) {
		logDAO.insert(customLog);
	}

	public LogDTO readOneLevel(LogLevel level) {
		return logDAO.readOneLevel(level);
	}

	public LogDTO readOneType(LogType type) {
		return logDAO.readOneType(type);
	}

	public List<LogDTO> readList() {
		return logDAO.readList();
	}

	@Scheduled(cron = "0 0 0 * * 0") // 매주 일요일 오전 00:00에 전체 로그 삭제
	public void deleteAll() {
		logDAO.delete();
	}
}
