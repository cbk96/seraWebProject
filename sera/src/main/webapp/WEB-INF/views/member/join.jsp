<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- 날짜 형식을 변경하기 위해 사용 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sera</title>
<link rel="stylesheet" href="/resources/css/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member.css">
<link rel="stylesheet" href="/resources/css/flexslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/resources/js/script.js"></script>
<script src="/resources/js/acordian.js"></script>
<script src="/resources/js/jquery.flexslider.js"></script>
</head>

   <script>
	   	function post_codeSearch(){
	   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes, resizable=no");
	   	}
   </script>
   <script src="/resources/js/inputDupliChk.js"></script>
   
   <section>
   		<div class="page-title page-title-wide">
   			<span>JOIN</span><span>US</span>
   		</div>
   		
		<form action="/member/join"  method="post" name="member_form">
	 		<h3 class="content-title">기본정보</h3>
	 		<p><span>*</span>는 필수 사항입니다.</p>
	 		<ul class="input-layout input-layout-border input-layout-wide" >
				<li>
					<label><span>*</span>아이디</label>
					<input type="text"  name="user_id" maxLength="10" required class="input-default input-bottom-border">
				</li>
				<li id="idChkContainer" class="inputChkContainer"><p id="idChkCMsg"></p></li>
				<li>
					<label><span>*</span>이름</label>
					<input type="text"  name="name"  maxLength="20" required class="input-default input-bottom-border">
				</li>
				<li>
					<label><span>*</span>비밀번호</label>
					<input type="password"  maxLength="20" name="user_pwd" required class="input-default input-bottom-border">
				</li>
				<li>
					<label><span>*</span>닉네임</label>
					<input type="text"  name="nick_name" maxLength="20" required class="input-default input-bottom-border">
				</li>
				<li id="nickChkContainer" class="inputChkContainer"><p id="nickChkCMsg"></p></li>
				<li>
					<label><span>*</span>연락처</label>
					<input type="text"  name="tel"  maxLength="13" required class="input-default input-bottom-border">
				</li>
				<li  class="radio-container radio-container-2child">
					<label><span>*</span>성별</label>
					<div>
						<input type="radio"   id="male"  name="gender" value="male" checked class="input-default input-bottom-border">
						<label for="male">남 자</label>
						<input type="radio"  id="female" name="gender" value="female" class="input-default input-bottom-border">
						<label for="female">여 자</label>
					</div>
				</li>
				<li class="radio-container radio-container-3child">
					<label><span>*</span>피부타입</label>
					<div>
						<input type="radio"  id="oily_skin" name="skin_type" value="oily_skin" checked class="input-default input-bottom-border">
						<label for="oily_skin">지성</label>
						<input type="radio"  id="dry_skin" name="skin_type" value="dry_skin" class="input-default input-bottom-border">
						<label for="dry_skin">건성</label>
						<input type="radio"  id="combination_skin" name="skin_type" value="combination_skin" class="input-default input-bottom-border">
						<label for="combination_skin">복합성</label>
					</div>
				</li>
				<li class="input-btn-container input-address">
					<label><span></span>주소</label>
					<input type="text"  name="post_code"  readonly class="input-default input-bottom-border">
					<button type="button" onclick="post_codeSearch()" class="btn btn-navy">우편번호 찾기</button>
				</li>
				<li>
					<label></label>
					<input type="text"  name="address" placeholder="상세 주소"  maxLength="100" class="input-default input-bottom-border">
				</li>
			</ul>
	   		
	   		<h3 class="content-title">추가정보</h3>
	   		<ul class="input-layout input-layout-border input-layout-wide">
	   			<li>
					<label><span></span>이메일</label>
					<input type="email"  name="email"  maxLength="50" class="input-default input-bottom-border">
				</li>
	   			<li>
					<label><span></span>생년월일</label>
					<input type="date"  name="birth" class="input-default input-bottom-border">
				</li>
				<li>
					<label><span></span>선호브랜드</label>
					<input type="text"  name="brand" class="input-default input-bottom-border">
				</li>
				<li class="radio-container radio-container-3child">
					<label class="label-twoLine"><span>사이트</span><span>접근 경로</span></label>
					<div>
						<input type="radio"  id="from_friend" name="access_route" value="from_friend" checked class="input-default input-bottom-border">
						<label for="from_friend">지인의 추천</label>
						<input type="radio"  id="from_searching" name="access_route" value="from_searching"  class="input-default input-bottom-border">
						<label for="from_searching">인터넷 검색</label>
						<input type="radio"  id="from_commercial" name="access_route" value="from_commercial"  class="input-default input-bottom-border">
						<label for="from_commercial">광고</label>
					</div>
				</li>
	   		</ul>
	   		<ul>
				<li class="confirm-btn-container" >
	   				<button type="submit" id="btn-join" class="btn btn-main" disabled="disabled">회원가입</button>
	   				<a href="/" class="btn btn-navy">취소</a>
	   			</li>
	   		</ul>
 		</form>
	</section>
</body>
</html>