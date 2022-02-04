<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</head>
<body>
	<!-- 설비구분 모달 -->
	<div id="dialog-form" title="설비구분"></div>
	<div class="container" style="margin: 0px;">
		<div class="container">
			<br>
			<h2 id="title">설비 등록</h2>
			<form action="${pageContext.request.contextPath}/eqm/insertEqm.do"
				method="post" name="frm" enctype="multipart/form-data">
				<br>
				<div class="grid-option-area">
					<div class="flex row">
						<div class="col-9">
							<table class="table table-bbs table-write">
								<colgroup>
									<col style="width: 90px">
									<col style="width: 200px">
									<col style="width: 90px">
									<col style="width: 200px">
									<col style="width: 90px">
									<col style="width: 230px">
								</colgroup>
								<tbody>
									<tr class="height: 37px !important;">
										<th>설비명*</th>
										<td><input id="eqmName" name="eqmName" required
											class="form-control w140"></td>
										<th>사용여부</th>
										<td><input type="radio" id="useYn" name="useYn" value="Y"
											checked>Y <input type="radio" id="notUse"
											name="useYn" value="N">N</td>
										<th>설비구분</th>
										<td><input id="fg" name="fg" required
											class="form-control ta-r" style="width: 50px;">
											<button id="btnFindFg" type="button"
												class="btn btn-find-small" data-bs-toggle="modal"
												aria-label="Close">🔍</button> <input type="text"
											id="fgName" name="fgName" class="form-control"
											style="width: 100px;" disabled></td>
									</tr>
									<tr>
										<th>설비규격</th>
										<td><input id="spec" name="spec"></td>
										<th>모델번호</th>
										<td><input id="modelNo" name="modelNo"></td>
										<th>제작업체</th>
										<td><input id="vendId" name="vendId"></td>
									</tr>
									<tr>
										<th>등록자</th>
										<td><input id="mngr" name="mngr" width="50px"></td>
										<th>설비규격</th>
										<td><input></td>

										<th>구매일자*</th>
										<td><input type="date" id="pureDt" name="pureDt" required></td>
									</tr>
									<tr>
										<th>온도</th>
										<td><input placeholder="최저온도" id="tempMin" name="tempMin">~<input
											placeholder="최고온도" id="tempMax" name="tempMax">°C</td>
										<th>UPH*</th>
										<td><input id="uph" name="uph" required></td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-3" style="width: 670px;">
							<h3>설비 이미지 등록</h3>
							<div class="image-container">
								<img style="width: 250px;" id="preview-image"
									src="../resources/images/img/이미지프리뷰.jpg">
							</div>

							<!-- egov 파일업로드 시작 -->

							<input name="file_1" id="egovComFileUploader" type="file"
								title="설비 이미지 업로드" multiple />
							<div id="egovComFileList"></div>

							<!-- egov 파일 업로드 끝 -->

						</div>
						<div>
							<button type="reset" value="내용초기화" class="btn cur-p btn-dark">초기화</button>
							<button class="btn cur-p btn-outline-dark">저장</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image")
	            previewImage.src = e.target.result
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
			console.log(input.files[0]);
	    }
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("egovComFileUploader")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})
	
//설비구분 모달
	let dialog = $( "#dialog-form" ).dialog({
		autoOpen :false,
		modal : true
	});
	
	$("#btnFindFg").on("click",function(){
		
		dialog.dialog("open");
		$("#dialog-form").load("${path}/eqm/searchFgModal.do", 	//load가 익숙치 않으면 ajax를 써도됨
				function(){
			seolbiGrid.readData(1, {codeId:"EQM002"}, true);
			console.log("설비구분모달 로드됨")})
	});

</script>
</body>
</html>