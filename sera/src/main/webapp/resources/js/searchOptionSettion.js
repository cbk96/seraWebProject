$(function(){
   			
   	//상세 검색 옵션 표시/비표시 전환
	var btnExpandRemem = $("#btn-expand-remember").val();
	if(btnExpandRemem == "expand-active"){
		$("#btn-expand").addClass("btn-expand-active").html("<i class='bi bi-caret-up-fill'></i>");
		$(".search-more-optioin").css("display","flex");
	}else{
		$("#btn-expand").removeClass("btn-expand-active").html("<i class='bi bi-caret-down'></i>");
		$(".search-more-optioin").css("display","none");
	}
			
	$("#btn-expand").click(function(){
		$(".search-more-optioin").slideToggle(300).css("display","flex");
		
		if($(this).attr("class").indexOf("btn-expand-active")!=-1){
			$("#btn-expand").removeClass("btn-expand-active").html("<i class='bi bi-caret-down'></i>");
			$("#btn-expand-remember").val("expand-not-active");
		}else{
			$("#btn-expand").addClass("btn-expand-active").html("<i class='bi bi-caret-up-fill'></i>");
			$("#btn-expand-remember").val("expand-active");
		}
	});
	
	//범위 설정 
	function rangeSetting(valueA, valueB, minmax){
		valueB.attr(minmax,valueA.val());
	}
	
	//날짜 입력폼 기본값 설정
	var offset = new Date().getTimezoneOffset()*60*1000;
	var thirtyDay = 60*24*60*60*1000; //30일 * 24시간 * 60분 * 60초 * 1000밀리초
	var today = new Date(Date.now() - offset).toISOString().slice(0, 10);
	var seven = new Date(Date.now() - offset - thirtyDay).toISOString().slice(0, 10);
	$(".date-range>input[type='date']:first-of-type").attr("max",today).val(seven);
	$(".date-range>input[type='date']:last-of-type").attr("min",today).val(today);
	
	//일자 검색 범위 설정(시작일자 변경시)
	$(".date-range>input[type='date']:first-of-type").change(function(){
		var beginDate = $(this);
		var endDate = $(this).siblings("input[type='date']");
		
		rangeSetting(beginDate, endDate, "min");
	});
	
	//일자 검색 범위 설정(종료일자 변경시)
	$(".date-range>input[type='date']:last-of-type").change(function(){
		var endDate = $(this);
		var beignDate = $(this).siblings("input[type='date']");
		
		rangeSetting(endDate, beignDate, "max");
	});
	
	
	//입력 가격 범위 설정(시작값 변경시)
	$(".price-range>input[type='number']:first-of-type").change(function(){
		var beginPrice = $(this);
		var endPrice = $(this).siblings("input[type='number']");

		rangeSetting(beginPrice, endPrice, "min");
		
	});
	//입력 가격 범위 설정(끝값 변경시)
	$(".price-range>input[type='number']:last-of-type").change(function(){
		var endPrice = $(this);
		var beginPrice = $(this).siblings("input[type='number']");
		
		rangeSetting(endPrice, beginPrice, "max");
	});
	
	
	//가격 입력 범위 제한
	$(".price-range>input[type='number']").change(function(){
		var inputValue = $(this);
		var siblingValue =  $(this).siblings("input");
		
		//최소값보다 작은 값을 입력하는 경우
		if(parseInt(inputValue.val()) < parseInt(inputValue.attr("min"))){
			inputValue.val(inputValue.attr("min"));
			rangeSetting(inputValue, siblingValue, "max");
		}
		//최대값보다 큰 값을 입력하는 경우
		if(parseInt(inputValue.val()) > parseInt(inputValue.attr("max"))){
			inputValue.val(inputValue.attr("max"));
			rangeSetting(inputValue, siblingValue, "min");
		}
	});
});