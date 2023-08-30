package com.multi.moneybug.mission;

import java.sql.Date;

import lombok.Data;

@Data
public class MissionCompletionDTO {
	private int successId;
	private String missionId;
	private String userId;
	private Date completeDate;
	private boolean missionStatus;
}
