<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>함께 걸음</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/careMember/careMember.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/careMember/careMemberModal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<script defer
	src="${pageContext.request.contextPath}/assets/js/main/include.js"></script>
<%-- <script defer src="${pageContext.request.contextPath}/assets/js/careMember/careMember.js"></script> --%>
<script defer
	src="${pageContext.request.contextPath}/assets/js/careMember/careMemberModalLogin.js"></script>
</head>
<body>
	<jsp:include page="/header.jsp" />
	<main>
		<!-- 돌봄회원 리스트 페이지 컨테이너  -->
		<div class="main_body">
			<!-- 돌봄회원 리스트 페이지 제목 -->
			<p class="page_title">돌봄회원 리스트</p>
			<!-- 검색 창 바 -->
			<div id="search_area">
				<!-- 검색 창 분류 선택 메뉴 -->
				<select id="search_criteria">
					<!-- 이름 검색 -->
					<option value="name">이름</option>
					<!-- 소개 검색 -->
					<option value="introduce">소개</option>
				</select>
				<!-- 검색 입력 창 -->
				<input type="text" id="criteria" placeholder="검색어를 입력하세요">
				<!-- 검색 버튼 -->
				<div id="search_icon_box">
					<!-- 검색 버튼 이미지 -->
					<img id="search_icon"
						src="${pageContext.request.contextPath}/assets/img/careMember/search_icon.png">
				</div>
			</div>
			<div id="day_list">
				<div>
					<input type="checkbox" id="mon" checked>월
				</div>
				<div>
					<input type="checkbox" id="tue" checked>화
				</div>
				<div>
					<input type="checkbox" id="wed" checked>수
				</div>
				<div>
					<input type="checkbox" id="thu" checked>목
				</div>
				<div>
					<input type="checkbox" id="fri" checked>금
				</div>
				<div>
					<input type="checkbox" id="sat" checked>토
				</div>
				<div>
					<input type="checkbox" id="sun" checked>일
				</div>
			</div>
			<!-- 카드 리스트 컨텍스트 -->
			<div class="context">
				<!-- 카드 행 1 -->
				<div class="card_row">
					<!-- 카드 행 리스트 ul1 -->

					<!-- 카드1 -->
					<ul id="card_list_1">
						<c:choose>
							<c:when test="${not empty careList }">
								<c:forEach var="care" items="${careList}">
									<li class="care_card">
										<div class="heart_img_box">
											<img draggable="false" class="heart_img"
												src="./../../assets/img/careMember/heart_icon.png">
										</div> <a href="${pageContext.request.contextPath}/careList/careListDetailOk.cl?usersNumber=${care.usersNumber}" class="profile">
											<div class="profile_pic_box">
												<img class="profile_pic"
													src="${pageContext.request.contextPath}/${care.getProfilesFilesPath() }/${care.getProfilesFilesName()}.${care.getProfilesFilesType()}">
											</div>
											
											<div class="profile_name">
												<c:out value="${care.getUsersName() }"></c:out>
											</div> 
											<div class="profile_day">
												<c:if test="${care.getDayMonday() eq 'Y'}">
												<div class="day">월</div>
											</c:if> <c:if test="${care.getDayTuesday() eq 'Y'}">
												<div class="day">화</div>
											</c:if> <c:if test="${care.getDayWednesday() eq 'Y'}">
												<div class="day">수</div>
											</c:if> <c:if test="${care.getDayThursday() eq 'Y'}">
												<div class="day">목</div>
											</c:if> <c:if test="${care.getDayFriday() eq 'Y'}">
												<div class="day">금</div>
											</c:if> <c:if test="${care.getDaySaturday() eq 'Y'}">
												<div class="day">토</div>
											</c:if> <c:if test="${care.getDaySunday() eq 'Y'}">
												<div class="day">일</div>
											</c:if>					
											</div>
											
											<div class="profile_intro">
												<div class="short_intro">
													<c:out value="${care.getCareIntroText() }"></c:out>
												</div>
												<div class="long_intro">
													<p>
														<c:out value="${care.getProfilesFilesName() }"></c:out>
													</p>
													<p>
														<c:out value="${care.getUsersAddressLine1() }"></c:out>
														거주
													</p>
												</div>
											</div>
									</a>
									</li>
								</c:forEach>
							</c:when>
						</c:choose>
					</ul>
				</div>

				<!-- 카드 행 2 -->
				<div class="card_row">
					<!-- 카드 행 리스트 ul2 -->
					<ul id="card_list_2">
					</ul>
				</div>
				<!-- 페이지 네이션 -->
				<div id="pagenation">
					<ul class="paging">
						<c:if test="${prev}">
							<li><a
								href="${pageContext.request.contextPath}/careList/careListOk.cl?page=${startPage - 1}"
								class="prev">&lt;</a></li>
						</c:if>
						<c:set var="realStartPage"
							value="${startPage < 0 ? 0 : startPage}" />
						<c:forEach var="i" begin="${realStartPage}" end="${endPage}">
							<c:choose>
								<c:when test="${!(i == page) }">
									<li><a
										href="${pageContext.request.contextPath}/careList/careListOk.cl?page=${i}">
											<c:out value="${i}" />
									</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="#" class="active"> <c:out value="${i}" />
									</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${next}">
							<li><a
								href="${pageContext.request.contextPath}/shops/shopsListOk.sh?page=${endPage + 1}"
								class="next">&gt;</a>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="/footer.jsp" />
	<div id="careMemberModalLogin"></div>
</body>


</html>
