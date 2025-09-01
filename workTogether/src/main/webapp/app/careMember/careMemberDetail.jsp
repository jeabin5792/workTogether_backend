<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>함께 걸음</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/careMember/careMemberDetail.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<script defer
	src="${pageContext.request.contextPath}/assets/js/careMember/careMemberDetail.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/careMember/careMemberModal.css">
</head>

<body>
	<jsp:include page="/header.jsp" />
	<main>
		<!-- 돌봄회원 리스트 페이지 컨테이너  -->
		<div class="main_body">
			<!-- 컨텍스트 -->
			<div class="context">
				<!-- 프로필 정보 영역 -->
				<span class="profile_area"> <!-- 프로필 div박스 -->
					<div class="profile">
						<!-- 프로필 픽 박스 -->
						<div class="profile_pic_box">
							<div id="heart_img_box">
								<img draggable="false" onclick="switchHeart()" id="heart_img"
									src="${pageContext.request.contextPath}/assets/img/careMember/heart_icon.png">
							</div>
							<!-- 프로필 사진 -->
							<div class="profile_pic_frame">
								<img class="profile_pic"
									src="${pageContext.request.contextPath}/${care.getProfilesFilesPath() }/${care.getProfilesFilesName()}.${care.getProfilesFilesType()}">
							</div>
							<!-- 프로필 정보 칸 -->
							<div class="profile_intro">
								<!-- 프로필 이름 -->
								<div class="profile_name">
									<c:out value="${care.getUsersName() }"></c:out>
								</div>
								<!-- 프로필 날짜 -->
								<div class="profile_day_row">
									<!-- 날짜 -->
									<c:if test="${care.getDayMonday() eq 'Y'}">
										<div class="day">월</div>
									</c:if>
									<c:if test="${care.getDayTuesday() eq 'Y'}">
										<div class="day">화</div>
									</c:if>
									<c:if test="${care.getDayWednesday() eq 'Y'}">
										<div class="day">수</div>
									</c:if>
									<c:if test="${care.getDayThursday() eq 'Y'}">
										<div class="day">목</div>
									</c:if>
									<c:if test="${care.getDayFriday() eq 'Y'}">
										<div class="day">금</div>
									</c:if>
									<c:if test="${care.getDaySaturday() eq 'Y'}">
										<div class="day">토</div>
									</c:if>
									<c:if test="${care.getDaySunday() eq 'Y'}">
										<div class="day">일</div>
									</c:if>
								</div>
								<!-- 프로필 이력 -->
								<div class="profile_info">
									정보(이력) :
									<ul>
										<!-- 프로필 이력 정보 리스트 -->
										<li><c:out value="${care.getProfilesFilesName() }"></c:out>
										</li>
										<!-- 프로필 이력 정보 리스트 -->
										<li>· <c:out value="${care.getUsersAddressLine1() }"></c:out>
											거주
										</li>
									</ul>
								</div>
								<!-- 프로필 간단 소개 -->
								<div class="profile_short_intro">
									소개 :
									<div>
										·
										<c:out value="${care.getCareIntroText() }"></c:out>
									</div>
								</div>
							</div>
						</div>
					</div> <!-- 쪽지 보내기 박스 -->
					<div id="send_button_box">
						<!-- 쪽지 보내기 버튼 -->
						<button onclick="sendLetterButtonClick()" id="send_button">
							쪽지 보내기</button>
					</div>
				</span>
				<!-- 후기 영역 -->
				<span class="comments_area"> <!-- 후기 패널 박스 -->
					<div class="comment_pannel">
						<!-- 후기 분류 제목 -->
						<div class="comment_column">
							<!-- 후기 순번 분류 -->
							<div class="comment_number_column">순번</div>
							<!-- 후기 작성자 분류 -->
							<div class="comment_author_column">작성자</div>
							<!-- 후기 제목 분류 -->
							<div class="comment_context_column">제목</div>
							<!-- 후기 날짜 분류 -->
							<div class="comment_date_column">날짜</div>
						</div>
						<!-- 후기 리스트 ul -->
						<ul class="comment_list">
							<!-- 후기 리스트 li -->
							<li class="comment">
								<div class="comment_div">
									<div class="comment_number">1</div>
									<div class="comment_author">아무개</div>
									<div class="comment_context">나중에 또 부탁드립니다.</div>
									<div class="comment_edit">
										<button type=button class="edit_btn">수정</button>
									</div>
									<div class="comment_del">
										<button type=button class="del_btn">삭제</button>
									</div>
									<div class="comment_date">2025-08-02</div>
								</div>
							</li>
							<!-- 후기 리스트 li -->

						</ul>
						<!-- 후기 작성 박스 -->
						<div class="input_box">
							<!-- 후기 입력 창 -->
							<input type="text" id="comment_text" placeholder="후기를 작성하세요">
							<!-- 후기 작성 버튼 -->
							<button id="comment_button">작성</button>
						</div>
					</div> <!-- 페이지 네이션 -->
					<div id="comment_pagenation">
						&lt; <span class="active">1</span> 2 3 4 ... &gt;
					</div>
				</span>
			</div>
		</div>
	</main>
	<jsp:include page="/footer.jsp" />
	<jsp:include page="careMemberModal.jsp" />
	
</body>
<script>
	window.careNumber = "${care.usersNumber}"
	window.usersNumber = "${usersNumber}"
	console.log("현재 들어온 디테일 페이지의 회원 번호 " + window.careNumber);
	console.log("로그인 유저의 회원 번호" + usersNumber )
	
	function sendLetterButtonClick() {
		// html 문서에 모달 불러오기
		 confirmShowup() ;
	};

	//모달 요소 가져오기
	const modal = document.getElementById("modal");

	//input 요소 담을 변수
	let input;

	// 모달이 나타나는 함수(버튼에 추가하여 사용)
	function confirmShowup() {
		console.log("쪽지보내기 모달 클릭!!!");
		modal.style.display = "flex";
		console.log(modal);
		console.log("플렉스로 변경!!!");
		input = document.getElementById("letter_text");
		input.focus();
	}

	//모달 끄기 함수(모달 내부 x이미지에 추가되어 있음)
	function turnOffModal() {
		modal.style.display = "none";
	}
	function modalCheck() {
		const value = input.value.trim();
		if (!value) {
			alert("반려 사유를 입력하세요.");
			return;
		}
		console.log("전달할 값 : ", value);
		alert("입력됨 - " + value);
		turnOffModal();
		input.value = null;
	}
	function modalCancel() {
		turnOffModal();
	}

	turnOffModal();
	
</script>
</html>