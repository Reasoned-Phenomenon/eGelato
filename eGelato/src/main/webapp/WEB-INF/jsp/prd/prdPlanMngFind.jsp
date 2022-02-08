<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 조회</title>
</head>
<style>
th, td {
	padding: 5px;
}
</style>
<body>
    <div>
        <br>
        <h2>생산계획조회</h2>
        <br>
    </div>
    <br>
    <div>
        <table>
            <tbody>
                <tr>
                    <th>진행 구분</th>
                    <td>
                        <input type="radio" id="fgAll" name="fg" value="ALL" checked>전체
                        <input type="radio" id="fgPro" name="fg" value="PROCEE">진행
                        <input type="radio" id="fgFin" name="fg" value="FINISH">완료
						<input type="radio" id="fgCan" name="fg" value="CANCEL">취소
                    </td>
                </tr>
                <tr>
                    <th>제품명</th>
                    <td><input type="text" id="prdtNm" required></td>
                    
                </tr>
                <tr>
                    <th>계획 일자</th>
                    <td><input type="date" id="startD" required> ~ <input type="date" id="endD" required></td>
                    <td>
                        <button type="button"  id="btnSearch">검색</button>
                        <button type="button"  id="btnClear">초기화</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <br>
    <!-- 계획 조회 그리드 -->
    <div id="PlanSearchGrid"></div>
    
    <!-- 제품 모달창 -->
    <div id="PrdtDialog" title="제품 목록"></div>
    
    
    <script>
    var startD;
    var endD;
    var prdtNm;
    var fg;
    
    	
    //생산계획일자 현재날짜 기본 설정
	const d = new Date();

	const year = d.getFullYear(); // 년
	const month = d.getMonth();   // 월
	const day = d.getDate();      // 일
	
	document.getElementById('startD').value = new Date(year, month, day - 7).toISOString().substring(0,10);
	document.getElementById('endD').value = new Date().toISOString().substring(0, 10);
	
    //
   	// 계획 조회 그리드 생성
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

	// 그리드 생성 : 관리
	const PlanSearchGrid = new Grid({
		el : document.getElementById('PlanSearchGrid'),
		data : {
			api : {
				readData : {url : '${path}/prd/planListPF.do',method : 'GET'}
			},
			contentType : 'application/json',
			//initialRequest: false
		},
		rowHeaders : ['rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 600,
		columns : [ {
			header : '생산계획코드',
			name : 'planId'
		}, {
			header : '계획명',
			name : 'name',
		}, {
			header : '상세계획번호',
			name : 'planDetaId',
		}, {
			header : '제품명',
			name : 'prdtNm',
		}, {
			header : '제품코드',
			name : 'prdtId',
		}, {
			header : '계획량',
			name : 'qy',
			align: 'right',
		}, {
			header : '작업우선순위',
			name : 'priort',
			align: 'right',
		}, {
			header : '생산일수',
			name : 'prodDcnt',
			align: 'right',
		},{
			header : '진행구분',
			name : 'fg',
		},{
			header : '비고',
			name : 'remk',
		}]
	});
	
	$("#btnClear").on(
			"click",
			function() {
				$("#prdtNm").val('');
				PlanSearchGrid.clear();
			});
	
	// 제품명 클릭시 모달
	function selectPr(prid,prnm){
		console.log(prnm);
		console.log(prid);
		document.getElementById("prdtNm").value = prnm;
		PrdtDialog.dialog( "close" );
	}
	
	function callprdtModal(){
		// 모달창 생성
		PrdtDialog = $("#PrdtDialog").dialog({
			modal : true,
			autoOpen : false,
			height: 600,
			width: 500
		});
		
	    console.log("11111")
	    PrdtDialog.dialog( "open" );
	    $("#PrdtDialog").load(
							"${path}/prd/prdtDialogPF.do", function() {
								console.log("계획조회창 로드")
							})
	}
	
	document.getElementById("prdtNm").addEventListener("click", function() {
		  callprdtModal();
	});
	
	// 검색 클릭시
	$("#btnSearch").on(
			"click", function(){
				startD = document.getElementById("startD").value;
				endD = document.getElementById("endD").value;
				prdtNm = document.getElementById("prdtNm").value;
				fg = $("input[name=fg]:checked").val();
				
				console.log(startD);
				console.log(endD);
				console.log(prdtNm);
				console.log(fg);
				
				var params = {
						prdtNm : prdtNm,
						startD : startD,
						endD : endD,
						fg : fg
				}
				
				console.log(params);
				
				PlanSearchGrid.readData(1,{'prdtNm':prdtNm, 'startD':startD, 'endD':endD, 'fg':fg}, true);
			})
    </script>
</body>
</html>