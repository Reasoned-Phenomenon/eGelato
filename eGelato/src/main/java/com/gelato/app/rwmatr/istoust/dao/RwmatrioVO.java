package com.gelato.app.rwmatr.istoust.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RwmatrioVO {

	String rwmatrId;
	String lotNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	Date istOustDttm;
	String istQy;
	String oustQy;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date expdate;
	String qy;
	String excpQy;
	String safStc;
	String remk;
	
	String startDate;
	String endDate;
	String rwmName;
	
	//join
	String rwmatrOrderDetaId;
	String orderId;
	String nm;
	String vendName;
	String passQy;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date dt;
	
}
