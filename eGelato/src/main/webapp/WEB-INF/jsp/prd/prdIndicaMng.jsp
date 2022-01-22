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
		<div class="col-sm-11">
			 <button type="button" class="btn btn-secondary" id="btnSearch">미지시 계획 조회</button>
		</div>
		<div class="col-sm-1">
			 <button type="button" class="btn btn-secondary" id="btnIns" >지시 등록</button>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-sm-5">
			<h3>상세생산계획</h3>
			<hr>
			<div id="planDetaGrid"></div>
		</div>
		<div class="col-sm-7">
			<h3>생산지시</h3>
			<hr>
			<div id="planIndicaGrid"></div>
		</div>
	</div>
	<br><br>
	<div class="row">
		<div class="col-sm-5">
			<h3>필요자재</h3>
			<hr>
			<div id="RwmatrGrid"></div>
			<br>
			<h6>소모량 : 자재별 필요량 * 작업수량 / 10</h6>
		</div>
		<div class="col-sm-7">
			<h3>필요자재Lot</h3>
			<hr>
			<div id="RwmatrLotGrid"></div>
		</div>
	</div>
	
	<!-- 미지시 생산계획조회 모달창 -->
	<div id=nonIndicaDialog title="미지시 생산계획 목록"></div>
	
	<!-- 자재 모달창 -->
	<div id=RwmatrLotDialog title="자재별 LOT 목록"></div>
	
</body>

