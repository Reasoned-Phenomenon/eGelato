<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시 조회</title>
</head>
<body>
	<div>
		<br>
		<h2>생산지시관리</h2>
		<br>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-8">
			 <button type="button" class="btn btn-secondary" id="btnSearch">미지시 계획 조회</button>
		</div>
		<div class="col-sm-4">
			 <button type="button" class="btn btn-secondary" id="btnIns">지시 등록</button>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-5">
			<div id="planDetaGrid">그리드1</div>
			<hr>
		</div>
		<div class="col-sm-7">
			<div id="planIndicaGrid">그리드2</div>
			<hr>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-5">
			<div id="RwmatrGrid">그리드3</div>
			<hr>
		</div>
		<div class="col-sm-7">
			<div id="RwmatrLotGrid">그리드4</div>
			<hr>
		</div>
	</div>
	
	<!-- 미지시 생산계획조회 모달창 -->
	<div id=nonIndicaDialog title="미지시 생산계획 목록"></div>
</body>

<script>
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
		
		// 그리드 : 계획
		const planDetaGrid = new Grid({
			el : document.getElementById('planDetaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/choosePlan.do',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '생산계획코드',
				name : 'planDetaId'
			}, {
				header : '제품명',
				name : 'prdtNm',
			}, {
				header : '수량',
				name : 'qy',
			}, {
				header : '생산일수',
				name : 'prodDcnt',
			}]
		});
		
		//생산지시 그리드
		const planIndicaGrid = new Grid({
			el : document.getElementById('planIndicaGrid'),
			data : {
				api : {
					readData : {url : '${path}/',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '착수일자',
				name : 'indicaDt',
			}, {
				header : '작업수량',
				name : 'qy',
			}, {
				header : '라인코드',
				name : 'prodDcnt',
			}]
		});
		
	// 미지시 생산계획
		//모달창 생성
		var NonIndicaDialog = $("#nonIndicaDialog").dialog({
				modal : true,
				autoOpen : false,
				height: 600,
				width: 1000
			});
		
		$("#btnSearch").on(
				"click", function() {
					console.log(121212);
					NonIndicaDialog.dialog("open");
					console.log(232323);
					   $("#nonIndicaDialog").load("${path}/prd/nonIndicaDialog.do",
							function() {
								console.log("주문창 로드") 
							})
				});
		// 계획코드 받아서 readData에 넘기기
		function choosePI(nip){
			console.log(nip);
			planDetaGrid.readData(1,{planId:nip}, true);
			NonIndicaDialog.dialog("close");
		}
	//종료

	// 생산계획 그리드 클릭
	planDetaGrid.on("dblclick", (ev) => {
		planDetaGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, planDetaGrid.getColumns().length-1]
		});
		
		//planDetaId 가지고 와서 생산지시 작성
		var pdi = planDetaGrid.getRow(ev.rowKey).planDetaId;
		console.log(pdi);
		choosePDI(pdi);
	});
	
	function choosePDI(pdi){
		console.log(pdi);
		planIndicaGrid.readData(1,{planDetaId:pdi}, true);
	}
	
	
	



















</script>
</html>