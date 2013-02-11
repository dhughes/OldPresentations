&lt;script type="text/javascript" src="http://hackproof.preso/js/xss_3.js"&gt;&lt;/script&gt;
<div id="header">
	<h1>ColdFusion is cool!!!!!</h1>
</div>
<form method="post">
	<label for="myText">Enter some text</label>
	<textarea name="myText" id="myText" style="width:400px;height:300px"></textarea>
	<input type="submit" value="Go!" />
</form>

<cfif structKeyExists(form, "myText")>
	<cfoutput>#form.myText#</cfoutput>
	<cfoutput>#htmlEditFormat(form.myText)#</cfoutput>
</cfif>


