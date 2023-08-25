package com.multi.moneybug.log;

/**
 * 로그 유형을 설명하는 ENUM입니다.<br>
 * 여기에 지정된 문자만 사용할 수 있습니다. <br>
 * <b>Info, WARNING, ERROR, TRACE <br></b>
 * Info는 일반 정보 및 시스템 상태를 기록하며 사용자에게 중요한 정보를 제공합니다. <br>
 * WARNING은 잠재적인 위험을 나타내는 수준입니다. <br>
 * ERROR는 실제로 발생할 위험을 나타내는 수준입니다. <br>
 * TRACE는 데이터 수집을 위해 설정된 수준입니다.<br>
 * */
public enum LogLevel {
	Info,WARNING,ERROR,TRACE
}

