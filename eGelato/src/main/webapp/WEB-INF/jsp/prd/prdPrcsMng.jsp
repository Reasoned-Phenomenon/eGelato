<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산관리</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
	<div>
		<h2>생산관리</h2>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-11">
			<button type="button"  id="btnSearchPlan">생산지시목록</button>
		</div>
		<div class="col-sm-1">
			<button id="btnPrcsMove" onclick="moveURL()"> 공정이동표</button>
		</div>
	</div>
	<hr>
	<div>
		<h3>진행생산지시</h3>
		<hr>
		<div id="IndicaGrid"></div>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-9">
			<h3>공정목록</h3>
			<hr>
			<div id="prcsListGrid"></div>
		</div>
		<div class="col-sm-3">
			<h3>공정상세사항</h3>
			<hr>
			<table>
				<!-- <tbody>
					<tr>
						<th>시작시간</th>
						<td><input type="time" id="startT" readonly></td>
					</tr>
					<tr>
						<th>종료예정시간</th>
						<td><input type="time" id="endT" readonly></td>
					</tr>
				</tbody> -->
			</table>
			<br><br>
			<button type="button"  id="btnPrcs">생산시작</button>&nbsp;
			<button type="button"  id="btnStop">긴급중지</button>&nbsp;
			<button type="button"  id="btnRest">재시작</button>&nbsp;
			
			
		</div>
	</div>	
	
	<!-- 생산지시 조회 모달-->
	<div id="nonPrcsDialog" title="생산 지시 목록"></div>
	
