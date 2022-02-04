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
	
	<div id="prdtStcGrid" style="width: 100%"></div>
	
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
		    align: 'center'
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
				
			console.log(prdtStcGrid.getCheckedRows());
				
			let gcr = prdtStcGrid.getCheckedRows();
			console.log(gcr);
				
			for( let i=0 ; i<gcr.length ; i++) {
			    prdtStcGrid.appendRow({'prdtId':pid})
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