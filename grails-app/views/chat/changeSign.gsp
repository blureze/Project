<html>
<head>
</head>
<body>
	<div class = "circle" id = "indicator"> </div>
	<script>
		if(${flag.signFlag} == 0) {
			document.getElementById("indicator").style.backgroundColor = "#65D97D";
		}
		else {
			document.getElementById("indicator").style.backgroundColor = "red";
		}
	</script>
</body>
</html>
