window.onload = function(){
   		
   		var inputId = document.getElementsByName("emp_id")[0];
   		var inputNickName = document.getElementsByName("emp_nick_name")[0];
   		var btnJoin = document.getElementById("btn-join");
   		var idCanUse = false;
   		var nickCanUse = false;
   		
   		inputId.addEventListener("change",function(e){
   			
   			btnJoin.setAttribute("disabled","disabled");
   			
   			inputId = document.getElementsByName("emp_id")[0].value;
   			var idChkCMsg = document.getElementById("idChkCMsg");
   			var inputIdObject = {inputId : inputId};
   			
   			$.ajax({
   				url : "/admin/emp/idChk",
   				type : "post",
   				data : inputIdObject,
   				success:function(data){
   					if(data==="empty"){
   						idChkCMsg.style.display = "block";
   						idChkCMsg.style.color = "#ff3131";
   						idChkCMsg.innerText = "아이디가 입력되지 않았습니다.";
   						idCanUse = false;
   						//btnJoin.setAttribute("disabled","disabled");
   					}else if(data==="canUse"){
   						idChkCMsg.style.display = "block";
   						idChkCMsg.style.color = "#2736ff";
   						idChkCMsg.innerText = "사용 가능한 아이디입니다.";
   						idCanUse = true;
   						//btnJoin.removeAttribute("disabled");
   					}else{
   						idChkCMsg.style.display = "block";
   						idChkCMsg.style.color = "#ff3131";
   						idChkCMsg.innerText = "사용할 수 없는 아이디입니다.";
   						idCanUse = false;
   						//btnJoin.setAttribute("disabled","disabled");
   					}
   					
   					if(idCanUse&&nickCanUse){
   		   				btnJoin.removeAttribute("disabled");
   		   			}else{
   		   				btnJoin.setAttribute("disabled","disabled");
   		   			}
   				}
   			});
   		});
   		
   		
   		inputNickName.addEventListener("change",function(e){
   			
   			btnJoin.setAttribute("disabled","disabled");
   			
   			inputNickName = document.getElementsByName("emp_nick_name")[0].value;
   			var nickChkCMsg = document.getElementById("nickChkCMsg");
   			var inputNickObject = {inputNickName : inputNickName};
   			
   			$.ajax({
   				url : "/admin/emp/nickChk",
   				type : "post",
   				data : inputNickObject,
   				success:function(data){
   					if(data==="empty"){
   						nickChkCMsg.style.display = "block";
   						nickChkCMsg.style.color = "#ff3131";
   						nickChkCMsg.innerText = "닉네임이 입력되지 않았습니다.";
   						nickCanUse = false;
   						//btnJoin.setAttribute("disabled","disabled");
   					}else if(data==="canUse"){
   						nickChkCMsg.style.display = "block";
   						nickChkCMsg.style.color = "#2736ff";
   						nickChkCMsg.innerText = "사용 가능한 닉네임입니다.";
   						nickCanUse = true;
   						//btnJoin.removeAttribute("disabled");
   					}else{
   						nickChkCMsg.style.display = "block";
   						nickChkCMsg.style.color = "#ff3131";
   						nickChkCMsg.innerText = "사용할 수 없는 닉네임입니다.";
   						nickCanUse = false;
   						//btnJoin.setAttribute("disabled","disabled");
   					}
   					
   					if(idCanUse&&nickCanUse){
   		   				btnJoin.removeAttribute("disabled");
   		   			}else{
   		   				btnJoin.setAttribute("disabled","disabled");
   		   			}
   				}
   			});
   		});
   		
   	}