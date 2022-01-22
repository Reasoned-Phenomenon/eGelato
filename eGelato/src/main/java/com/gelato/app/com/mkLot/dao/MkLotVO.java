package com.gelato.app.com.mkLot.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MkLotVO {

	String itemId;
	
	int seq;
	
	@JsonFormat(pattern = "rrMMdd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="rrMMdd")
	Date dt;
	
}
