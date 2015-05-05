<html>
<head>
</head>
<body>
	<script>
		if(${signFlag.signFlag} == 0) {
			jQuery('<div/>', {
				id: 'indicator',
				class: 'circle'
			}).appendTo('#tmp');
		}
		else {
			jQuery('<div/>', {
				id: 'indicator',
				class: 'circle',
			}).css (
				'background-color','red'
			).appendTo('#tmp');			
		}
	</script>
</body>
</html>
