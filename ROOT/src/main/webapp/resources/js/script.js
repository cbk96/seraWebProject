$(function(){

	
	var header = document.querySelector(".fixed-header");
   
    window.addEventListener("scroll", function(e){
    	if(window.scrollY >=50){
    		header.classList.add("headerActive");
    	}else{
    		header.classList.remove("headerActive");
    	}
    });
    
    
    
});