<g:if test = "${sign == 1}">
 	// ready to repair
	render "<script>alert('sign = 1')</script>"
	//render "<script>document.getElementById('indicator').style.backgroundColor = 'red'</script>"
</g:if>
<g:else>
	render "<script>alert('sign = 0')</script>"
	//render "<script>document.getElementById('indicator').style.backgroundColor = '#65D97D'</script>"
</g:else>