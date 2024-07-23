window.onload = function(){
   		
   		var inputNickName = document.getElementsByName("nick_name")[0];
   		var btnJoin = document.getElementById("btn-join");
   		
   		inputNickName.addEventListener("change",function(e){
   			
   			
   			inputNickName = document.getElementsByName("nick_name")[0].value;
   			var nickChkCMsg = document.getElementById("nickChkCMsg");
   			var inputNickObject = {inputNickName : inputNickName};
   			
   			$.ajax({
   				url : "/member/modifyNickChk",
   				type : "post",
   				data : inputNickObject,
   				success:function(data){
   					if(data==="empty"){
   						nickChkCMsg.style.display = "block";
   						nickChkCMsg.style.color = "#ff3131";
   						nickChkCMsg.innerText = "닉네임이 입력되지 않았습니다.";
   						nickCanUse = false;
   						btnJoin.setAttribute("disabled","disabled");
   					}else if(data==="canUse"){
   						nickChkCMsg.style.display = "block";
   						nickChkCMsg.style.color = "#2736ff";
   						nickChkCMsg.innerText = "사용 가능한 닉네임입니다.";
   						nickCanUse = true;
   						btnJoin.removeAttribute("disabled");
   					}else{
   						nickChkCMsg.style.display = "block";
   						nickChkCMsg.style.color = "#ff3131";
   						nickChkCMsg.innerText = "사용할 수 없는 닉네임입니다.";
   						nickCanUse = false;
   						btnJoin.setAttribute("disabled","disabled");
   					}
   				}
   			});
   		});
   		
   	}