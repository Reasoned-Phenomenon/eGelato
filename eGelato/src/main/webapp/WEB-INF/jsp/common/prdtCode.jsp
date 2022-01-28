<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 코드 관리 페이지</title>
</head>
<body>
	<div>
		<br>
		<h3>완제품 코드 관리</h3>
	</div>
	<form>
	<div>
		<br>
		<label>완제품 코드</label>
			<input type="text" id="prdtId" name="prdtId" readonly>
			
		<label>제품명</label>
		    <input type="text" id="prdtNm" name="prdtNm" readonly>
		  
		<label>규격</label>
			<input type="text" id="spec" name="spec" readonly>
			
		<label>단위</label>
			<input type="text" id="unit" name="unit" readonly>	
			
		<label>안전 재고</label>
			<input type="text" id="safStc" name="safStc" readonly>	   
		<br>	 	
	</div>
	<div style="float: right;">
		<button type="button" class="btn cur-p btn-outline-primary" id="SearchBtn">조회</button>
		<button type="button" class="btn cur-p btn-outline-primary" id="AddBtn">추가</button>
		<button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
		<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
	</div>
</form>

<div id="prdtCodeGrid" ></div>

<script>
let dialog;

//modify구분하기위한 변수
let flag;

var Grid = tui.Grid;

//그리드 테마.
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


//그리드 생성.
var prdtCodeGrid = new Grid({
	el: document.getElementById('prdtCodeGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/prdtCodeList.do', method: 'GET'},
	    modifyData : { url: '${path}/com/prdtCodeModifyData.do', method: 'PUT'}
	  },
	  contentType: 'application/json',
	  initialRequest: false

	},
	
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	bodyHeight : 500,
	columns:[
			{
			  header: '완제품 코드',
			  name: 'prdtId',
			  align: 'center'
		      
			},
			{
			  header: '제품명',
			  name: 'prdtNm',
			  align: 'center',
		      editor:'text'
	          
			},
			{
			  header: '규격',
			  name: 'spec',
			  align: 'center',
		      editor:'text'
		      
			},
			{
			  header: '단위',
			  name: 'unit',
			  align: 'center',
		      editor:'text'
			      
			},
			{
			  header: '안전 재고',
			  name: 'safStc',
			  align: 'center',
		      editor:'text'
				      
			}

		]
});
	
	// 더블클릭시 그리드에서 한행 선택 입력폼에 값 들어가게 하기.
	prdtCodeGrid.on("dblclick", (ev) => {
		$("#prdtId").val(prdtCodeGrid.getValue(ev["rowKey"],"prdtId"));
		$("#prdtNm").val(prdtCodeGrid.getValue(ev["rowKey"],"prdtNm"));
		$("#spec").val(prdtCodeGrid.getValue(ev["rowKey"],"spec"));
		$("#unit").val(prdtCodeGrid.getValue(ev["rowKey"],"unit"));
		$("#safStc").val(prdtCodeGrid.getValue(ev["rowKey"],"safStc"));
		
	});
	
	// 조회버튼 이벤트. 
	SearchBtn.addEventListener("click", function() {
		console.log("조회버튼 클릭");
		 var prdtId = document.getElementById("prdtId").value;
		 var prdtNm = document.getElementById("prdtNm").value; 
		 var spec = document.getElementById("spec").value;  
		 var unit = document.getElementById("unit").value;  
		 var safStc = document.getElementById("safStc").value;  
		
		prdtCodeGrid.readData(1,{'prdtId':prdtId, 'prdtNm':prdtNm,'spec':spec,'unit':unit,'safStc':safStc},true);
	});
	
	// 행 추가 버튼 이벤트.
	AddBtn.addEventListener("click", function(){
		prdtCodeGrid.prependRow();
	});
	
	//컨트롤러 응답
	prdtCodeGrid.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			prdtCodeGrid.readData(1);
			flag = 'X';
		}
		
	});

	// 저장(등록) 버튼 이벤트. (alert 창 포함.)
	SaveBtn.addEventListener("click", function() {
		prdtCodeGrid.request('modifyData');
		console.log("이거뭐양?" + prdtCodeGrid.getRow(0))
		
		if (prdtCodeGrid.getRow(0) != null) {
			prdtCodeGrid.blur();
		 if (confirm("저장하시겠습니까?")) {
			prdtCodeGrid.request('modifyData',{
				showConfirm : false
			});
		  }
		} else {
			alert("선택된 데이터가 없습니다.");
		}
		
		
		flag = 'O'
	});
	
	

</script>
</body>
</html>