<script>
	let idi;
	
	//버튼 숨김
	/* $("#btnPrcs").hide();
	$("#btnStop").hide();
	$("#btnRest").hide();
	$("#btnPrcsMove").hide(); */
	
	// 생산 시작 버튼 
	//document.getElementById('btnPrcs').innerText = '생산 시작';
	
	//토스트옵션
	toastr.options = {
			positionClass : "toast-top-center",
			progressBar : true,
			timeOut: 1500 // null 입력시 무제한.
		}
	
	// 그리드 생성
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
		
		// 그리드1
		const IndicaGrid = new Grid({
			el : document.getElementById('IndicaGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/selectIndica.do',method : 'GET'},
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '생산지시코드',
				name : 'indicaDetaId'
			}, {
				header : '제품명',
				name : 'prdtNm',
			}, {
				header : '제품코드',
				name : 'prdtId',
			}, {
				header : '수량',
				name : 'qy',
			}, {
				header : '라인코드',
				name : 'lineId',
			}, {
				header : '지시순번',
				name : 'ord',
			}]
		});
		  
		//그리드2  
		const prcsListGrid = new Grid({
			el : document.getElementById('prcsListGrid'),
			data : {
				api : {
					readData : {url : '${path}/prd/prcsList.do',method : 'GET'},
					modifyData : { url: '${path}/prd/modifyPrcs.do', method: 'PUT'} 
				},
				contentType : 'application/json',
				initialRequest: false
			},
			rowHeaders : ['rowNum' ],
			selectionUnit : 'row',
			columns : [ {
				header : '진행공정코드',
				name : 'prcsNowId',
				width : 95
			}, {
				header : '공정코드',
				name : 'prcsId',
				width : 95
			}, {
				header : '공정명',
				name : 'nm',
			}, {
				header : '설비코드',
				name : 'eqmId',
				width : 70
			}, {
				header : '설비명',
				name : 'eqmName',
			},{
				header : '담당자',
				name : 'mngr',
				width : 70
			},{
				header : '투입량',
				name : 'inptQyT',
				width : 55
			},{
				header : '불량량',
				name : 'inferQyT',
				width : 55
			},{
				header : '생산량',
				name : 'prodQyT',
				width : 55
			},{
				header : '시작시간',
				name : 'frTm',
				hidden : true,
			},{
				header : '지시순번',
				name : 'ord',
				hidden : true
			},{
				header : '생산지시코드',
				name : 'indicaDetaId',
				hidden : true
			},{
				header : '수량',
				name : 'inptQy',
				hidden : true
			},{
				header : '라인순번',
				name : 'lineOrd',
				hidden : true
			},{
				header : '공정상태',
				name : 'st',
				hidden : true
			},{
				header : 'jobName',
				name : 'jobName',
				hidden : true
			},{
				header : 'programName',
				name : 'programName',
				hidden : true
			},{
				header : '시작시간',
				name : 'startTm',
				hidden : false,
				width : 80
			},{
				header : '종료시간',
				name : 'endTm',
				hidden : false,
				width : 80
			},{
				header : '상태',
				name : 'psSt',
				hidden : false,
				width : 70
			}]
		});
		
	// 모달창
	var nonPrcsDialog = $("#nonPrcsDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});
	
	$("#btnSearchPlan").on(
			"click",
			function() {
				nonPrcsDialog.dialog("open");
				$("#nonPrcsDialog").load("${path}/prd/nonPrcsDialog.do",
						function() {
							console.log("주문창 로드")
						})
			});
	
	// indicaId 받아서 readData 넘기기
	function choosePi(cid,cpn){
		console.log(cid);
		console.log(cpn);
		
		IndicaGrid.clear();
		prcsListGrid.clear();
		
		IndicaGrid.readData(1, {'indicaDetaId':cid}, true);
		prcsListGrid.readData(1, {'prdtNm':cpn, 'indicaDetaId':cid}, true);
		
		nonPrcsDialog.dialog("close");
		idi = cid;
		console.log(idi);
		getQyData();

		/* // 버튼 정리
		if( prcsListGrid.getValue(0,'prcsNowId') != null && prcsListGrid.getValue(0,'startTm') == null) {
			$("#btnPrcs").show();
		} else if ( prcsListGrid.getValue(0,'startTm') != null && prcsListGrid.getValue(gLength-1,'startTm') == null) {
			$("#btnPrcs").hide();
			$("#btnStop").show();
			$("#btnRest").show();
			$("#btnPrcsMove").show();
		} else if ( prcsListGrid.getValue(0,'startTm') != null && prcsListGrid.getValue(gLength-1,'startTm') != null) {
			console.log("언제끝나냐");
			$("#btnPrcs").hide();
			$("#btnStop").hide();
			$("#btnRest").hide();
			$("#btnPrcsMove").show();
		} */
		
	}
	
	// 공정시작버튼 누름
	btnPrcs.addEventListener('click', function () {
		gLength = prcsListGrid.getData().length;
		
		if(prcsListGrid.getValue(0,'startTm') != null && prcsListGrid.getValue(gLength-1,'endTm') == null) {
			toastr.clear()
			toastr.warning( ('공정이 진행중입니다.'),'Gelato',{timeOut:'1000'} );
			
		} else if (prcsListGrid.getValue(0,'startTm') != null && prcsListGrid.getValue(gLength-1,'endTm') != null) {
			toastr.clear()
			toastr.error( ('공정이 완료되었습니다.'),'Gelato',{timeOut:'1000'} );
			
		} else {
			if(confirm("공정을 시작하시겠습니까?")) {
				
			// 시간입력
			let now = new Date();
			let stT = ("00"+now.getHours()).slice(-2)+":"+("00"+now.getMinutes()).slice(-2);
			/* startT.value = stT
			console.log(stT); */
			
			// 행에 값 넣기
			grc = prcsListGrid.getRowCount();
			ior = IndicaGrid.getData()[0].ord;
			idi = IndicaGrid.getData()[0].indicaDetaId;
			iqy = IndicaGrid.getData()[0].qy;
			
			// 첫 행에 시간 넣기
			//prcsListGrid.setValue(0,'frTm',stT);
			
			// 전체 행에 필요값 넣기
			var i
			for (i = 0 ; i < grc ; i++) {
				prcsListGrid.setValue(i,'ord',ior);
				prcsListGrid.setValue(i,'indicaDetaId',idi);
				prcsListGrid.setValue(i,'lineOrd',i+1);
				//prcsListGrid.setValue(i,'inptQy',iqy);
				
				// jobName 만들기, programName 만들기
				jobName = 'JOB_' + prcsListGrid.getData()[i].prcsNowId.substr(0,3) 
							+ prcsListGrid.getData()[i].prcsNowId.substr(4,3)
							+ prcsListGrid.getData()[i].prcsNowId.substr(8,3);
				console.log(jobName);
				
				programName = prcsListGrid.getData()[i].prcsNowId.substr(0,3) 
							+ prcsListGrid.getData()[i].prcsNowId.substr(4,3)
							+ prcsListGrid.getData()[i].prcsNowId.substr(8,3);
				console.log(programName);
				
				prcsListGrid.setValue(i,'jobName',jobName);
				prcsListGrid.setValue(i,'programName',programName);
				
			}
			
			prcsListGrid.request('modifyData', {showConfirm : false});
		
			toastr.clear()
			toastr.success( ('공정을 시작합니다.'),'Gelato',{timeOut:'1000'} );
			
			}
		} 
	})
	
	// 긴급정지버튼 누름
	btnStop.addEventListener('click', function () {
		gLength = prcsListGrid.getData().length;
		
		if (prcsListGrid.getValue(0,'startTm') == null && prcsListGrid.getValue(gLength-1,'endTm') == null) {
			toastr.clear()
			toastr.warning( ('공정이 시작하지 않았습니다.'),'Gelato',{timeOut:'1000'} );
		} else if (prcsListGrid.getValue(0,'startTm') != null && prcsListGrid.getValue(gLength-1,'endTm') != null) {
			toastr.clear()
			toastr.warning( ('공정이 완료되었습니다.'),'Gelato',{timeOut:'1000'} );
		} else {
			if(confirm("공정을 정지하시겠습니까?")){
				
				// 전체행 update
				grc = prcsListGrid.getRowCount();
				ior = IndicaGrid.getData()[0].ord;
				idi = IndicaGrid.getData()[0].indicaDetaId;
				
				ior = IndicaGrid.getData()[0].ord;
				
				for (i = 0 ; i < grc ; i++) {
					prcsListGrid.setValue(i,'ord',ior);
					prcsListGrid.setValue(i,'indicaDetaId',idi);
					prcsListGrid.setValue(i,'lineOrd',i+1);
				}
				
				list1 = prcsListGrid.getData();
				console.log(list1);
				
				
				$.ajax({
					url : "${path}/prd/prcsStStop.do?ord=" + ior,
					data : JSON.stringify(list1),
					type:'POST',
					dataType:'json',
					contentType: 'application/json; charset=utf-8',
					error : function(result) {
						console.log('에러', result)
					}
				}).done(function (result) {
					
					toastr.clear()
					toastr.success( ('공정을 일시정지합니다.'),'Gelato',{timeOut:'1000'} );
					
				})
			}
		}
	})
	
	// 공정재시작 누름
	btnRest.addEventListener('click', function () {
		gLength = prcsListGrid.getData().length;
		
		if (prcsListGrid.getValue(0,'startTm') == null && prcsListGrid.getValue(gLength-1,'endTm') == null) {
			toastr.clear()
			toastr.warning( ('공정이 시작하지 않았습니다.'),'Gelato',{timeOut:'1000'} );
		} else if (prcsListGrid.getValue(0,'startTm') != null && prcsListGrid.getValue(gLength-1,'endTm') != null) {
			toastr.clear()
			toastr.warning( ('공정이 완료되었습니다.'),'Gelato',{timeOut:'1000'} );
		} else {
			
			if(confirm("공정을 재시작하시겠습니까?")){
				
				// 전체행 update
				grc = prcsListGrid.getRowCount();
				ior = IndicaGrid.getData()[0].ord;
				idi = IndicaGrid.getData()[0].indicaDetaId;
				
				for (i = 0 ; i < grc ; i++) {
					prcsListGrid.setValue(i,'ord',ior);
					prcsListGrid.setValue(i,'indicaDetaId',idi);
					prcsListGrid.setValue(i,'lineOrd',i+1);
				}
				
				list2 = prcsListGrid.getData();
				console.log(list2);
				
				$.ajax({
					url : "${path}/prd/prcsStRest.do?ord=" + ior,
					data : JSON.stringify(list2),
					type:'POST',
					dataType:'json',
					contentType: 'application/json; charset=utf-8',
					error : function(result) {
						console.log('에러', result)
					}
				}).done(function (result) {
					
					toastr.clear()
					toastr.success( ('공정을 재가동합니다.'),'Gelato',{timeOut:'1000'} );
					
				})
			}
		
		}
	})
	
	// 공정이동표
	
	function moveURL() {
		console.log(11111);
		let mid = IndicaGrid.getData()[0].indicaDetaId;
		console.log(mid);
		window.open('${path}/prd/prcsMoveDialog.do?mid='+ mid, 
					'공정이동표',
					'width=1000,height=650,location=no,status=no,scrollbars=no,titlebar=no,top=200,left=400');
	}
	
	// 시작 이후 setInterval로 쿼리 새로 조회해오기
	let inptQyV;
	let inferQyV;
	let prodQyV;
	
	// 값 가지고오기
	function getQyData() {
		if(idi != '') {
		
			$.ajax({
				url : "${path}/prd/selectQy.do",
				type:'POST',
				dataType:'json',
				data : {"indicaDetaId" : idi},
				error : function(result) {
					console.log('에러', result)
				}
			}).done(function (result) {
				//console.log(result.data.contents.length);
				/* console.log(result.data.contents[0].inptQyT);
				console.log(result.data.contents[0].inferQyT);
				console.log(result.data.contents[0].prodQyT); */
				
				console.log(result);
				for(let i=0 ; i<result.data.contents.length ; i++) {
					
					inptQyV = result.data.contents[i].inptQyT
					inferQyV = result.data.contents[i].inferQyT
					prodQyV = result.data.contents[i].prodQyT
					psSt = result.data.contents[i].psSt
					startTm = result.data.contents[i].startTm
					endTm = result.data.contents[i].endTm
					
					prcsListGrid.setValue(i,'inptQyT',inptQyV);			
					prcsListGrid.setValue(i,'inferQyT',inferQyV);	
					prcsListGrid.setValue(i,'prodQyT',prodQyV);	
					prcsListGrid.setValue(i,'psSt',psSt);	
					prcsListGrid.setValue(i,'startTm',startTm);	
					prcsListGrid.setValue(i,'endTm',endTm);	
					
				}
				
			})
		}
		
	}
	
	$(document).ready ( function getData() {
		timerld = setInterval(getQyData, 5000);
	});
	
	
</script>
</body>
</html>