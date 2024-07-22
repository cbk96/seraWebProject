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
	});
</script>
</head>
<header id="main-header">
	<nav>
		<h1 id="top-logo"><a href="/">Sera</a></h1>
		<a id="burger-line">
			<span></span>
			<span></span>
			<span></span>
		</a>
		
		<ul class="main-menu">
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
			<li><a href="/goods/?main_type=라이프 ">라이프</a>
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
		</ul>
		
		<div class="main-menu-mobile-container">
			<aside>
			<ul class="main-menu-mobile acordian-menu-container">
				<li><p class="acordian-btn">헤어케이</p>
					<ul class="sub-menu acordian-menu">
						<li><a href="#">ALL</a></li>
						<li><a href="#">샴푸</a></li>
						<li><a href="#">트리트먼트</a></li>
						<li><a href="#">세럼</a></li>
					</ul>
				</li>
				<li><p class="acordian-btn">바디/핸드케어</p>
					<ul class="sub-menu acordian-menu">
						<li><a href="#">ALL</a></li>
						<li><a href="#">바디워시</a></li>
						<li><a href="#">핸드케어</a></li>
						<li><a href="#">청결제</a></li>
					</ul>
				</li>
				<li><p class="acordian-btn">스킨/클렌징</p>
					<ul class="sub-menu acordian-menu">
						<li><a href="#">ALL</a></li>
						<li><a href="#">스킨케어</a></li>
						<li><a href="#">선/립케어</a></li>
					</ul>
				</li>
				<li><p class="acordian-btn">라이프</p>
					<ul class="sub-menu acordian-menu">
						<li><a href="#">ALL</a></li>
						<li><a href="#">디퓨저/캔들</a></li>
						<li><a href="#">섬유/구강케어</a></li>
						<li><a href="#">세탁세제</a></li>
					</ul>
				</li>
			</ul>
			</aside>
		</div>
		
		
		
	</nav>
</header>
   	
   	<section class="full-section">
   	
   		<div class="index-container index-item-slide-container">
   			<h2>BEST SELLERS</h2>
	  		<div class="goods-list-container goods-list-padding flexslider flexslider_sub">
	   			<ul class=" slides">
		   			<li>sdfsdfsfsdfsdfs</li>
		   		</ul>
	   		</div>
   		</div>
   		
   		<div class="half-banner">
   			<p><a href="/goods/goodsOne?goods_id=koy3"><img src="/resources/images/half_banner_01.jpg"></a></p>
   			<p><a href="/goods/goodsOne?goods_id=koy1"><img src="/resources/images/half_banner_02.jpg"></a></p>
   		</div>
   		
   		
   	</section>
   	
    <footer>
    	<div class="footer-wrap">
    		<p class="footer-copy">ⓒ design by closet 2024</p>
    		<ul class="sns">
    			<li><a href="#"><i class="bi bi-playstation"></i></a></li>
    			<li><a href="#"><i class="bi bi-nintendo-switch"></i></a></li>
    			<li><a href="#"><i class="bi bi-steam"></i></a></li>
    			<li><a href="#"><i class="bi bi-xbox"></i></a></li>
    		</ul>
    	</div>
    </footer>
</body>
</html>   	