<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- 날짜 형식을 변경하기 위해 사용 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0; minimum-scale=1.0; user-scalable=no;">
<title>Sera</title>
<link rel="stylesheet" href="/resources/css/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member.css">
<link rel="stylesheet" href="/resources/css/flexslider.css">
<link rel="stylesheet" href="/resources/css/goodsStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/resources/js/script.js"></script>
<script src="/resources/js/acordian.js"></script>
<script src="/resources/js/jquery.flexslider.js"></script>
<script>
	$(function(){
		var btnLogout = $(".btn-logout");
		
		if(btnLogout!=null){
			btnLogout.click(function(){
				if(confirm("로그아웃 하시겠습니까?")){
					location.href="/member/logout";
				}
			});
		}
		
		window.addEventListener("resize", function(){
			mmenuClose();
		});
		
	});
	
	//모바일 메뉴 닫기
	function mmenuClose(){
		var blackScreen = document.getElementById("black-screen");
		var mmenuContainer = document.getElementById("main-menu-mobile-container");
		
		//mmenu.style.left = "-100%";
		blackScreen.style.left = "100%";
		mmenuContainer.style.left = "-100%";
	}
	function mmenuOpen(){
		var blackScreen = document.getElementById("black-screen");
		var mmenuContainer = document.getElementById("main-menu-mobile-container");
		
		blackScreen.style.left = "0%";
		mmenuContainer.style.left = "0%";
	}
