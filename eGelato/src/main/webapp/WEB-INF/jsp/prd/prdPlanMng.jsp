<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 관리</title>
</head>
<style>
th, td {
	padding: 5px;
}

</style>
<body>

	<div>
		<br>
		<h2 id="title">생산계획관리</h2>
		<br>
	</div>
	<br>
	<div id="tabs">
		<ul>
			<li><a href="#ManageTab">관리</a></li>
			<li><a href="#InsertTab">등록</a></li>
		</ul>
		
		<div id="ManageTab">
				<div id="PlanDetaGrid" ></div> <br>
				<button type="button"  id="btnSearchPlan">계획조회</button>
				<button type="button"  id="btnPlanDel">계획취소</button>	
		</div>
		
		<div id="InsertTab">
			<table>
				<tbody>
					<tr>
						<th>생산 계획명</th>
						<td><input type="text" id="planName" required></td>
					</tr>
					<tr>
						<th>생산 계획 일자</th>
						<td><input type="date" id="planDt" required></td>
						<td>
							<button type="button"  id="btnClear">초기화</button>
						</td>
					</tr>
				</tbody>
			</table>
			<div id="PlanDetaInsGrid"></div> <br>
			<button type="button"  id="btnOrderSht">주문서조회</button>
			<button type="button"  id="btnPlanIns">계획등록</button>
			<button type="button"  id="btnAdd">행 추가</button>
			<button type="button"  id="btnDel">행 삭제</button>
		</div>
	</div>
	
	<!-- 주문서 모달창 -->
	<div id="OrderShtDialog" title="주문서 목록"></div>

	<!-- 계획조회 모달창 -->
	<div id="SearchPlanDialog" title="계획조회"></div>
	
	<!-- 제품 목록 모달창 -->
	<div id="PrdtDialog" title="제품 목록"></div>
	
	<!-- 계획 상세 그리드 - 주문서 -->
	<div id="PlanDetaGrid"></div>
	
	<!-- 계획 상세 그리드 - 추가-->
	<div id="PlanDetaInsGrid"></div>
	
	<script>
	let rk = '';
	
	//생산계획일자 현재날짜 기본 설정
	document.getElementById('planDt').value = new Date().toISOString()
			.substring(0, 10);
	
	//탭 생성
	$( "#tabs" ).tabs();
	
	//초기화버튼
	$("#btnClear").on(
				"click",
				function() {
					$("#planName").val('');
					document.getElementById('planDt').value = new Date().toISOString().substring(0, 10);
					PlanDetaInsGrid.clear();
					$("#btnAdd").show();
					$("#btnDel").show();
				});
	
	//토스트옵션
	toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
		}
		
	//계획상세 그리드 생성
		var Grid = tui.Grid;

		//그리드 테마
		/* Grid.applyTheme('striped', {
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
		}); */

		// 그리드 생성 : 관리
		const PlanDetaGrid = new Grid({
			el : document.getElementById('PlanDetaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/chooseOrder.do',method : 'GET'},
					modifyData : { url: '${path}/prd/modifyCanPrdPlan.do', method: 'PUT'} 
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			width:1500,
			columns : [ {
				header : '생산계획코드',
				name : 'planDetaId'
			}, {
				header : '제품명',
				name : 'prdtNm',
			}, {
				header : '제품코드',
				name : 'prdtId',
			}, {
				header : '주문코드',
				name : 'orderId',
			}, {
				header : '계획량',
				name : 'qy',
				align: 'right',
			}, {
				header : '생산일수',
				name : 'prodDcnt',
				align: 'right',
			}, {
				header : '작업우선순위',
				name : 'priort',
				align: 'right',
			}, {
				header : '작업상태',
				name : 'fg',
				hidden : true
			},{
				header : '생산계획명',
				name : 'name',
				hidden : true
			}]
		});
		
		// 그리드 생성 : 등록
		const PlanDetaInsGrid = new Grid({
			el : document.getElementById('PlanDetaInsGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/chooseOrder.do',method : 'GET'},
					modifyData : { url: '${path}/prd/modifyPrdPlan.do', method: 'PUT'} 
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : [ 'checkbox', 'rowNum' ],
			selectionUnit : 'row',
			width:1500,
			columns : [ {
				header : '주문코드',
				name : 'orderId',
			}, {
				header : '제품명',
				name : 'prdtNm',
				//editor : 'text',
				validation: {
					required: true
		        }
			}, {
				header : '제품코드',
				name : 'prdtId',
				validation: {
					required: true
		        }
			}, {
				header : '계획량',
				name : 'qy',
				editor : 'text',
				align: 'right',
				validation: {
					required: true
		        }
			}, {
				header : '생산일수',
				name : 'prodDcnt',
				editor : 'text',
				align: 'right',
				validation: {
					required: true
		        }
			}, {
				header : '작업우선순위',
				name : 'priort',
				editor : 'text',
				align: 'right',
				validation: {
					required: true
		        }
			}, {
				header : '비고',
				name : 'remk',
				editor : 'text',
			},{
				header : '생산계획명',
				name : 'name',
				hidden : true
			}],
			summary : {
				positioin : 'bottom',
				
			}
		});
	
		//컨트롤러 응답
		PlanDetaInsGrid.on('response', function (ev) {
			console.log(ev)
		});
		
	// 종료
	
	//주문서 조회 클릭하면 모달창 생성하기

		// 주문코드 받아서 readData에 파라미터값으로 넘겨주기
		function chooseOI(osg){
			console.log(osg);
			PlanDetaInsGrid.readData(1,{orderId:osg}, true);
			OrderShtDialog.dialog("close");
			$("#btnAdd").hide();
			$("#btnDel").hide();
		}
		
		// 모달창 생성
		var OrderShtDialog = $("#OrderShtDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});

		$("#btnOrderSht").on(
				"click",
				function() {
					console.log("11111")
					$("#planName").val('');
					document.getElementById('planDt').value = new Date().toISOString().substring(0, 10);
					OrderShtDialog.dialog("open");
					console.log("111112222")
					$("#OrderShtDialog").load("${path}/prd/orderShtDialog.do",
							function() {
								console.log("주문창 로드")
							})
				});
	//종료

	//계획조회 클릭하면 모달창 생성하기
		/* // 주문코드 받아서 검색창에 띄우기
		function selectPnm(pnm){
			console.log(pnm);
			$("#planName").val(pnm);
		}
		function selectPdt(pdt){
			console.log(pdt);
			$("#planDt").val(pdt);
		} */
	
		// 주문코드 받아서 readData에 파라미터값으로 넘겨주기
		function choosePI(spg, spn){
			console.log(spg);
			console.log(spn);
			PlanDetaGrid.readData(1,{planId:spg}, true);
			
			for ( i =0 ; i <= PlanDetaGrid.getRowCount(); i++) {
				console.log(i);
				PlanDetaGrid.setValue(i,'name',spn);
			} 
			
			console.log(111);
			SearchPlanDialog.dialog("close");
		}
	
		//모달창 생성
		var SearchPlanDialog = $("#SearchPlanDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});
		
		$("#btnSearchPlan").on(
				"click",
				function() {
					/* if(!$("#planName").val()) { */
						console.log("33333")
						$("#planName").val('');
						SearchPlanDialog.dialog("open");
						console.log("44444")
						$("#SearchPlanDialog").load(
								"${path}/prd/searchPlanDialog.do", function() {
									console.log("계획조회창 로드")
								})
					//}
				});
	//종료
	
	//제품목록 클릭하면 모달창 생성하기
		function selectPr(prid,prnm){
			console.log(prnm);
			console.log(prid);
			PlanDetaInsGrid.setValue(rk, "prdtNm", prnm, true);
			PlanDetaInsGrid.setValue(rk, "prdtId", prid, true);
			PrdtDialog.dialog( "close" );
		}
	
		function callPrdtModal(){
			// 모달창 생성
			PrdtDialog = $("#PrdtDialog").dialog({
				modal : true,
				autoOpen : false,
				height: 600,
				width: 500
			});
			
		    console.log("11111")
		    PrdtDialog.dialog( "open" );
		    $("#PrdtDialog").load(
								"${path}/prd/prdtDialog.do", function() {
									console.log("계획조회창 로드")
								})
		}
		
		PlanDetaInsGrid.on('dblclick', (ev) => {
			rk = ev.rowKey;
			console.log(ev)
		    if (ev.columnName === 'prdtNm') {
		    	console.log(PlanDetaInsGrid.getRow(ev.rowKey).prdtNm);
					console.log("1111")
		    		callPrdtModal();
			}
			console.log("1111111")
		});
			
	//종료
	
	// 행추가
	btnAdd.addEventListener("click", function() {
		console.log('등록');
		PlanDetaInsGrid.appendRow({});
	});
	
	// 행삭제
	btnDel.addEventListener("click", function() {
		console.log('삭제')
		if(confirm("삭제하시겠습니까?")){ 
			PlanDetaInsGrid.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
		}
	});
	
	//계획 등록
	btnPlanIns.addEventListener("click", function() {
		PlanDetaInsGrid.blur();
		let planName = document.getElementById('planName').value;
		console.log(planName);
		
		if (true) {
			for ( j = 0 ; j < PlanDetaInsGrid.getRowCount() ; j++) {
				if (PlanDetaInsGrid.getData()[j].prdtNm == '') {
					 
					toastr.clear()
					toastr.success( ('제품을 선택해주세요.'),'Gelato',{timeOut:'1000'});
					
				 }  else if (PlanDetaInsGrid.getData()[j].qy == '') {
	
					 toastr.clear()
					toastr.success( ('계획량을 입력해주세요.'),'Gelato',{timeOut:'1000'});
					
				 } else if (PlanDetaInsGrid.getData()[j].prodDcnt == '') {
	
					 toastr.clear()
					toastr.success( ('생산일수를 입력해주세요.'),'Gelato',{timeOut:'1000'});
				 
				 } else if (PlanDetaInsGrid.getData()[j].priort == '') {
					 
					toastr.clear()
					toastr.success( ('작업우선순위를 입력해주세요.'),'Gelato',{timeOut:'1000'});
				 	
				 }  
			}
		}
		else if(planName.trim() == ''){
			 
			//입력값 없을 때,제목 입력안했을 때 toast 띄우기.
			toastr.clear()
			toastr.success( ('생산 계획명을 입력해주세요.'),'Gelato',{timeOut:'1000'});
			
		 } else {
			 
				console.log(planName);

				for ( i =0 ; i <= PlanDetaInsGrid.getRowCount(); i++) {
					PlanDetaInsGrid.setValue(i,'name',planName);
				}
				console.log(2222);
				
				if(confirm("저장하시겠습니까?")) {
					PlanDetaInsGrid.blur()
					PlanDetaInsGrid.request('modifyData',{showConfirm:false})
					
					// 등록 후 토스트 띄우기
						toastr.clear()
						toastr.success( ('계획이 등록되었습니다.'),'Gelato',{timeOut:'1000'} );
					
					$("#planName").val('');
					PlanDetaInsGrid.clear();
				}			
				
		} 
			
	});
	
	//계획 취소
	btnPlanDel.addEventListener("click", function() {
		PlanDetaGrid.blur();
		console.log(454545);
		for ( i =0 ; i <= PlanDetaGrid.getRowCount(); i++) {
			PlanDetaGrid.setValue(i,'fg','cancel');
		}
		
		if(confirm("취소하시겠습니까?")) {
			PlanDetaGrid.blur()
			
			list = PlanDetaGrid.getData()[0];
			pdi = PlanDetaGrid.getData()[0].planDetaId;
			
			$.ajax({
				url : "${path}/prd/modifyCanPrdPlan.do?planDetaId=" + pdi,
				data : JSON.stringify(list),
				type:'POST',
				contentType: 'application/json; charset=utf-8',
				error : function(result) {
					console.log('에러', result)
				}
			}).done(function (result) {
				console.log(result);
				if(result == 'CANT') {
					console.log(111);
					toastr.clear()
					toastr.error( ('지시가 이미 내려졌습니다.'),'Gelato',{timeOut:'1000'} );
				}else {
					console.log(222);
					toastr.clear()
					toastr.success( ('생산 계획이 취소되었습니다.'),'Gelato',{timeOut:'1000'} );
				}
			})
		}
		
		console.log(565656);
		
		PlanDetaGrid.clear();
	})
	</script>
</body>
</html>