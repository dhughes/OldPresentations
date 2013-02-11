<script src="/js/jquery.js"></script>

<script>
	$(document).ready(function(){
		$("#evenclick").click(function(){
			$(".even").attr("checked", true);
		})
		
		$("#oddclick").click(function(){
			$(".odd").attr("checked", true);
		})
		
		$("#toggleeven").click(function(){
			$(".even").attr("checked", $(this).is(":checked"));
		})
		
		$("#toggleodd").click(function(){
			$(".odd").attr("checked", $(this).is(":checked"));
		})
	});
</script>
<div>
	<button id="evenclick">Select Even Checkboxen</button>
	<pre>$(".even").attr("checked", true);</pre>
</div>
<div>
	<button id="oddclick">Select Odd Checkboxen</button>
	<pre>$(".odd").attr("checked", true);</pre>
</div>
<div>
	<label for="toggle">Toggle Even Checkboxen <input id="toggleeven" type="checkbox" /></label>
	<pre>$(".even").attr("checked", $(this).is(":checked"));</pre>
</div>
<div>
	<label for="toggle">Toggle Odd Checkboxen <input id="toggleodd" type="checkbox" /></label>
	<pre>$(".odd").attr("checked", $(this).is(":checked"));</pre>
</div>


<cfoutput>
	<cfloop from="0" to="19" index="i">
		<label for="box#i#" style="width:120px; float:left;">
			<input type="checkbox" name="box#i#" class="all <cfif i mod 2 NEQ 0>even<cfelse>odd</cfif>" id="box#i#" /> Checkbox #i+1#
		</label>
	</cfloop>
</cfoutput>
