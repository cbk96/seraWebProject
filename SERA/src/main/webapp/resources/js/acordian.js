$(function(){

	var acordianMenuCon  = document.querySelector(".acordian-menu-container");
    var acordianMenu =  document.querySelectorAll(".acordian-menu");
    
    acordianMenuCon.addEventListener("click", function(e){
    	clickArcodian(e);
    });
    
    function clickArcodian(e){
    	if(e.target.className=="acordian-btn" ){
    		var acordianMenuActive = e.target.nextElementSibling;
    		acordianMenuActive.classList.add("acordian-menu-active");
    		
    		var acordianMenuCnt = acordianMenuActive.querySelectorAll("li").length;
        	var acordianMenuHeight = acordianMenuActive.querySelectorAll("li")[0].offsetHeight;
        	
    		
    		for(var i=0; i < acordianMenu.length; i++){
            	if(acordianMenu[i].className.indexOf("acordian-menu-active")==-1){
            		acordianMenu[i].style.height="0px";
                	acordianMenu[i].style.padding="0px";
            	}else{
            		acordianMenuActive.classList.remove("acordian-menu-active");
            	}
            }
    		
    		if(acordianMenuActive.offsetHeight>0){
    			acordianMenuActive.style.height="0px";
    			acordianMenuActive.style.padding="0px";
    		}else{
    			acordianMenuActive.style.height=(acordianMenuCnt*acordianMenuHeight+20)+"px";
    			acordianMenuActive.style.padding="10px 0";
    		}
    	}
    }
    
});