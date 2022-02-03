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
		<div class="col-sm-6">
			
	    	<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
	    	<button type="button" class="btn cur-p btn-outline-primary" id="btnAdd">등록</button>
			<h3>주문서 현황</h3>
			<br>
			
			<div id="oustGrid"></div>
			<br>
			
		</div>
		<div class="col-sm-6">
			<h3>입출고 현황</h3>
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

//그리드 테마
Grid.applyTheme('striped', {
	cell : {
		header : {
			background : '#eef'
		},
		evenRow : {
			background : '#fee'
		},
		selectedHeader : {
	    	background : '#FFFFFF'
	    }
	}
});


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
  	columns:[
  			{
			  header: '주문 코드',
			  name: 'orderId'
			
			},
			{
			   header: '주문 상세 코드',
			   name: 'orderShtDetaId'
				
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

// 출고 관리드 1에서 더블클릭시 해당 정보 출력.
 oustGrid.on("dblclick", (ev) => {
	 oustGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, oustGrid.getColumns().length-1]
		});
	 
	 pdi = oustGrid.getRow(ev.rowKey).prdtId;
	 console.log(pdi);	
	 oustLotGrid.readData(1,{'prdtId':pdi}, true);	
		
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
	
	// 수정할 때 모달창.
	
	

</script>
</body>
</html>