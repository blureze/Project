<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->	
		
	    <meta name="layout" content="main"/>		
	    <title>Simple Chat</title>
	    <g:javascript library="scriptaculous"/>

		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="icon" href="../../favicon.ico">

		<!-- Bootstrap core CSS -->
		<link href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
		<link href="http://getbootstrap.com/assets/css/docs.min.css" rel="stylesheet">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-switch.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap_main.css')}" type="text/css">

		<!-- Custom styles for this template -->
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'view.css')}" type="text/css">

	</head>

	<body>
		<div class="container" style="text-align: center; margin: 0 auto">
			<div class="system">
				<!--Repair Part-->
				<div class = "repairBox" id = "repairBox">	
					<div class = "toolBox">
						<div class = "tools">
							<div class="btn-group" role="group" aria-label="...">
							  <button type="button" class="btn btn-default" id = "circle">
								<div id = "circleTool"></div>
							  </button>
							  <button type="button" class="btn btn-default" id = "rec">
								<div id = "recTool"></div>
							  </button>
							  <button type="button" class="btn btn-default" id = "line">
								<div id = "lineTool">
									<g:img dir="images" file="line.png" width="100%"/>
								</div>
							  </button>
							  <button type="button" class="btn btn-default" id = "text">
								<div id = "textTool">T</div>
							  </button>										  
							</div>
						</div><!--tools-->
					</div><!--toolBox-->
					<div class = "showPics">
						<canvas id="myCanvas" class = "myCanvas">
						<p class="lead">Repair
						</canvas>						
					</div>
				</div>				
				
				<!--Chat Part-->
				<div class="page" id = "page">
					<div class = "mainPage">
						<div class = "picHistory">
							<p class="lead">Pic
						</div>					
						
						<div class = "message">
							<div style="float:left">
								<div id="temp"></div>
								<div id="chatMessages"></div>						
							</div>
							<!--<div class="circle" id="indicator"></div>-->
							<div id = "tmp"></div>
						</div>
					</div> <!--mainPage-->
					
					<div class="row" id = "controlBox">
					  <div class="col-md-6">
						<input type="checkbox" id = "repairCheckbox" unchecked /> 修復
					  </div>
					  <div class="col-md-6">
						<button type="button" class="btn btn-danger" id = "understand_btn" onclick="signFlag()">我不懂</button>
					  </div>
					</div>	
				
					<div class = "center-block">					
						<textarea class="form-control" rows="3" id="messageBox" name="message" onkeypress="messageKeyPress(this,event);"></textarea>
					</div>
				</div><!--page-->
			</div><!--system-->
		</div><!-- /.container -->

		<!-- function
		================================================== -->	
		<script>
			var flag = 0;
			var canvas = document.getElementById("myCanvas"); // 取得物件
			var ctx = canvas.getContext("2d"); // 取得繪圖環境
			var rect = canvas.getBoundingClientRect();
			var drawing = false, oriX, oriY, mx, my, drawMode = '';			
			
			$(document).ready(function() {
				$('#repairCheckbox').on('switchChange.bootstrapSwitch', function(event, checked) {
				
				/* page 從 width: 80%; margin: 0 auto
				* 變成 width: 40%; float: right; margin-right: 5%;
				*
				* repairBox的 display: show;
				*/			
				
				if(checked){
					$("#repairBox").show();	// show repairBox
					$("#page").addClass('repairStart');
					
				} else {
					$("#repairBox").hide();
					$("#page").removeClass('repairStart');
				}
				});			
			});			
			
			/*Canvas*/
			document.getElementById('circle').onclick = function(){drawMode='circle'};		
			document.getElementById('rec').onclick = function(){drawMode='rec'};		
			document.getElementById('line').onclick = function(){drawMode='line'};		
			document.getElementById('text').onclick = function(){drawMode='text'};
			
			function drawCircle(x, y, r){
				ctx.beginPath();
				ctx.strokeStyle = "black";
				ctx.arc(x, y, r, 0, Math.PI*2, true);
				ctx.stroke();
			}
					
			function dist(x1,y1,x2,y2) {
				return Math.sqrt(Math.pow(x1-x2,2) + Math.pow(y1-y2,2));
			}
			
			function drawRec(x, y, w, h) {
				ctx.beginPath();
				ctx.strokeStyle = "black";
				ctx.rect(x, y, w, h);
				ctx.stroke();		
			}
			
			function drawLine(sx, sy, ex, ey) {
				ctx.beginPath();
				ctx.moveTo(sx, sy);
				ctx.lineTo(ex, ey);
				ctx.stroke();
			}
			
			canvas.onmousedown = function(ev){	
				mx = event.clientX - rect.left;
				my = event.clientY - rect.top;

				oldImg = ctx.getImageData(0, 0, canvas.width, canvas.height);
				oriX = mx;
				oriY = my;			
				
				drawing = true;
			}
					 
			canvas.onmousemove = function(ev){
				mx = event.clientX - rect.left;
				my = event.clientY - rect.top;	
				
				if(drawing) {
					ctx.clearRect(0,0,canvas.width,canvas.height);
					ctx.putImageData(oldImg,0,0);
					
					if(drawMode == "circle"){
						// oriX and oriY are the coordinates of the center						
						drawCircle(oriX, oriY, dist(oriX,oriY,mx,my));
					}
					else if(drawMode == "rec") {
						drawRec(oriX, oriY, mx-oriX, my-oriY);
					}
					else if(drawMode == "line") {
						drawLine(oriX, oriY, mx, my);
					}
					else if(drawMode == "text") {
					alert("rec");
					}
				}
			}
					 
			canvas.onmouseup = function(){			
				mx = event.clientX - rect.left;
				my = event.clientY - rect.top;
						
				if(drawMode == "circle")
					drawCircle(oriX, oriY, dist(oriX,oriY,mx,my));				
				else if(drawMode == "rec")
					drawRec(oriX, oriY, mx-oriX, my-oriY);
				else if(drawMode == "line")
					drawLine(oriX, oriY, mx, my);
				else if(drawMode == "text")
				alert("rec");
				
				drawing = false;			
			}
			
			function signFlag() {				
				if(flag == 0) {		// ready to repair
					//document.getElementById("indicator").style.backgroundColor = "red";
					document.getElementById("understand_btn").innerHTML = "我懂了";
					document.getElementById("understand_btn").className = "btn btn-success";
					flag = 1;
				}
				else {		// finish repair
					//document.getElementById("indicator").style.backgroundColor = "#65D97D";
					document.getElementById("understand_btn").innerHTML = "我不懂";
					document.getElementById("understand_btn").className = "btn btn-danger";
					flag = 0;
				}	
				<g:remoteFunction action="signFlag" params="\'flag=\'+flag" update="tmp"/>
			}
			
			function changeSign() {
				<g:remoteFunction action="changeSign" update="tmp"/>
			}
			
		    function messageKeyPress(field,event) {
		        var theCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		        var message = $('#messageBox').val();
		        if (theCode == 13){
		            <g:remoteFunction action="submitMessage" params="\'message=\'+message" update="temp"/>
		            $('#messageBox').val('');
		            return false;
		        } else {
		            return true;
		        }
		    }
			
		    function retrieveLatestMessages() {
		        <g:remoteFunction action="retrieveLatestMessages" update="chatMessages"/>
		    }
			
		    function pollMessages() {
		        retrieveLatestMessages();
		        setTimeout('pollMessages()', 5000);
		    }
			
			function updateSign() {
				changeSign();
				setTimeout('updateSign()', 2000);
			}
		    pollMessages();
			updateSign();
		</script>
		
		<!-- Bootstrap core JavaScript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<g:javascript src="jquery.min.js"/>
		<g:javascript src="bootstrap.min.js"/>
		<g:javascript src="highlight.js"/>
		<g:javascript src="bootstrap-switch.js"/>
		<g:javascript src="main.js"/>
	</body>
</html>