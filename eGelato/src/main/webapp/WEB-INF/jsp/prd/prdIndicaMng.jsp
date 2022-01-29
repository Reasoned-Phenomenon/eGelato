<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시 관리</title>
<style>
.tui-grid-layer-editing {
	z-index : 20;
}
</style>
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
	<br><br><br>
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
			<br>
			<div class="col-sm-2">
					<button type="button" class="btn btn-secondary" id="btnDel">행 삭제</button>
			</div>
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
	let pdn;
	let pdc;
	let pdq;
	
	let pil;
	let pid;
	let piq;
	let pio;
	let prk;
	
	let rpi;
	let rwi;
	let rwn;
	let rwq;
	
	let idi;
	
	let list1 = [];
	let list2 = [];
	let list3 = [];
	
	// 버튼 숨김
	$("#btnIns").hide();
	
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
		
		// 그리드1 : 계획
		const planDetaGrid = new Grid({
			el : document.getElementById('planDetaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/choosePlan.do',method : 'GET'},
					//modifyData : { url: '${path}/prd/modifyPrdIndica.do', method: 'PUT'} 
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
				align: 'right',
			}, {
				header : '생산일수',
				name : 'prodDcnt',
				align: 'right',
			},{
				header : '확인',
				name : 'fg',
				hidden : true
			}]
		});
		
		// 그리드2 - 생산지시 그리드
		const planIndicaGrid = new Grid({
			el : document.getElementById('planIndicaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/choosePlanDetaId.do' , method : 'GET'},
					//modifyData : { url: '${path}/prd/modifyPrdIndicaDeta.do', method: 'PUT'} 
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '지시디테일코드',
				name : 'indicaDetaId',
				hidden : false
			},{
				header : '라인코드',
				name : 'lineId',
			}, {
				header : '작업일자',
				name : 'indicaDt',
				editor: 'datePicker',
				//language : 'ko'
			}, {
				header : '작업수량 (Box)',
				name : 'qy',
				editor: 'text',
				align: 'right',
			}, {
				header : '일자별 우선순위',
				name : 'ord',
				editor: 'text',
				align: 'right',
			},{
				header : '생산계획디테일코드',
				name : 'planDetaId',
				hidden : true
			},{
				header : '비고',
				name : 'remk',
				editor: 'text'
			},{
				header : '확인',
				name : 'fg',
				hidden : true
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
				align: 'right',
			},{
				header : '생산계획디테일코드',
				name : 'planDetaId',
				hidden : true
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
			rowHeaders:['checkbox','rowNum'],
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
				align: 'right',
			}, {
				header : '유통기한',
				name : 'expdate',
			},{
				header : '제품코드',
				name : 'prdtId',
				hidden : true
			},{
				header : '생산계획디테일코드',
				name : 'planDetaId',
				hidden : true
			},{
				header : '일자별 우선순위',
				name : 'ord',
				hidden : true
			},{
				header : '지시디테일코드',
				name : 'indicaDetaId',
				hidden : false
			}],
			summary: {
		        height: 0,
		        position: 'bottom', // or 'top'
		        columnContent: {
		        	oustQy: {
		            template(summary) {
	              			  return 'Total: ' + summary.sum;
		            }
		          }
		        }
			}
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
			planDetaGrid.readData(1,{'planDetaId':nip}, true);
			NonIndicaDialog.dialog("close");
		}
	//종료

	function lpad(val, padLength, padString){
			    while(val.length < padLength){
			        val = padString + val;
			    }
			    return val;
			}
	
	// 생산계획 그리드 클릭 -> 생산지시그리드에 출력해주기
	planDetaGrid.on("dblclick", (ev) => {
		planDetaGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, planDetaGrid.getColumns().length-1]
		});
		
		planIndicaGrid.clear();
		RwmatrGrid.clear();
		RwmatrLotGrid.clear();
		
		for ( i = 0 ; i <= planDetaGrid.getRowCount() ; i++) {
			planDetaGrid.setValue(i, 'fg', '');
		}
		planDetaGrid.setValue(ev.rowKey, 'fg', 'PROCEE');
		
		//planDetaId 가지고 와서 생산지시 작성
		pdi = planDetaGrid.getRow(ev.rowKey).planDetaId;
		console.log(pdi);
		pdn = planDetaGrid.getRow(ev.rowKey).prdtNm;
		console.log(pdn);
		pdc = planDetaGrid.getRow(ev.rowKey).prodDcnt;
		console.log(pdc);
		pdq = planDetaGrid.getRow(ev.rowKey).qy;
		console.log(pdq);
		
		var obj = {};
		obj["planDetaId"] = pdi;
		obj["prdtNm"] = pdn;
		obj["prodDcnt"] = pdc;
		obj["qy"] = pdq;
		
		list1.push(obj);
		
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
			indicaDetaId = result.indicaDetaId;
			console.log(indicaDetaId);
			
		})
		
		for( let i=0 ; i<pdc ; i++ ) {
			console.log(indicaDetaId);
			indicaDetaId = indicaDetaId.substr(0,13) + lpad(String(parseInt(indicaDetaId.substr(-3))+i),3,0)
			console.log(indicaDetaId);
			planIndicaGrid.appendRow({'lineId':lineId, 'planDetaId':pdi, 'indicaDetaId':indicaDetaId})
		}
	});
	
	// 지시값 합
	planIndicaGrid.on("editingFinish", (ev) => {
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
	planIndicaGrid.on("click", (ev5) => {
		RwmatrGrid.clear();
		RwmatrLotGrid.clear();
	})
	
	planIndicaGrid.on("editingFinish", (ev3) => {
		planIndicaGrid.setSelectionRange({
		    start: [ev3.rowKey, 0],
		    end: [ev3.rowKey, planIndicaGrid.getColumns().length-1]
		});
		
		RwmatrGrid.clear();
		RwmatrLotGrid.clear();
		
		pil = planIndicaGrid.getRow(ev3.rowKey).lineId;
		console.log(pil);
		pid = planIndicaGrid.getRow(ev3.rowKey).indicaDt;
		console.log(pid);
		piq = planIndicaGrid.getRow(ev3.rowKey).qy;
		console.log(piq);
		pio = planIndicaGrid.getRow(ev3.rowKey).ord;
		console.log(pio);
		prk = planIndicaGrid.getRow(ev3.rowKey).remk;
		console.log(prk);
		pdi = planIndicaGrid.getRow(ev3.rowKey).planDetaId;
		console.log(pdi);
		idi = planIndicaGrid.getRow(ev3.rowKey).indicaDetaId;
		console.log(idi);
		
		if(piq == '') {
			toastr.clear()
			toastr.success( ('작업수량을 입력해주세요.'),'Gelato',{timeOut:'1000'});
		} else {
			RwmatrGrid.readData(1,{'lineId':pil, 'qy':piq , 'planDetaId':pdi }, true);
			
			for ( i=0 ; i <= planIndicaGrid.getRowCount() ; i++) {
				planIndicaGrid.setValue(i, 'fg', '');
			}
			
			planIndicaGrid.setValue(ev3.rowKey, 'fg', 'PROCEE');
		
		}
		
	});
	
	// 필요자재 클릭시 자재별 Lot 모달 출력
	RwmatrGrid.on('dblclick', (ev4) => {
		RwmatrGrid.setSelectionRange({
		    start: [ev4.rowKey, 0],
		    end: [ev4.rowKey, RwmatrGrid.getColumns().length-1]
		});
		
		rpi = RwmatrGrid.getRow(ev4.rowKey).prdtId;
		console.log(rpi);
		rwi = RwmatrGrid.getRow(ev4.rowKey).rwmatrId;
		console.log(rwi);
		rwn = RwmatrGrid.getRow(ev4.rowKey).nm;
		console.log(rwn);
		rwq = RwmatrGrid.getRow(ev4.rowKey).qy;
		console.log(rwq);
		pdi = RwmatrGrid.getRow(ev4.rowKey).planDetaId;
		console.log(pdi);
		pio = RwmatrGrid.getRow(ev4.rowKey).ord;
		console.log(pio);
		
		chooseRI(rwi,rwn,rwq,rpi,pdi,pio);
		console.log(99999)
	})
	
		var RwmatrLotDialog = $("#RwmatrLotDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 800
		});	
	
	function chooseRI(rwi,rwn,rwq,rpi,pdi,pio){
		// 자재Lot 모달창 생성
		RwmatrLotDialog.dialog("open");
		console.log(232323);
		   $("#RwmatrLotDialog").load("${path}/prd/RwmatrLotDialog.do",
				function() {
					console.log("주문창 로드") 
					console.log(rwi);
					chooseRWI(rwi,rwn,rwq,rpi,pdi,pio);
				})
	}

	function moveCR(gcr){
		RwmatrLotDialog.dialog("close");
		console.log(gcr);
		/* console.log(gcr[1].lotNo);
		console.log(gcr[1].oustQy);
		console.log(gcr[1].expdate); */
		console.log(gcr.length);
		
		let rrc = RwmatrLotGrid.getRowCount();
		console.log(rrc);
		//rrc=4
		
		let j=0;
		let k=0;
		for( let i=(rrc-gcr.length) ; i<rrc ; i++){
			//appendRow 한 다음에 setValue 시키기
			
			console.log(989898)
				
			//for ( j=0 ; j<gcr.length ; j++) {
				RwmatrLotGrid.setValue(i, 'nm', rwn);
 				RwmatrLotGrid.setValue(i, 'lotNo', gcr[j].lotNo);
				RwmatrLotGrid.setValue(i, 'oustQy', gcr[j].oustQy);
				RwmatrLotGrid.setValue(i, 'expdate', gcr[j].expdate);
				
				j++;
				for ( k=0 ; k<planIndicaGrid.getRowCount() ; k++) {
					if(planIndicaGrid.getData()[k].fg == 'PROCEE') {
						pio = planIndicaGrid.getData()[k].ord
						console.log(pio);
						RwmatrLotGrid.setValue(i, 'ord', pio);
						RwmatrLotGrid.setValue(i, 'indicaDetaId', idi);
					}
				}
			//}
		}
		
			
		conSumVal();
	}
	
	// Lot 클릭 확인
	/* RwmatrLotGrid.on("dblclick", (ev5) => {
		RwmatrLotGrid.setSelectionRange({
		    start: [ev5.rowKey, 0],
		    end: [ev5.rowKey, RwmatrLotGrid.getColumns().length-1]
		});
		
		console.log(ev5)
	}); */

	// 행삭제
	btnDel.addEventListener("click", function() {
		if(confirm("삭제하시겠습니까?")){ 
			RwmatrLotGrid.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
		}
		conSumVal();
	});
	
	// 등록버튼 비활성화 시키기
	function conSumVal() {
		let qys = RwmatrGrid.getSummaryValues('qy').sum;
		let oqs = RwmatrLotGrid.getSummaryValues('oustQy').sum
		
		console.log(qys);
		console.log(oqs);
		
		if(qys != oqs) {
			$("#btnIns").hide();
		}else {
			$("#btnIns").show();
		}
	}
	
	// 등록
	btnIns.addEventListener("click", function() {
		if(confirm("저장하시겠습니까?")) {
			planDetaGrid.blur();
			planIndicaGrid.blur();
			RwmatrGrid.blur();
			RwmatrLotGrid.blur();
			
			console.log("저장");
			
			console.log(pdi);
			
			//순서가 필요한 경우 -> ajax
			
			//생산지시 저장
			$.ajax({
				url : "${path}/prd/modifyPrdIndica.do?planDetaId=" + pdi,
				data : JSON.stringify(list1),
				type:'POST',
				dataType:'json',
				contentType: 'application/json; charset=utf-8',
				error : function(result) {
					console.log('에러', result)
				}
			}).done(function (result) {
				console.log(result);
				
				/* for ( i=0 ; i<planIndicaGrid.getRowCount() ; i++) {
					if(planIndicaGrid.getData()[i].fg == 'PROCEE') {
						list2 = planIndicaGrid.getData()[i]
						console.log(list2);
					}
				} */
				
				list2 = planIndicaGrid.getData()
				// 생산지시디테일 저장
				$.ajax({
					url : "${path}/prd/modifyPrdIndicaDeta.do?planDetaId=" + pdi,
					data : JSON.stringify(list2),
					type:'POST',
					dataType:'json',
					contentType: 'application/json; charset=utf-8',
					error : function(result) {
						console.log('에러22', result)
					}
				}).done(function (result) {
					console.log(result);
					
					list3 = RwmatrLotGrid.getData()
					
					$.ajax({
						url : "${path}/prd/modifyInptRwmatr.do?planDetaId=" + pdi,
						data : JSON.stringify(list3),
						type:'POST',
						dataType:'json',
						contentType: 'application/json; charset=utf-8',
						error : function(result) {
							console.log('에러33', result)
						}
					}).done (function(result) {
						console.log(result);
						
						toastr.clear()
						toastr.success( ('생산지시가 등록되었습니다.'),'Gelato',{timeOut:'1000'} );
					})
				})
			})
					
		}
	})
	

	
	
</script>
</html>