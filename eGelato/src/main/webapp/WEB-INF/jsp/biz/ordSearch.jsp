<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>주문서 조회</title>

</head>
<body>
	<main>
	  <div>
	  	<br>
		<h1>주문서 관리 조회</h1>
	     <div>
	     	
	      <form>
	      	<div>
	      		<ul>
	      			<li>
	      				<div>
	      					
	      				  		<br>
	      				  	    <label>진행 구분</label>
	      				  		<label for="radio-1">
	      				  			<input type="radio" name="stFgRadio" id="stFg" value="ACCEPT">
	      				  			<span>진행</span>
	      				  		</label>
	      				  		<label for="radio-2">
	      				  			<input type="radio" name="stFgRadio" id="stFgR" value="OUTSTC">
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
	      					<label>주문 일자</label>
	      					<input type="date" id="startDt"> ~ <input type ="date" id="endDt">
	      					<label>납기 일자</label>
	      					<input type="date" id="startedDt"> ~ <input type ="date" id="endedDt">
	      				</div>
	      			</li>
	      			<li>
	      				<div>
	      					<label>거래처</label>
	      					<input type="text" id="vendName" name="vendName" readonly>
	      					<button type="button" id="BtnVend">찾아보기</button>&ensp;&ensp;&ensp;
	      					
	      					<label>제품명</label>
	      					<input type="text" id="prdtNm" name="prdtNm" readonly>
	      					<button type="button" id="BtnPrdt">찾아보기</button> &ensp;
	      					
	      			
	      				<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	      				<button type="button" class="btn cur-p btn-outline-primary" id="btnFind">조회</button>

						  <br>
	      				</div>
	      			</li>
	      		</ul>
	      	</div>
	      </form>
	     </div>
	  </div> 
 </main>

	<div id="ordGrid" style="width: 90%"></div>
	<div id="prdtListmodal" title="제품 목록"></div>
	<div id="vendListmodal" title="거래처 목록"></div>

   	 
	
<script>
let prdtDialog;

let vendDialog;


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
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	bodyHeight: 600,
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
			  header: '제품명',
			  name: 'prdtNm',
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
 			var startDt = document.getElementById("startDt").value;
 			var endDt = document.getElementById("endDt").value;
 			
 			var startedDt = document.getElementById("startedDt").value;
 			var endedDt = document.getElementById("endedDt").value;
 			
 			var vendName = document.getElementById("vendName").value;
 			var prdtNm = document.getElementById("prdtNm").value;
 			
 			var stFg = $('input[name="stFgRadio"]:checked').val();
 			
 			console.log(startDt);
 			console.log(endDt);
 			console.log(startedDt);
 			console.log(endedDt);
 			console.log(vendName);
 			console.log(prdtNm);
 			console.log(stFg);
 			
 			
 			
 			ordGrid.readData(1, {'startDt':startDt, 
 								 'endDt':endDt, 
 								 'startedDt':startedDt, 
 								 'endedDt':endedDt,
 								 'vendName' :vendName, 
 								 'prdtNm':prdtNm, 
 								 'stFg':stFg }, true);
 			
 		});
	
		
	// 모달창 생성 함수. 거래처
	$(function () {
		vendDialog = $( "#vendListmodal" ).dialog({
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
	
	// 모달창 생성 함수. 제품
	$(function () {
		prdtDialog = $( "#prdtListmodal" ).dialog({
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
		
		console.log("모달클릭")
		vendDialog.dialog( "open" );
		
		 // 컨트롤러에 보내주고 따로 모달은 jsp 만들 필요가 없으니깐  
		 $('#vendListmodal').load("${path}/biz/vendModal.do",function () {
			console.log('로드됨')
			vendListGrid.readData(1,{}, true);
		})
		
	})
	
	// 제품코드 찾아보기 버튼
	BtnPrdt.addEventListener("click", function() {
		
		console.log("버튼클릭");
		prdtDialog.dialog("open");
	
		$("#prdtListmodal").load("${path}/biz/prdtModal.do",function () {
			console.log("제품코드 modal");
			prdtListGrid.readData(1,{}, true);
		})
	})
	
	
	
	//  거래처 인풋 태그에 값들어가게 함.	
	 function  getModalData(vendParam) {	
		console.log(vendParam);
		$("#vendName").val(vendParam);
		vendDialog.dialog("close");
	} 
	// 제품코드 인풋 태그에 값들어가게 함.
	function getModal(prdtParam) {
		console.log(prdtParam);
		$("#prdtNm").val(prdtParam);
		prdtDialog.dialog("close");
	}
	
		

</script>	
	
</body>
</html>