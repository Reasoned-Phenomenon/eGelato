package com.gelato.app.rwmatr.dao;

import lombok.Data;

@Data
public class RwmatrVO {

	String rwmatrId;
	String vendId;
	String nm;
	String spec;
	String wkUnit;
	String safStc;
	
	String rwmName;
	
	//join
	String vendName;
}
