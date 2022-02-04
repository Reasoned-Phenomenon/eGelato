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
	
	//라인,공정,uph
	String bomId;
	String prdtId;
	String prdtNm;
	String lineId;
	String prcsId;
	String prcsNm;
	String eqmId;
	String eqmName;
	String uph;
}
