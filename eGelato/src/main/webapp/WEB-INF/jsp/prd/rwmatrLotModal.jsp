<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 LOT 조회</title>
</head>
<body>
	<br>
	<h1>자재 LOT 조회</h1>
	<br>
	<div>자재명 : <input type="text" readonly id="rwname"> 필요수량 : <input type="text" readonly id="rwneed"></div>
	<br>
	<div id="chooseRwmatrLotGrid"></div>
	<br>
	<button type="button" class="btn btn-secondary" id="btnchoose">확인</button>

<script>
	var Grid = tui.Grid;
	var iqy;
	
	//그리드 테마
	Grid.applyTheme('striped', {
		  cell: {
		    header: {
		      background: '#eef'
		    },
		    evenRow: {
		      background: '#fee'
		    },
			selectedHeader : {
		    	background : '#FFFFFF'
		    }
		  }
		});

	//그리드 생성
	var chooseRwmatrLotGrid = new Grid({
		el: document.getElementById('chooseRwmatrLotGrid'),
		data : {
		  api: {
		    readData: { url:'${path}/prd/chooseRwmatrId.do', method: 'GET'}
		  },
		  contentType: 'application/json',
		  initialRequest: false
		},
		rowHeaders:['checkbox','rowNum'],
		selectionUnit: 'row',
		columns:[
			  {
			    header: '자재Lot번호',
			    name: 'lotNo'
			  },
			  {
			    header: '현재고',
			    name: 'qy',
			  },
			  {
			    header: '사용수량',
			    name: 'oustQy',
			    editor : 'text'
			  },
			  {
			    header: '유통기한',
			    name: 'expdate',
			    editor: 'datePicker'
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
			  }
		  ],
		  summary: {
		        height: 40,
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
	
	chooseRwmatrLotGrid.on("editingFinish", (ev3) => {
		 let sumVal = chooseRwmatrLotGrid.getSummaryValues('oustQy').sum;
		 console.log(sumVal);
		 let rwv = document.getElementById("rwneed").value;
		 
		 if(sumVal != rwv) {
			 $("#btnchoose").hide();
		 } else {
			 $("#btnchoose").show();
		 }
	 });
	
	function chooseRWI(rwi,rwn,rwq,rpi,pdi,pio) {
		/* chooseRwmatrLotGrid.readData(1,{'rwmatrId':rwi}, true); */
		document.getElementById("rwname").value = rwn;
		document.getElementById("rwneed").value = rwq;
		console.log(rwq);
	
		$.ajax({
			url : "${path}/prd/chooseRwmatrId.do?rwmatrId=" + rwi,
			dataType : 'json',
			error : function(result) {
				console.log('에러', result)
			}
		}).done(function (result) {
			console.log('확인');
			console.log(result);
			console.log(result.data.contents);
			
			chooseRwmatrLotGrid.resetData(result.data.contents);
			chooseRwmatrLotGrid.resetOriginData();
			
			let grc = chooseRwmatrLotGrid.getRowCount();
			console.log(grc);
			
			console.log("시작");
			for (let i=0 ; i<grc ; i++) {
				
				console.log(rpi);
				chooseRwmatrLotGrid.setValue(i,'prdtId',rpi);
				chooseRwmatrLotGrid.setValue(i,'planDetaId',pdi);
				chooseRwmatrLotGrid.setValue(i,'ord',pio);
				
				// 행의 현재고값
				iqy = parseInt(chooseRwmatrLotGrid.getValue(i,'qy'));
				rwq = parseInt(rwq);
				// iqy = 현재고, rwq = 필요량
				console.log(iqy);
				console.log(rwq);
				console.log(rwq-iqy);
				
				if( iqy < rwq) {
					console.log("현재고가 더 작음")
					chooseRwmatrLotGrid.setValue(i,'oustQy',iqy);
					rwq = rwq-iqy
					chooseRwmatrLotGrid.check(i);
				} else {
					chooseRwmatrLotGrid.setValue(i,'oustQy',rwq);
					console.log("현재고가 더 큼")
					chooseRwmatrLotGrid.check(i);
					
					let sumVal = chooseRwmatrLotGrid.getSummaryValues('oustQy').sum;
					console.log(sumVal);
					console.log(document.getElementById("rwneed").value);
					
					return;
				}
				
			}
			
		})
	}
	
	$("#btnchoose").on(
			"click", function(){
				
				console.log(chooseRwmatrLotGrid.getCheckedRows());
				
				let gcr = chooseRwmatrLotGrid.getCheckedRows();
				console.log(gcr);
				
				for( let i=0 ; i<gcr.length ; i++) {
					RwmatrLotGrid.appendRow({'nm':rwn, 'prdtId':rpi, 'planDetaId':pdi})
				}

				moveCR(gcr);
				
				/* let rrc = RwmatrLotGrid.getRowCount();
				console.log(rrc);
				
				for( let i=0 ; i<gcr.length ; i++){
					console.log("자재LOT 등록")
					RwmatrLotGrid.setValue(rrc, 'nm', rwn);
					RwmatrLotGrid.setValue(rrc, 'lotNo', gcr[i].lotNo);
					RwmatrLotGrid.setValue(rrc, 'oustQy', gcr[i].oustQy);
					RwmatrLotGrid.setValue(rrc, 'expdate', gcr[i].expdate);
				} */
				
			});
</script>
</body>
</html>