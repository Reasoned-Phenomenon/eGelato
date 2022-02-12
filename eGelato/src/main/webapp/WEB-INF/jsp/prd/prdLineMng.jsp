<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		<div class="col-sm-5" style="margin: 0px; width: 100%;">
			<h2>제품공정흐름도</h2>
			<div id="lineGrid"></div>
		</div>
		<div class="col-sm-7">
			<h2>제품공정흐름도 관리</h2>
			<div style="float: right; margin-bottom: 10px; margin-top: 10px;">
				<button type="button" id="btnAdd">추가</button>
				<button type="button" id="btnDel">삭제</button>
				<button type="button" id="btnIns">등록</button>
			</div>
			
			<select name="prdtDeta" id="prdtDeta">
				<option value="" selected>선택</option>
				<option value="BAR">바형</option>
				<option value="CON">콘형</option>
				<option value="CUP">컵형</option>
				<option value="SAN">샌드형</option>
				<option value="TUB">튜브형</option>
			</select>
			<hr>
			<div id="linePrcsGrid"></div>
		</div>
	</div>

	<div id="prcsModal" title="공정목록"></div>
	<script>
	$('#prdtDeta').hide();
	
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
	
	// 그리드 생성 1
	const lineGrid = new Grid({
		el : document.getElementById('lineGrid'),
		data : {
			api : {
				readData : {url : '${path}/prd/lineListGrid.do' , method : 'GET'}
			},
			contentType : 'application/json',
		},
		rowHeaders : ['rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 660,
		columns : [ {
			header : '제품코드',
			name : 'prdtId',
			sortable: true
		}, {
			header : '제품명',
			name : 'prdtNm',
		}, {
			header : '라인코드',
			name : 'lineId',
		},{
			header : '제품구분',
			name : 'prcsDeta',
			hidden : true
		}]
	});
	
	// 그리드 생성 2
	const linePrcsGrid = new Grid({
		el : document.getElementById('linePrcsGrid'),
		data : {
			api : {
				readData : {url : '${path}/prd/linePrcsGrid.do',method : 'GET'},
				modifyData : { url: '${path}/prd/modifyLine.do', method: 'PUT'} 
			},
			contentType : 'application/json',
			initialRequest: false
		},
		rowHeaders : [ 'checkbox', 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 600,
		columns : [ {
			header : '제품코드',
			name : 'prdtId',
			hidden : true
		}, {
			header : '라인코드',
			name : 'lineId',
			hidden : true
		},{
			header : '공정코드',
			name : 'prcsId',
			validation: {
				required: true
	        }
		}, {
			header : '공정명',
			name : 'nm',
		}, {
			header : '설비코드',
			name : 'eqmId',
		}, {
			header : '설비명',
			name : 'eqmName',
		},{
			header : '순번',
			name : 'ord',
			hidden : false
		},{
			header : '제품구분',
			name : 'prcsDeta',
			hidden : true
		}]
	});
	
	// 행추가
	btnAdd.addEventListener("click", function() {
		linePrcsGrid.appendRow();
	});
	
	// 행삭제
	btnDel.addEventListener("click", function() {
		if(confirm("삭제하시겠습니까?")){ 
			
			lrc = linePrcsGrid.getRowCount();
			var j
			for ( j = 0 ; j< lrc ; j++) {
				linePrcsGrid.setValue(j,'ord',j+1);
			}
			
			linePrcsGrid.removeCheckedRows(false) //true -> 확인 받고 삭제 / false는 바로 삭제
			linePrcsGrid.request('modifyData', { showConfirm : false });
			
			toastr.clear()
			toastr.success( ('삭제되었습니다.'),'Gelato',{timeOut:'1000'} );
			
			for ( j = 0 ; j< lrc ; j++) {
				linePrcsGrid.setValue(i,'ord','');
			}
		}
		
	});
	
	// 그리드1 클릭시 해당 공정 출력
	lineGrid.on("dblclick", (ev) => {
		lineGrid.setSelectionRange({
		    start: [ev.rowKey, 0],
		    end: [ev.rowKey, lineGrid.getColumns().length-1]
		});
		
		pdi = lineGrid.getRow(ev.rowKey).prdtId;
		console.log(pdi);
		$('#prdtDeta').val('');
		
		pdt = lineGrid.getRow(ev.rowKey).prcsDeta;
		console.log(pdt);
		
		//$("#prdtDeta").val(pdt).prop("selected",true);
		linePrcsGrid.readData(1,{'prdtId':pdi}, true);
		
		if(pdt == null) {
			$('#prdtDeta').show();
		} else {
			$('#prdtDeta').hide();
		}
	})
	
	// 그리드2 공정 출력
	linePrcsGrid.on('dblclick', (ev2) => {
			rk = ev2.rowKey;
			console.log(ev2)
		    if (ev2.columnName === 'prcsId') {
		    	console.log(lineGrid.getRow(ev2.rowKey).prcsId);
					console.log("1111")
		    		callprcsCode();
			} else if( ev2.columnName === 'nm' || ev2.columnName === 'eqmId' || ev2.columnName === 'eqmName') {
				toastr.clear()
				toastr.error( ('공정코드를 선택해주세요.'),'Gelato',{timeOut:'1000'} );
			}
		});
	
	function callprcsCode(){
		prcsModal = $("#prcsModal").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 1000
		});
		
	    console.log("11111")
	    prcsModal.dialog( "open" );
	    $("#prcsModal").load(
							"${path}/prd/prcsDialog.do", function() {
								console.log("공정목록 모달")
							})
	}
	
	function chooseNm(pcn, pid, eid, enm) {
		console.log(pcn);
		console.log(pid);
		console.log(eid);
		console.log(enm);
		
		linePrcsGrid.setValue(rk, "prcsId", pid, true);
		linePrcsGrid.setValue(rk, "nm", pcn, true);
		linePrcsGrid.setValue(rk, "eqmId", eid, true);
		linePrcsGrid.setValue(rk, "eqmName", enm, true);
		
		prcsModal.dialog( "close" );
	}
	
	// 수정 등록
	btnIns.addEventListener("click", function() {
		
		if(confirm("저장하시겠습니까?")) {
			linePrcsGrid.blur();
			
			lrc = linePrcsGrid.getRowCount();
			pdv = $('#prdtDeta').val();
			lli = linePrcsGrid.getRow(0).lineId;
			var i
			
			for ( i = 0 ; i< lrc ; i++) {
				console.log(pdv);
				linePrcsGrid.setValue(i,'prcsDeta',pdv);
				linePrcsGrid.setValue(i,'prdtId',pdi);
				linePrcsGrid.setValue(i,'ord',i+1);
				linePrcsGrid.setValue(i,'lineId',lli);
			}
			
			linePrcsGrid.request('modifyData',{showConfirm:false})
			
			toastr.clear()
			toastr.success( ('저장되었습니다.'),'Gelato',{timeOut:'1000'} );
			
			for ( i = 0 ; i< lrc ; i++) {
				linePrcsGrid.setValue(i,'ord','');
			}
		}
		
	})
</script>
</body>
</html>