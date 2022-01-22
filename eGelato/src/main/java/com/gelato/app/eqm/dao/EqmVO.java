package com.gelato.app.eqm.dao;

import lombok.Data;

@Data
public class EqmVO {
	String eqmId;	//설비코드
	String eqmName;	//설비명
	String modelNo;	//제품고유번호
	String vendId;	//업체코드
	String tempMax;	//최고온도
	String tempMin;	//최저온도
	String chckPerd;//점검주기
	String regDt;	//설비등록일자
	String mngr;	//관리자
	String eqmImg;	//설비이미지
	String purcDt;	//구매일자
	String fg;		//설비구분
	String spec;	//설비규격
	String useYn;	//사용여부
	String uph;		//uph
	
	String code;
	String codeNm;
	String codeId;
	
	String prcsId;
	String nm;
	String yn;
	
	String eqmNonYn;	//비가동설비 체크
	
	String gubun;
}