<script>
	// 변수모음
	let pdi;
	let pdc;
	let pdq;
	let rwi;
	let rwn;
	let rwq;
	
	// 버튼 숨김
	/* $("#btnIns") */
	
	//토스트옵션
	toastr.options = {
		positionClass : "toast-top-center",
		progressBar : true,
		timeOut: 1500 // null 입력시 무제한.
		}
	
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
					readData : {url : '${path}/prd/choosePlanDetaId.do' , method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '라인코드',
				name : 'lineId',
			}, {
				header : '착수일자',
				name : 'indicaDt',
				editor: 'datePicker'
			}, {
				header : '작업수량 (Box)',
				name : 'qy',
				editor: 'text',
			}, {
				header : '일자별 우선순위',
				name : 'ord',
				editor: 'text'
			}],
			summary: {
		        height: 0,
		        position: 'bottom', // or 'top'
		        columnContent: {
		        	qy: {
		            template(summary) {
	              			  return 'Total: ' + summary.sum;
		            }
		          }
		        }
			}
		});
		
		// 그리드3 - 필요자재
		const RwmatrGrid = new Grid({
			el : document.getElementById('RwmatrGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/chooseIndicaQy.do',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '제품코드',
				name : 'prdtId'
			}, {
				header : '자재코드',
				name : 'rwmatrId',
			}, {
				header : '자재명',
				name : 'nm',
			}, {
				header : '소모량',
				name : 'qy',
			}]
		});
		
		// 그리드4 - 선택lot
		const RwmatrLotGrid = new Grid({
			el: document.getElementById('RwmatrLotGrid'),
			data : {
			  api: {
			    readData: { url:'${path}', method: 'GET'}
			  },
			  contentType: 'application/json',
			  initialRequest: false
			},
			rowHeaders:['rowNum'],
			selectionUnit: 'row',
			columns:[{
				header : '자재명',
				name : 'nm'
			}, {
				header : '자재LOT번호',
				name : 'lotNo'
			}, {
				header : '사용수량',
				name : 'oustQy',
			}, {
				header : '유통기한',
				name : 'expdate',
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
			planDetaGrid.clear();
			planIndicaGrid.clear();
			RwmatrGrid.clear();
			RwmatrLotGrid.clear();
			planDetaGrid.readData(1,{planId:nip}, true);
			NonIndicaDialog.dialog("close");
		}
	//종료

	// 생산계획 그리드 클릭 -> 생산지시그리드에 출력해주기
	planDetaGrid.on("dblclick", (ev) => {
		planDetaGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, planDetaGrid.getColumns().length-1]
		});
		
		planIndicaGrid.clear();
		RwmatrGrid.clear();
		RwmatrLotGrid.clear();
		
		//planDetaId 가지고 와서 생산지시 작성
		pdi = planDetaGrid.getRow(ev.rowKey).planDetaId;
		console.log(pdi);
		pdc = planDetaGrid.getRow(ev.rowKey).prodDcnt;
		console.log(pdc);
		pdq = planDetaGrid.getRow(ev.rowKey).qy;
		console.log(pdq);
		
		//ajax -> 라인코드 가져오기
		$.ajax({
			url:"${path}/prd/choosePlanDetaId.do?planDetaId=" + pdi,
			async: false,
			error : function(result) {
				console.log('에러', result)
			}
		}).done(function (result) {
			console.log(result)
			lineId = result.lineId;
			console.log(lineId)
		})
		
		for( let i=0 ; i<pdc ; i++ ) {
			planIndicaGrid.appendRow({'lineId':lineId})
		}
	});
	
	// 지시값 합
	planIndicaGrid.on('editingFinish', (ev) => {
		console.log(111);
		console.log(planIndicaGrid.getSummaryValues('qy').sum);
		
		if( planIndicaGrid.getSummaryValues('qy').sum < pdq ){
			console.log("작음");
		}else if( planIndicaGrid.getSummaryValues('qy').sum > pdq ){
			console.log("큼");
		}else {
			console.log("확인");
			/* $("#btnIns").show(); */
		}
	});
	
	// 생산지시 클릭 -> 필요자재 그리드
	planIndicaGrid.on("editingFinish", (ev3) => {
		planIndicaGrid.setSelectionRange({
		    start: [ev3.rowKey, 0],
		    end: [ev3.rowKey, planIndicaGrid.getColumns().length-1]
		});
		
		RwmatrGrid.clear();
		RwmatrLotGrid.clear();
		
		var pil = planIndicaGrid.getRow(ev3.rowKey).lineId;
		console.log(pil);
		var pid = planIndicaGrid.getRow(ev3.rowKey).indicaDt;
		console.log(pid);
		var piq = planIndicaGrid.getRow(ev3.rowKey).qy;
		console.log(piq);
		var pio = planIndicaGrid.getRow(ev3.rowKey).ord;
		console.log(pio);
		
		if(piq == '') {
			toastr.clear()
			toastr.success( ('작업수량을 입력해주세요.'),'Gelato',{timeOut:'1000'});
		} else {
			RwmatrGrid.readData(1,{'lineId':pil, 'qy':piq}, true);
		}
		
	});
	
	// 필요자재 클릭시 자재별 Lot 모달 출력
	RwmatrGrid.on('dblclick', (ev4) => {
		RwmatrGrid.setSelectionRange({
		    start: [ev4.rowKey, 0],
		    end: [ev4.rowKey, RwmatrGrid.getColumns().length-1]
		});
		
		rwi = RwmatrGrid.getRow(ev4.rowKey).rwmatrId;
		console.log(rwi);
		rwn = RwmatrGrid.getRow(ev4.rowKey).nm;
		console.log(rwn);
		rwq = RwmatrGrid.getRow(ev4.rowKey).qy;
		console.log(rwq);
		
		chooseRI(rwi,rwn,rwq);
		console.log(99999)
	})
	
		var RwmatrLotDialog = $("#RwmatrLotDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 800
		});	
	
	function chooseRI(rwi,rwn,rwq){
		// 자재Lot 모달창 생성
		RwmatrLotDialog.dialog("open");
		console.log(232323);
		   $("#RwmatrLotDialog").load("${path}/prd/RwmatrLotDialog.do",
				function() {
					console.log("주문창 로드") 
					console.log(rwi);
					chooseRWI(rwi,rwn,rwq);
				})
	}

	function moveCR(gcr){
		RwmatrLotDialog.dialog("close");
		console.log(gcr);
		console.log(gcr[0].lotNo);
		console.log(gcr[0].oustQy);
		console.log(gcr[0].expdate);
		console.log(gcr.length);
		
		let rrc = RwmatrLotGrid.getRowCount();
		console.log(rrc);
		
		for( let i=(rrc-gcr.length) ; i<gcr.length ; i++){
			//appendRow 한 다음에 setValue 시키기
			
			RwmatrLotGrid.setValue(i, 'nm', rwn);
			RwmatrLotGrid.setValue(i, 'lotNo', gcr[i].lotNo);
			RwmatrLotGrid.setValue(i, 'oustQy', gcr[i].oustQy);
			RwmatrLotGrid.setValue(i, 'expdate', gcr[i].expdate);
				
			/* for (let j=0 ; j<gcr.length ; j++) {
				RwmatrLotGrid.setValue(i, 'nm', rwn);
				RwmatrLotGrid.setValue(i, 'lotNo', gcr[j].lotNo);
				RwmatrLotGrid.setValue(i, 'oustQy', gcr[j].oustQy);
				RwmatrLotGrid.setValue(i, 'expdate', gcr[j].expdate);
			} */
		}
	}

</script>
</html>