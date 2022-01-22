package com.gelato.app.rwmatr.infer.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RwmatrInferVO {

	String orderId;
	String rwmatrOrderDetaId;
	String rwmatrId;
	String nm;
	String qy;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date dt;
	String inferId;
	String deta;
	
	String startDate;
	String endDate;
	String rwmName;
	
	//join
	String vendName;
	
	
}
