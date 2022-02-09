<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 관리 페이지</title>
</head>
<body>

	<div>
	<br>
		<h1>출고 관리</h1>
	</div>

	<form>
		<div class="row">
		<div class="col-sm-7">
			
	    	
			<h3>주문서 현황</h3>
			<hr>
			<br>
			
			<div id="oustGrid"></div>
			<br>
			
		</div>
		<div class="col-sm-5">
			<h3>입출고 현황</h3>
			<div style="float: right;">
			<button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
			</div>
			<hr>
			<div id="oustLotGrid"></div>
			<br>
			<div class="col-sm-2">
			
			</div>
		</div>
	</div>
</form>

<div id="prdtStcmodal" title="완제품 재고"></div>

<script>

let dialog;

// 그리드 생성
var Grid = tui.Grid;




// 출고 관리 그리드 1. (좌측 생성.)
 var oustGrid = new Grid({
	el: document.getElementById('oustGrid'),
	data : {
		  api: {
		    readData: { url: '${path}/biz/findOustList.do', method: 'GET'},
		  },
		  contentType: 'application/json',
		  
		},
  	rowHeaders:['rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 500,
  	columns:[
  			{
			  header: '주문 상세 코드',
			  name: 'orderShtDetaId'
			
			},
			{
			   header: '주문 코드',
			   name: 'orderId'
				
			},
			{
			  header: '제품 코드',
			  name: 'prdtId'
			  
			},
			{
			  header: '제품 명',
			  name: 'prdtNm'
				  
			},
			{
			  header: '주문 수량',
			  name: 'qy'
			}
			
		]
});

// 출고 관리 그리드 2. (우측에 생성.)
const oustLotGrid =  new Grid({
	el: document.getElementById('oustLotGrid'),
	data : {
	  api: {
		  readData: { url: '${path}/biz/oustLotList.do', method: 'GET'},
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 200,
	columns:[
	{
		header: '제품 코드',
		name: 'prdtId'	  
	},	
	{
		header : '완제품 LOT 번호',
		name : 'lotNo'
	}, 
	{
		header : '일출고 날짜',
		name : 'istOustDttm',
	},
	{
		header : '입고량',
		name : 'istQy'
	}, 
	{
		header : '출고량',
		name : 'oustQy'
		
	},
	{
		header : '유통기한',
		name : 'expdate'
	}
	]
	
});

// 출고 관리드(주문서 현황 그리드) 1에서 더블클릭시 완제품 현재고 modal창 실헹.
 oustGrid.on("dblclick", (ev) => {
	 oustGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, oustGrid.getColumns().length-1]
		});
	 
	 	// 완제품 현재고 modal창 띄우면서 필요로 하는 값 들고 감. 
		pid = oustGrid.getRow(ev.rowKey).prdtId;
		console.log(pid);
		oqy = oustGrid.getRow(ev.rowKey).qy;
		console.log(oqy);
		pnm = oustGrid.getRow(ev.rowKey).prdtNm;
		console.log(pnm);
		
		chooseRI(pid,oqy,pnm);
	});
	
	
	// 모달창 생성 함수. 완제품 재고
	$(function () {
		dialog = $( "#prdtStcmodal" ).dialog({
			autoOpen: false,
			height: 500,
			width: 700,
			modal: true
		})
	});
	
 	// 수정할 때 모달창.(출고량 입력)
	function chooseRI(pid,oqy,pnm) {
		dialog.dialog( "open" );
		 $('#prdtStcmodal').load("${path}/biz/prdtStcGrid.do",function () {
				console.log('현재고 modal 로드');
				chooseRWI(pid,oqy,pnm);
		})
 	}
 	
 	// TODO 함수명 바꾸기. 의미 알 수 있게.
 	function moveCR(gcr) {
 		dialog.dialog("close");
 		
 		// 값이 들어온거 확인. 모달창에서 넘겨온 값.
 		console.log(gcr);
 		
 		let rrc = oustLotGrid.getRowCount();
		console.log(rrc);
		for( let i=(rrc-gcr.length) ; i<rrc ; i++){
			//appendRow 한 다음에 setValue 시키기
			
			console.log(787878787878);
			
			// modal창에서 그리드2(입출고 테이블)에서 값 넘겨주기.
			oustLotGrid.setValue(i, 'prdtId', pid);
			oustLotGrid.setValue(i, 'lotNo', lno);
			oustLotGrid.setValue(i, 'istOustDttm', ioutd);
			oustLotGrid.setValue(i, 'istQy', isqy);
			oustLotGrid.setValue(i, 'oustQy', oqy);
			oustLotGrid.setValue(i, 'expdate', edate);
		
			
			console.log(pid); // 제품 코드 번호 값 확인.
			console.log(lno); // 로트번호 값 확인.
			console.log(ioutd); // 입출고 날짜 값 확인.
			console.log(isqy);  // 입고량 값 확인.
			console.log(oqy);  // 출고량은 값 값 확인.
			console.log(edate); // 유통기한 값 확인.

 			
		}
 	}
 	
 	// 저장 버튼 이벤트.
/*  	$("#SaveBtn").on("click",function() {
 		
 	} */
 	
 
		
		
	
	

</script>
</body>
</html>