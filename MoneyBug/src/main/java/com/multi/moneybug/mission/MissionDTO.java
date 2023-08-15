package com.multi.moneybug.mission;

import java.sql.Date;

import lombok.Data;

@Data
public class MissionDTO {
	private int missionId;
	private String missionName;
	private String description;
	private boolean missonCondition;
	private int xpReward;
	private int pointReward;
	private Date missionStartDate;
	private Date missionEndDate;
}