</script>
</head>
<header id="main-header" class="fixed-header">
	<nav>
		<div id="black-screen" onclick="mmenuClose()"></div>
		<h1 id="top-logo"><a href="/">Sera</a></h1>
		<ul class="main-menu">
			<li><a href="/goods/">전체상품</a>
			<li><a href="/goods/?main_type=헤어케어 ">헤어케어</a>
				<ul class="sub-menu">
					<li><a href="/goods/?main_type=헤어케어&sub_type=샴푸">샴푸</a></li>
					<li><a href="/goods/?main_type=헤어케어&sub_type=트리트먼트">트리트먼트</a></li>
					<li><a href="/goods/?main_type=헤어케어&sub_type=세럼">세럼</a></li>
				</ul>
			</li>
			<li><a href="/goods/?main_type=바디 핸드케어 ">바디 핸드케어</a>
				<ul class="sub-menu">
					<li><a href="/goods/?main_type=바디 핸드케어&sub_type=바디케어">바디케어</a></li>
					<li><a href="/goods/?main_type=바디 핸드케어&sub_type=핸드케어">핸드케어</a></li>
					<li><a href="/goods/?main_type=바디 핸드케어&sub_type=청결제">청결제</a></li>
				</ul>
			</li>
			<li><a href="/goods/?main_type=스킨 클렌징 ">스킨 클렌징</a>
				<ul class="sub-menu">
					<li><a href="/goods/?main_type=스킨 클렌징&sub_type=스킨케어">스킨케어</a></li>
					<li><a href="/goods/?main_type=스킨 클렌징&sub_type=선 립케어">선 립케어</a></li>
				</ul>
			</li>
			<li><a href="/goods/?main_type=라이프">라이프</a>
				<ul class="sub-menu">
					<li><a href="/goods/?main_type=라이프&sub_type=디퓨저 캔들">디퓨저 캔들</a></li>
					<li><a href="/goods/?main_type=라이프&sub_type=섬유 구강케어">섬유 구강케어</a></li>
					<li><a href="/goods/?main_type=라이프&sub_type=세탁세제">세탁세제</a></li>
				</ul>
			</li>
			<li><a href="/goods/goodsListBySkinType">피부 타입별</a>
				<ul class="sub-menu">
					<li><a href="/goods/goodsListBySkinType?skin_type=oily_skin">지성 피부</a></li>
					<li><a href="/goods/goodsListBySkinType?skin_type=dry_skin">건성 피부</a></li>
					<li><a href="/goods/goodsListBySkinType?skin_type=combination_skin">복합성 피부</a></li>
				</ul>
			</li>
			
			<li class="user-menu-hd"><div><i class="bi bi-person-fill"></i></div>
				<c:if test="${loginMember != null}">
					<ul>
						<c:if test="${loginMember.member_type=='admin'}"><li><a href="/admin/emp/login">관리자모드</a></li></c:if>
						<li><a href="/goods/cart" >장바구니</a></li>
						<li><button class="btn btn-logout">로그아웃</button></li>
						<li><a href="/member/mypage">${loginMember.nick_name}님</a></li>
					</ul>
				</c:if>
				<c:if test="${loginMember == null}">
					<ul class="user-menu">
						<li><a href="/goods/cart" >장바구니</a></li>
						<li><a href="/member/login">로그인</a></li>
						<li><a href="/member/join">회원가입</a></li>
					</ul>
				</c:if>
			</li>
		</ul>
		
		<div class="main-menu-mobile-container" id="main-menu-mobile-container">
			<aside>
				<p class="mmenu-close-btn" onclick="mmenuClose()"><i class="bi bi-x-lg"></i></p>
				<c:if test="${loginMember != null}">
					<div class="login-menu-mobile">
						<ul>
							<c:if test="${loginMember.member_type=='admin'}"><li><a href="/admin/emp/login">관리자모드</a></li></c:if>
							<li><button class="btn btn-logout">로그아웃</button></li>
							<li><a href="/member/mypage">${loginMember.nick_name}님</a></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${loginMember == null}">
					<div class="login-menu-mobile">
						<ul>
							<li><a href="/member/login">로그인</a></li>
							<li><a href="/member/join">회원가입</a></li>
						</ul>
					</div>
				</c:if>
				<ul class="main-menu-mobile acordian-menu-container">
					<li><p class="acordian-btn"><a href="/goods/">전체상품</a></p></li>
					<li><p class="acordian-btn">헤어케이</p>
						<ul class="sub-menu acordian-menu">
							<li><a href="/goods/?main_type=헤어케어">ALL</a></li>
							<li><a href="/goods/?main_type=헤어케어&sub_type=샴푸">샴푸</a></li>
							<li><a href="/goods/?main_type=헤어케어&sub_type=트리트먼트">트리트먼트</a></li>
							<li><a href="/goods/?main_type=헤어케어&sub_type=세럼">세럼</a></li>
						</ul>
					</li>
					<li><p class="acordian-btn">바디/핸드케어</p>
						<ul class="sub-menu acordian-menu">
							<li><a href="/goods/?main_type=바디 핸드케어">ALL</a></li>
							<li><a href="/goods/?main_type=바디 핸드케어&sub_type=바디케어">바디케어</a></li>
							<li><a href="/goods/?main_type=바디 핸드케어&sub_type=핸드케어">핸드케어</a></li>
							<li><a href="/goods/?main_type=바디 핸드케어&sub_type=청결제">청결제</a></li>
						</ul>
					</li>
					<li><p class="acordian-btn">스킨/클렌징</p>
						<ul class="sub-menu acordian-menu">
							<li><a href="/goods/?main_type=스킨 클렌징">ALL</a></li>
							<li><a href="/goods/?main_type=스킨 클렌징&sub_type=스킨케어">스킨케어</a></li>
							<li><a href="/goods/?main_type=스킨 클렌징&sub_type=선 립케어">선 립케어</a></li>
						</ul>
					</li>
					<li><p class="acordian-btn">라이프</p>
						<ul class="sub-menu acordian-menu">
							<li><a href="/goods/?main_type=라이프">ALL</a></li>
							<li><a href="/goods/?main_type=라이프&sub_type=디퓨저 캔들">디퓨저 캔들</a></li>
							<li><a href="/goods/?main_type=라이프&sub_type=섬유 구강케어">섬유 구강케어</a></li>
							<li><a href="/goods/?main_type=라이프&sub_type=세탁세제">세탁세제</a></li>
						</ul>
					</li>
					<li><p class="acordian-btn">피부 타입별</p>
						<ul class="sub-menu acordian-menu">
							<li><a href="/goods/goodsListBySkinType?skin_type=oily_skin">지성 피부</a></li>
							<li><a href="/goods/goodsListBySkinType?skin_type=dry_skin">건성 피부</a></li>
							<li><a href="/goods/goodsListBySkinType?skin_type=combination_skin">복합성 피부</a></li>
						</ul>
					</li>
				</ul>
			</aside>
		</div>
		
		<c:if test="${loginMember != null}">
			<ul class="user-menu">
				<c:if test="${loginMember.member_type=='admin'}"><li><a href="/admin/emp/login">관리자모드</a></li></c:if>
				<li><a href="/goods/cart" >장바구니</a></li>
				<li><button class="btn btn-logout">로그아웃</button></li>
				<li><a href="/member/mypage">${loginMember.nick_name}님</a></li>
			</ul>
			<ul class="user-menu-mobile">
				<li><h1 id="m-top-logo"><a href="/">Sera</a></h1></li>
				<li><p id="burger-line" onclick="mmenuOpen()"><span></span><span></span><span></span></p></li>
				<li><a href="/goods/cart"><i class="bi bi-cart"></i></a></li>
			</ul>
		</c:if>
		
		<c:if test="${loginMember == null}">
			<ul class="user-menu">
				<li><a href="/goods/cart" >장바구니</a></li>
				<li><a href="/member/login">로그인</a></li>
				<li><a href="/member/join">회원가입</a></li>
			</ul>
			<ul class="user-menu-mobile">
				<li><h1 id="m-top-logo"><a href="/">Sera</a></h1></li>
				<li><p id="burger-line" onclick="mmenuOpen()"><span></span><span></span><span></span></p></li>
				<li><a href="/goods/cart" ><i class="bi bi-cart"></i></a></li>
			</ul>
		</c:if>
		
		
		
	</nav>
</header>
