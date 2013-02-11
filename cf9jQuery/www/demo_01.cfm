<script src="/js/jquery.js"></script>
<cfoutput>
	<cfloop from="0" to="19" index="i">
		<label for="box#i#" style="width:120px; float:left;">
			<input type="checkbox" name="box#i#" class="all <cfif i mod 2 NEQ 0>even<cfelse>odd</cfif>" id="box#i#" /> Checkbox #i+1#
		</label>
	</cfloop>
</cfoutput>

<script>
	$(".even").attr("checked", true);
</script>