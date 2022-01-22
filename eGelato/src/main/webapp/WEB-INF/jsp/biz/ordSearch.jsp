<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>주문서 관리 조회</title>

</head>
<body>
	<main>
	  <div>
	  	<br>
		<h3>주문서 관리 조회</h3>
	     <div>
	     	
	      <form id="" name="" method="">
	      	<div>
	      		<ul>
	      			<li>
	      				<div>
	      					
	      				  		<br>
	      				  	    <label>진행 구분</label>
	      				  		<label for="radio-1">
	      				  			<input type="radio" name="stFgRadio" id="stFg" value="진행">
	      				  			<span>진행</span>
	      				  		</label>
	      				  		<label for="radio-2">
	      				  			<input type="radio" name="stFgRadio" id="stFgR" value="완료">
	      				  			<span>완료</span>
	      				  		</label>
	      				  		<label for="radio-3">
	      				  			<input type="radio" name="stFgRadio" id="stFgRi" value="전체" checked> 
	      				  			<span>전체</span>
	      				  		</label>
	      				  	
	      				</div>
	      			</li>
	      			<li>
	      				<div>
	      					<label>주문일자</label>
	      					<input type="date" id="orderDt"> ~ <input type ="date" id="oustDt">
	      				</div>
	      			</li>
	      			<li>
	      				<div>
	      					<label>거래처</label>
	      					<input type="text" id="vendId" name="vendId">
	      					<button type="button" id="BtnVend">찾아보기</button>&ensp;&ensp;&ensp;
	      					
	      					<label>제품코드</label>
	      					<input type="text" id="prdtId" name="prdtId">
	      					<button type="button" id="BtnPrdt">찾아보기</button> &ensp;
	      					
	      				<button type="button" class="btn cur-p btn-outline-primary" id="btnRst">새자료</button>
	      				<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>
	      				<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
						<button type="button" class="btn cur-p btn-outline-primary" id="btnExcel">Excel</button>
						<button type="button" class="btn cur-p btn-outline-primary" id="btnprint">인쇄</button>
						
						  <br>
	      				</div>
	      			</li>
	      		</ul>
	      	</div>
	      </form>
	     </div>
	  </div> 
 </main>

	<div id="ordGrid" style="width: 100%"></div>
	<div id="modal" style="width: 100%"></div>

   	 
	
<script>
let dialog;


var Grid = tui.Grid;

//그리드 테마
Grid.applyTheme('striped', {
	  cell: {
	    header: {
	      background: '#eef'
	    },
	    evenRow: {
	      background: '#fee'
	    }
	  }
});

//그리드 생성
var ordGrid = new Grid({
	el: document.getElementById('ordGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/biz/findOrderList.do', method: 'GET'},
	  },
	  contentType: 'application/json'
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	columns:[
			{
			  header: '주문코드',
			  name: 'orderId',
			  align: 'center'
		      
			},
			{
			  header: '업체명',
			  name: 'vendName',
			  align: 'center'
	          
			},
			{
			  header: '주문일자',
			  name: 'orderDt',
			  align: 'center'
		      
			},
			{
			  header: '납기일자',
			  name: 'oustDt',
			  align: 'center'
			  
			},
			{
			  header: '진행상황구분',
			  name: 'stFg',
			  align: 'center'
		     
			},
			
			{
			  header: '제품코드',
			  name: 'prdtId',
			  align: 'center'
			  
			},
			{
        	  header: '수량',
		      name: 'qy',
		      align: 'center'
		      
			},
			{
              header: '비고',
			  name: 'remk',
			  align: 'center'
			  
			}
		]
});
	

	
	// 조회 버튼. // 해당날짜 조회 // 거래처 조회 // 제품코드 조회// 진행구분 라디오로 조회 =>  mapper-xml에서 if로 조건으로 나눔.
 	$("#btnFind").on(
 			"click", function choicDate() {
 			var orderDt = document.getElementById("orderDt").value;
 			var oustDt = document.getElementById("oustDt").value;
 			
 			var vendId = document.getElementById("vendId").value;
 			var prdtId = document.getElementById("prdtId").value;
 			var stFg = $('input[name="stFgRadio"]:checked').val();
 			
 			console.log(orderDt);
 			console.log(oustDt);
 			console.log(vendId);
 			console.log(prdtId);
 			console.log(stFg);
 			
 			ordGrid.readData(1, {'orderDt':orderDt, 'oustDt':oustDt, 'vendId':vendId, 'prdtId':prdtId, 'stFg':stFg }, true);
 			
 		});
	
	// 
		
	// 모달창 생성 함수.
	$(function () {
		dialog = $( "#modal" ).dialog({
			autoOpen: false,
			height: 500,
			width: 700,
			modal: true,
			buttons: {
			// 선택하는 버튼 넣어두기!. 옵션? 어떤거 잇는 지 찾아보기.
			Cancel: function() {
			
			}
			}
		})
	});
	
	// 거래처 찾아보기 버튼 
	BtnVend.addEventListener("click", function() {
		console.log("444444");
		console.log("모달클릭")
		dialog.dialog( "open" );
		
		 // 컨트롤러에 보내주고 따로 모달은 jsp 만들 필요가 없으니깐  
		 $('#modal').load("${path}/biz/vendModal.do",function () {
			console.log('로드됨')
			vendListGrid.readData(1,{}, true);
		})
		
	})
	
	// 제품코드 찾아보기 버튼
	BtnPrdt.addEventListener("click", function() {
		console.log("55555");
		console.log("버튼클릭");
		dialog.dialog("open");
	
		$("#modal").load("${path}/biz/prdtModal.do",function () {
			console.log("모달로드");
			prdtListGrid.readData(1,{}, true);
		})
	})
	
	
	
	//  거래처 인풋 태그에 값들어가게 함.	
	 function  getModalData(vendParam) {	
		console.log(vendParam);
		$("#vendId").val(vendParam);
		dialog.dialog("close");
	} 
	// 제품코드 인풋 태그에 값들어가게 함.
	function getModal(prdtParam) {
		console.log(prdtParam);
		$("#prdtId").val(prdtParam);
		dialog.dialog("close");
	}
	
		

</script>	
	
</body>
</html>