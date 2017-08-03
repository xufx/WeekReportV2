<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>CKEditor Classic Editing Sample</title> 
 
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js" type="text/javascript"></script> 
    
    <script src="https://cdn.ckeditor.com/4.6.0-441b33b/full-all/ckeditor/ckeditor.js"></script>     
     <script src="ckeditor/plugin-ajax.js"></script>

	<style type="text/css">
	/* Minimal styling to center the editor in this sample */
	body {
		padding: 30px;
		display: flex;
		align-items: center;
		text-align: center;
	}
	p{
	text-align:right; 
	}
	
	.container {
		margin: 0 auto;
	}
	</style>
	
<script>	
/*
* 1. 每次进入页面前    都从后台取最新的数据到前台   【在index方法里】
* 2. 缓存数据判断   缓存为空 则将后台最新数据赋值    2 本地缓存  localStorage 自动保存
* 3. 缓存数据赋值给 texture值
* 4. 遇到 texture值变化，则自动保存
*/

$(document).ready(function () {  
	var editor=initeditor();
	var  initcontent= window.sessionStorage.getItem("comment_top");     
	// 初始化页面赋值
    initdata(editor,initcontent);
	// 触发自动保存  自动保存功能
	editor.on('change', function(evt) {  
		window.sessionStorage.setItem("comment_top", evt.editor.getData()); 
	});
});
 
function initeditor(){
	  var editor=  CKEDITOR.replace( 'editor1' , {
      	toolbar: [
    				{ name: 'clipboard', items: [ 'Undo', 'Redo' ] },
    				{ name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
    				{ name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting' ] },
    				{ name: 'colors', items: [ 'TextColor', 'BGColor' ] },
    				{ name: 'align', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
    				{ name: 'links', items: [ 'Link', 'Unlink' ] },
    				{ name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
    				{ name: 'insert', items: [ 'Image', 'Table' ] },
    				{ name: 'tools', items: [ 'Maximize' ] },
    				{ name: 'editing', items: [ 'Scayt' ] }
    			],
    			
        height: 800 ,  //外面长方形 高多少
    	contentsCss: [ 'https://cdn.ckeditor.com/4.6.0-441b33b/full-all/ckeditor/contents.css', 'mystyles.css' ] ,   //有无里面的方格      	
    	allowedContent : true ,
    	disallowedContent: 'img{width,height,float}'   ,              	
    	extraAllowedContent: 'img[width,height,align]' ,              	
    	extraPlugins: 'tableresize,uploadimage,uploadfile' , 
  	    bodyClass: 'document-editor' ,               
    	format_tags: 'p;h1;h2;h3;pre' ,               
    	removeDialogTabs: 'image:advanced;link:advanced'  
      });
	  return editor;
};
      
function initdata(editor,initcontent){  
		//显示进度条代码结束
	var aj =$.ajax({
			type : "POST",
			url : "initdata",
			async: false,
			dataType : "json",		 
			success : function(data) {
				if (data == null) {
					alert("没查到最新的信息");
				} else if (!initcontent && typeof initcontent != "undefined" && initcontent != 0) {
					editor.setData(data.scontent); 
				}else{
					editor.setData(initcontent); 
				}
			}
	});
};
//手动保存页面 
 function ManualSave(){    
			var aj = $.ajax( {    
			    url:'save',   // 跳转到 action   		      
			    type:'POST',       
			    dataType:'json',    
			   contentType: 'application/json;chartset=UTF-8',			 
			   data:JSON.stringify(window.sessionStorage.getItem("comment_top")), //  传批量的参数 list		    
			    success:function(data) {    
			        if(data.state){       
			            alert("保存成功！");    
			            window.sessionStorage.removeItem("comment_top");
			            window.location.reload();   
			        }else{    
			        	alert("保存失败！");    
			        }    
			     },    
			     error : function() {      
			          alert("网络异常！");    
			     }    
	});  
};    
		
</script> 
     
</head>
<body>
    <%-- 1 添加编辑页面 --%>
    <div class="container">   
          <form method="post">
            <h2><label for="editor1">周报编辑器</label></h2>  
            <p><a href="javascript:void(0);" onclick="ManualSave();" >保存</a></p>             
<!--         <a href="javascript:void(0);" onclick="Export();" >导出</a></p> -->
            <textarea name="editor1" id="editor1"> </textarea>      
          </form> 
    </div>
</body>
</html>