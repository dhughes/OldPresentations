<cfmodule template="controller.cfm" do="getFortune" result="fortune" />

<h1>Your Fortune...</h1>

<p>
	<pre><cfoutput>#fortune.fortune#</cfoutput></pre>
</p>

<p><a href="index.cfm">Start over</a></p>
