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
	    <form action="">
		<button type="button" id="updateBtn" class="btn cur-p btn-outline-primary">확인</button>
		
	</form>
	
	<div id="prdtStcGrid" style="width: 120%"></div>
	
<script>
var Grid = tui.Grid;	

var iqy;

// 변수 선언.
let lno;      // 로트번호.
let ioutd;   // 입출고 날짜.
let isqy;    // 입고량.
let oqy;     // 출고량.
let edate;   // 유통기한.

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
var prdtStcGrid = new Grid({
	el: document.getElementById('prdtStcGrid'),
  	data : {
	  api: {
	    readData: { url:'${path}/biz/prdtStcList.do', method: 'GET'}
	  },
	  contentType: 'application/json'
	},
  	rowHeaders:[ 'checkbox','rowNum'],
  	selectionUnit: 'row',
  	bodyHeight: 400,
  	columns:[
  		  {
		    header: '완제품 LOT 번호',
		    name: 'lotNo',
		    align: 'center'
		  },
		  {
		    header: '완제품 수량',
		    name: 'prdtQy',
		    align: 'center'
		  },
	
		  {
		    header: '사용 수량',
		    name: 'oustQy',
		    align: 'center',
		    editor: 'text'
		  },
		  {
		    header: '제조 일자',
		    name: 'prodDt',
		    align: 'center'
		  },
		  {
			header: '유통 기한',
			name:'expdate',
			align: 'center'
		  },
		  {
			header: '구 분',
			name:'fg',
			align: 'center'
		  },
		  {
			header: '제품 코드',
			name:'prdtId',
			align: 'center'
			  }
		]
});
    //TODO 함수명 변수명 수정하기.
	function chooseRWI(pid,oqy,pnm) {
		
		$.ajax({
			url : "${path}/biz/oustLotList.do?prdtId=" + pid,
			dataType : 'json',
			error : function(result) {
				console.log('에러', result)
			}
		}).done(function (result) {
			console.log("확인.");
			console.log(result);
			
			prdtStcGrid.resetData(result.data.contents);
			prdtStcGrid.resetOriginData();
			
			let grc = prdtStcGrid.getRowCount();
			console.log(grc);
			
	  })

	}
	
	$("#updateBtn").on(
			"click", function(){
			console.log('=============================11');	
			console.log(prdtStcGrid.getCheckedRows());
			console.log(prdtStcGrid.getCheckedRows()[0].lotNo);
			console.log(prdtStcGrid.getCheckedRows()[0].istOustDttm);
			
				
			
			let gcr = prdtStcGrid.getCheckedRows();
			console.log(gcr);
				
			for( let i=0 ; i<gcr.length ; i++) {
				
				lno = prdtStcGrid.getCheckedRows()[i].lotNo;
				ioutd = prdtStcGrid.getCheckedRows()[i].istOustDttm;
				isqy = prdtStcGrid.getCheckedRows()[i].istQy;
				oqy = prdtStcGrid.getCheckedRows()[i].oustQy;
				edate = prdtStcGrid.getCheckedRows()[i].expdate;
				
				oustLotGrid.appendRow({'prdtId':pid, 'lotNo':lno, 
					                   'istOustDttm':ioutd,
					                    'istQy':isqy, 'oustQy':oqy,
					                    'expdate':edate})
			   		         
			console.log();		                    
			}
                       
			moveCR(gcr);
	
			});

</script> 
</body>
</html>