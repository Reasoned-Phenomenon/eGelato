<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 관리 페이지</title>
</head>
<body>
	<h2>출고 관리</h2>

	<form>
		<div class="row">
			<div class="col-sm-7">

				<h4>주문서 현황</h4>
				<hr>
				<br>

				<div id="oustGrid"></div>
				<br>

			</div>
			<div class="col-sm-5">
				<h4>입출고 현황</h4>
				<div style="float: right; margin-bottom:10px; margin-top:15px;">
					<button type="button" class="btn cur-p btn-outline-primary"
						id="delBtn">삭제</button>
					<button type="button" class="btn cur-p btn-outline-primary"
						id="SaveBtn">저장</button>
				</div>
				<hr>
				<div id="prdtInstOustGrid"></div>
				<br>
				<div class="col-sm-2"></div>
			</div>
		</div>
	</form>

	<div id="prdtStcmodal" title="완제품 재고"></div>

	<script>

let dialog;

//modify구분하기위한 변수
let flag;

let orderShtDetaIdFlag;

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
const prdtInstOustGrid =  new Grid({
	el: document.getElementById('prdtInstOustGrid'),
	data : {
	  api: {
		  readData: { url: '${path}/biz/prdtInstOust.do', method: 'GET'},
		  modifyData : { url: '${path}/biz/modifyPrdtInstOust.do', method: 'PUT'} 
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders:['checkbox'],
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
		name : 'istOustDttm'
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
	},
	{
	  header: '주문 상세 코드',
	  name: 'orderShtDetaId',
	  hidden : true
		
	}
	]
	
});



// 출고 관리드(주문서 현황 그리드) 1에서 더블클릭시 완제품 현재고 modal창 실헹.
 oustGrid.on("dblclick", (ev) => {
	 oustGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, oustGrid.getColumns().length-1]
		});
	 	orderShtDetaIdFlag = oustGrid.getValue(ev.rowKey,'orderShtDetaId');
	 	// 완제품 현재고 modal창 띄우면서 필요로 하는 값 들고 감. 
		chooseRI(oustGrid.getRow(ev.rowKey));
	});
	
	
// 모달창 생성 함수. 완제품 재고
$(function () {
	dialog = $( "#prdtStcmodal" ).dialog({
		autoOpen: false,
		height: 523,
		width: 625,
		modal: true
	})
});
	
// 수정할 때 모달창.(출고량 입력)
function chooseRI(row) {
		
	if (prdtInstOustGrid.findRows({orderShtDetaId:orderShtDetaIdFlag}).length > 0) {
		
		//토스트
		toastr.clear();
		toastr.error('이미 입력하신 값입니다','Gelato');
		
		return;
	}
		
		
	dialog.dialog( "open" );
	 $('#prdtStcmodal').load("${path}/biz/prdtStcGrid.do",function () {
			console.log('현재고 modal 로드');
			chooseRWI(row);
	})
}
 	
function moveCR(gcr) {
	
	dialog.dialog("close");
	
	let rrc = prdtInstOustGrid.getRowCount();
	
	for( let i=0 ; i<gcr.length ; i++){
		
		gcr[i].orderShtDetaId = orderShtDetaIdFlag;
		gcr[i].rowKey = 1+rrc+i;
		prdtInstOustGrid.appendRow(gcr[i],{at:1+rrc+i});
		
	} 
	
}

 	//저장 버튼
	SaveBtn.addEventListener("click", function(){	
		console.log(prdtInstOustGrid.getRow(0))
		if (prdtInstOustGrid.getRow(0) != null) {
			
			if (confirm("저장하시겠습니까?")) {
				 flag = 'O'
				 prdtInstOustGrid.request('modifyData',{showConfirm : false});
				 
				//토스트
				toastr.clear();
				toastr.success('저장됐습니다.','Gelato');
				 
			}
			
		} else {
			
			//토스트
			toastr.clear();
			toastr.error('입력된 값이 없습니다.','Gelato');
		}
		
	});
 	
 	//삭제버튼
	delBtn.addEventListener("click", function(){
		if(confirm('삭제하시겠습니까?')) {
			prdtInstOustGrid.removeCheckedRows(false);
		}
	})
		
 	//컨트롤러 응답
 	prdtInstOustGrid.on('response', function (ev) {
 		console.log(ev)
 		if(flag == 'O') {
 			prdtInstOustGrid.readData(1);
 			flag = 'X';
 		}
 		
 	});	
 	
	prdtInstOustGrid.on('click',function (ev) {
		console.log(ev)
	})
	
</script>
</body>
</html>