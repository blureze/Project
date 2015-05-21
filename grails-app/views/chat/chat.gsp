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
							  <button type="button" class="btn btn-default" id = "circle" onclick="set('circle')">
								<div id = "circleTool"></div>
							  </button>
							  <button type="button" class="btn btn-default" id = "rec" onclick="set('rect')">
								<div id = "recTool"></div>
							  </button>
							  <button type="button" class="btn btn-default" id = "line"  onclick="set('line')">
								<div id = "lineTool">
									<g:img dir="images" file="line.png" width="100%"/>
								</div>
							  </button>
							  <button type="button" class="btn btn-default" id = "text"  onclick="set('text')">
								<div id = "textTool">T</div>
							  </button>										  
							</div>
						</div><!--tools-->
					</div><!--toolBox-->
					<div class = "showPics">
						<script type="application/processing">
							int sX, sY, eX, eY;    // s: start; e: end
							int width, height;
							ArrayList xPos, yPos;
							ArrayList xOffsetList, yOffsetList;
							ArrayList shape;
							boolean drawing = false;
							boolean locked = false;
							float xOffset = 0.0;
							float yOffset = 0.0;
							String mode;
							int i;

							// Setup the Processing Canvas
							void setup(){
								//size( $("#myCanvas").width(), $("myCanvas").height() );
								size(500,500);
								strokeWeight( 5 );
								stroke(0);  
								//textSize(24);
								smooth();
								
								xPos = new ArrayList();
								yPos = new ArrayList();
								xOffsetList = new ArrayList();
								yOffsetList = new ArrayList();
								shape = new ArrayList(); 
									
								noLoop();								
							}

							// Main draw loop
							void draw(){
								background( 255 );
								// Set stroke-color white								  
								noFill();
								
								for(i = 0; i < xPos.size(); i++) {
									if(shape.get(i) == "circle")
										ellipse(xPos.get(i), yPos.get(i), xOffsetList.get(i), yOffsetList.get(i));
									else if(shape.get(i) == "rect")
										rect(xPos.get(i), yPos.get(i), xOffsetList.get(i), yOffsetList.get(i));
										
								}
							
								// Draw
								if(drawing && mode == "circle") {
									ellipse(sX, sY, xOffset, yOffset);
								}        
								else if(drawing && mode == "rect") {
									rect(sX, sY, xOffset, yOffset);
								}       
								else if(drawing && mode == "line") {
									line(pmouseX, pmouseY, mouseX, mouseY);
								}				
								else if(drawing && mode == "text") {
								  text("word", 15, 30);
								}								
							}

							void mousePressed(){
								if(locked){
									drawing = true;
									loop();
									sX = mouseX;  
									sY = mouseY; 								
								} 							
							} 
							
							// Set circle's next destination
							void mouseDragged(){
								if(locked && drawing){
									xOffset = mouseX- sX;
									yOffset = mouseY- sY;				
								}
							}
						  
							void mouseReleased(){
								if(locked){
									drawing = false;
									xPos.add(sX);
									yPos.add(sY);        
									xOffsetList.add(xOffset);
									yOffsetList.add(yOffset);
									
									xOffset = 0.0;
									yOffset = 0.0;
									if(mode == "circle"){
									  shape.add("circle");
									}
									else if (mode == "rect"){
									  shape.add("rect");
									}
									else if(mode == "line"){
										shape.add("line");
									}
									else if(mode == "text"){
										shape.add("text");
									}									
									noLoop();				
								}
							}
							
							void set(shapeMode) {
								mode = shapeMode;
								locked = true;
							}							
						</script>
						<canvas id = "myCanvas" class = "myCanvas"></canvas>				
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
		    
			function set(shape) {
				var pjs = Processing.getInstanceById("myCanvas");
				var width = document.getElementById('myCanvas').offsetWidth;
				var height = document.getElementById('myCanvas').offsetHeight;
				pjs.set(shape);

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
		<g:javascript src="processing.js"/>
	</body>
</html>