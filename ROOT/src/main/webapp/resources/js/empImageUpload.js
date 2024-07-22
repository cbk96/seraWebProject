function imageUpload(e, itmeUrl, itemName){
   		const proFileImage = e.currentTarget.files;
        
        var formData = new FormData();
        formData.append("uploadImage", proFileImage[0]);
        
        $.ajax({
        	url:"/admin/emp/imageUpload?itmeUrl="+itmeUrl+"&itemName="+itemName,
        	processData : false,
        	contentType : false,
        	data:formData,
        	type:"POST",
        	dataType:"json",
        	success:function(result){
	        		var upload_image_hidden = document.getElementById("upload-image-hidden");
	        		var photoPreview = document.getElementsByName("photo-preview")[0];
	        			
	        		upload_image_hidden.value=result["upImgUrl"];
					photoPreview.setAttribute("src",result["upImgUrl"]);
				}
        });
   	}