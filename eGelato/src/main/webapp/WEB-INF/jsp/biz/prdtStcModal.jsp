<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 재고 페이지 modal</title>
</head>
<style>
h1 {
	text-align: center
}
</style>
<body>
	<br>
	<h1>완제품 재고 현황</h1><br>
	  <form>
		<button type="button" id="checkBtn" class="btn cur-p btn-outline-primary">확인</button>
	  	주문 수량 : <input readonly="true" id="targetQyInput">
	  	선택된 수량: <input readonly="true" id="selectedQyInput">
	</form>
	
	<div id="prdtStcGrid" style="width: 140%"></div>
	
<script>
var Grid = tui.Grid;	

// 변수 선언.
var targetQy;

//그리드 생성
var prdtStcGrid = new Grid({
	el: document.getElementById('prdtStcGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/biz/prdtStcList.do', method: 'GET'}
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
  	rowHeaders:[ 'checkbox','rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 300,
  	width:600,
  	columns:[
  		  {
		    header: '완제품 LOT 번호',
		    name: 'lotNo',
		    align: 'center',
		    width:120
		  },
		  {
		    header: '완제품 수량',
		    name: 'qy',
		    align: 'right',
		    width:80
		  },
	
		  {
		    header: '출고량',
		    name: 'oustQy',
		    align: 'right',
		    editor: 'text',
		    width:80
		  },
		  {
		    header: '제조 일자',
		    name: 'prodDt',
		    align: 'right',
		    width:110
		  },
		  {
			header: '유통 기한',
			name:'expdate',
			align: 'right',
			width:110
		  },
		  {
			header: '구 분',
			name:'fg',
			align: 'center',
			hidden: true
		  },
		  {
			header: '입고량',
			name:'istQy',
			align: 'center',
			hidden: true
		  },
		  {
			header: '일출고 날짜',
			name:'istOustDttm',
			align: 'center',
			hidden: true
		  },
		  
		  {
			header: '제품 코드',
			name:'prdtId',
			align: 'center',
			hidden: true
		   },
		   {
			header: '주문 상세 코드',
			name:'orderShtDetaId',
			align: 'center',
			hidden: true
		   },
		],
		summary: {
	        height: 40,
	        position: 'bottom',
	        columnContent: {
          		oustQy: {
	            template: function(valueMap) {
	              return `합계: \${valueMap.sum}`;
	            }
	          }
	        }
	  }
});
 
function chooseRWI(row) {
   	
	targetQyInput.value = row.qy;
	
	$.ajax({
		url : "${path}/biz/prdtStcList.do?prdtId=" + row.prdtId,
		dataType : 'json',
		error : function(result) {
			console.log('에러', result)
		}
	}).done(function (result) {
		
		prdtStcGrid.resetData(result.data.contents);
		prdtStcGrid.resetOriginData();
		
		let grc = prdtStcGrid.getRowCount();
		
		let calcQy = targetQy = row.qy;
		
		//자동계산
		for(let i = 0 ; i < grc ; i ++ ) {
			
			if (calcQy == 0) {
				break;
			}
			
			let item = prdtStcGrid.getRow(i).qy;
			
			if( calcQy <= item ) {
				prdtStcGrid.setValue(i,'oustQy',calcQy)
				prdtStcGrid.check(i);
				calcQy = 0;
				break;
			} else {
				prdtStcGrid.setValue(i,'oustQy',item);
				prdtStcGrid.check(i);
				calcQy = calcQy - item;
			}
			
		}
		
		//수량 계산
		calcOustQy ();
		
  }) 

}
	
//모달창의 확인버튼
$("#checkBtn").on("click", function(){
	
	prdtStcGrid.blur();	
	
	let gcr = prdtStcGrid.getCheckedRows();
	
	//총합이 맞는지 체크
	let sumQy =0;
	for ( let i = 0 ; i < gcr.length ; i++ ) {
		sumQy += Number(gcr[i].oustQy);
	}
	
	if (targetQy != sumQy) {
		//토스트
		toastr.clear();
		toastr.error('수량이 맞지 않습니다','Gelato');
		return;
	}
	
	//체크만하고 값 안 넣은 로우 체크해제	
	for( let i=0 ; i<gcr.length ; i++) {
			
		if (!gcr[i].oustQy > 0 ) {
			prdtStcGrid.uncheck(i)
		}
		
	}
	
	moveCR(prdtStcGrid.getCheckedRows());

});
	
function calcOustQy () {
	let calcQy = 0 ;
	
	for(item of prdtStcGrid.getCheckedRows()) {
		calcQy += Number(item.oustQy);
	}
	
	selectedQyInput.value = calcQy;
	
}
	
prdtStcGrid.on('editingFinish',function () {
	calcOustQy ();
})

prdtStcGrid.on('check',function () {
	calcOustQy ();
})

prdtStcGrid.on('uncheck',function () {
	calcOustQy ();
})	
	
</script> 
</body>
</html>