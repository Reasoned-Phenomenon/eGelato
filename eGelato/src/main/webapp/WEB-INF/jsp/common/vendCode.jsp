<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 코드 관리 페이지</title>
</head>
<body>
	<div>
		<h3>거래처 코드 관리</h3>	
	</div>
	
	<form>
		<div>
			<br>
			<label>거래처 코드</label>
			<input type="text" id="vendId" name="vendId" readonly>
			
			<label>거래처 명</label>
			<input type="text" id="vendName" name="vendName" readonly>
			
			<label>사업자 등록번호</label>
			<input type="text" id="bizno" name="bizno" readonly>
			
			<label>전화 번호</label>
			<input type="text" id="telno" name="telno" readonly>
			
		</div>
		<div style="float: right;">
			<button type="button" class="btn cur-p btn-outline-primary" id="SearchBtn">조회</button>
			<button type="button" class="btn cur-p btn-outline-primary" id="AddBtn">추가</button>
			<button type="button" class="btn cur-p btn-outline-primary" id="SaveBtn">저장</button>
			<button type="reset" class="btn cur-p btn-outline-primary">초기화</button>
		</div>
	</form>
	
<div id="vendCodeGrid" style="width: 100%"></div>


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
var vendCodeGrid = new Grid({
	el: document.getElementById('vendCodeGrid'),
	data : {
	  api: {
	    readData: 	{ url: '${path}/com/vendCodeList.do', method: 'GET'},
	    modifyData : { url: '${path}/com/vendCodeModifyData.do', method: 'PUT'}
	  },
	  contentType: 'application/json',
	  initialRequest: false
	},
	rowHeaders: ['rowNum'],
	selectionUnit: 'row',
	bodyHeight : 500,
	columns:[
			{
			  header: '거래처 코드',
			  name: 'vendId',
			  align: 'center'
		      
			},
			{
			  header: '거래처 명',
			  name: 'vendName',
			  align: 'center',
		      editor:'text'
	          
			},
			{
			  header: '사업자 등록번호',
			  name: 'bizno',
			  align: 'center',
		      editor:'text'
		      
			},
			{
			  header: '전화 번호',
			  name: 'telno',
			  align: 'center',
		      editor:'text'
			      
			},
			{
			  header: '비 고',
			  name: 'remk',
			  align: 'center',
		      editor:'text'
				      
			},
			{
			  header: '구 분',
			  name: 'fg',
			  align: 'center',
			  editor:'text'
					      
			}

		]
});

 // 더블클릭시 그리드에서 한행 선택 입력폼에 값 들어가게 함.
 vendCodeGrid.on("dblclick", (ev) => {
		
	    $("#vendId").val(vendCodeGrid.getValue(ev["rowKey"],"vendId"));
		$("#vendName").val(vendCodeGrid.getValue(ev["rowKey"],"vendName"));
		$("#bizno").val(vendCodeGrid.getValue(ev["rowKey"],"bizno"));
		$("#telno").val(vendCodeGrid.getValue(ev["rowKey"],"telno"));

	});

 // 조회 버튼 이벤트.
 SearchBtn.addEventListener("click", function() {
		console.log("조회버튼 클릭");
		 var vendId = document.getElementById("vendId").value;
		 var vendName = document.getElementById("vendName").value; 
		 var bizno = document.getElementById("bizno").value;  
		 var telno = document.getElementById("telno").value;    
		
		 vendCodeGrid.readData(1, {'vendId':vendId, 'vendName':vendName,'bizno':bizno,'telno':telno}, true);
	});
 
 // 그리드 행 추가 버튼 이벤트.
 	AddBtn.addEventListener("click", function(){
 		vendCodeGrid.prependRow();
	});
 
	//컨트롤러 응답
	vendCodeGrid.on('response', function (ev) {
		console.log(ev)
		if(flag == 'O') {
			vendCodeGrid.readData(1);
			flag = 'X';
		}
		
	});
 
	
  // 등록 버튼 이벤트.
	SaveBtn.addEventListener("click", function() {
		vendCodeGrid.blur();
		vendCodeGrid.request('modifyData');
		flag = 'O'
	});

 
  

</script>






	
	
</body>
</html>