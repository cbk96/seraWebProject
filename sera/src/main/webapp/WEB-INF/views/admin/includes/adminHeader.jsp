<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sera admin</title>
<link rel="stylesheet" href="/resources/css/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member.css">
<link rel="stylesheet" href="/resources/css/adminCommon.css">
<link rel="stylesheet" href="/resources/css/adminReset.css">
<link rel="stylesheet" href="/resources/css/goodsStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/resources/js/acordian.js"></script>
<script>
	$(function(){
		var btnLogout = document.getElementById("btn-logout");
		
		//로그아웃 
		if(btnLogout!=null){
			btnLogout.addEventListener("click", function(){
				if(confirm("로그아웃 하시겠습니까?")){
					btnLogout.setAttribute("href","/admin/emp/logout");
					///member/logout
				}
			})
		}
		
		window.addEventListener("resize", function(){
			var adminHeader = document.getElementById("admin-header");
			var blackScreen = document.getElementById("black-screen");
			var windowWidth = window.outerWidth;
			
			blackScreen.style.left = "100%";
			
			if(windowWidth >= 1150){
				adminHeader.style.left = "0%";
			}else{
				adminHeader.style.left = "-100%";
			}
		});
		
		//관리자 로그인이 안되어 있는 경우 로그인 창으로 이동
		var loginEmp = '<%=session.getAttribute("loginEmp")%>';
		
		if(loginEmp=="null"){
			alert("관리자 로그인 정보가 존재하지 않습니다.");
			location.href="/admin/emp/login";
		}
		
	});
	
	//모바일 메뉴 닫기
	function mmenuClose(){
		var blackScreen = document.getElementById("black-screen");
		var adminMHeader = document.getElementById("admin-header");
		
		blackScreen.style.left = "100%";
		adminMHeader.style.left = "-100%";
	}
	function mmenuOpen(){
		var blackScreen = document.getElementById("black-screen");
		var adminMHeader = document.getElementById("admin-header");
		
		blackScreen.style.left = "0%";
		adminMHeader.style.left = "0%";
	}
</script>
</head>
<div id="black-screen" onclick="mmenuClose()"></div>
<ul id="admin-menu-mobile" class="fixed-header">
	<li><h1 id="m-top-logo"><a href="/admin/">Sera Admin</a></h1></li>
	<li><p id="burger-line" onclick="mmenuOpen()"><span></span><span></span><span></span></p></li>
</ul>
<div id="admin-header">
	<aside>
		<p class="mmenu-close-btn" onclick="mmenuClose()"><i class="bi bi-x-lg"></i></p>
		<h1 id="admin-top-logo"><a href="/admin/">Sera</a></h1>
		<ul class="admin-main-menu acordian-menu-container">
			<li><p class="acordian-btn"><i class="bi bi-house-door-fill"></i>쇼핑몰 설정</p>
				<ul class="admin-sub-menu acordian-menu">
					<li><a href="/admin/emp/empList">운영자목록</a></li>
					<c:if test="${loginEmp.level == 9}"><li><a href="/admin/emp/join">운영자등록</a></li></c:if>
				</ul>
			</li>
			<li><p class="acordian-btn"><i class="bi bi-box-seam-fill"></i>상품관리</p>
				<ul class="admin-sub-menu acordian-menu">
					<li><a href="/admin/goods/categoryList">카테고리 관리</a></li>
					<li><a href="/admin/goods/">상품목록</a></li>
					<li><a href="/admin/goods/?saleActive=goods_delete">삭제상품목록</a></li>
					<li><a href="/admin/goods/goodsRegist">상품등록</a></li>
				</ul>
			</li>
			<li><p class="acordian-btn"><i class="bi bi-cart-fill"></i>주문관리</p>
				<ul class="admin-sub-menu acordian-menu">
					<li><a href="/admin/order/">주문목록</a></li>
				</ul>
			</li>
			<li><p class="acordian-btn"><i class="bi bi-people-fill"></i>회원관리</p>
				<ul class="admin-sub-menu acordian-menu">
					<li><a href="/admin/member/memberList">회원목록</a></li>
					<li><a href="/admin/member/memberList?black_list=yes">블랙리스트관리</a></li>
					<li><a href="/admin/member/memberList?active=no">휴면회원목록</a></li>
				</ul>
			</li>
		</ul>
		
		<ul class="emp-menu">
			<li><a href="#"  id="btn-logout">로그아웃</a></li>
			<li><a href="#">${loginEmp.emp_name}님</a></li>
			<li><a href="/">고객 페이지로</a></li>
		</ul>
	</aside>
</div>
