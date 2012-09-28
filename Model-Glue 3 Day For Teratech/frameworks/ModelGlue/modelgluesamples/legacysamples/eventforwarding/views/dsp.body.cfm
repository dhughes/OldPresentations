<p>This sample demonstrates forwarding events.  Using arguments.event.forward() inside of a controller, you can dynamically relocate the request to another event-handler.  This restarts the request cycle, so it's just like browsing to a new URL, except that all state values are maintained across the redirect.</p>

<cfform action="#viewstate.getValue("myself")#forwardRequest">
	Go to
	<select name="forwardTo">
		<option value="redPage">a page a page with red text</option>
		<option value="bluePage">a page a page with blue text</option>
	</select>
	and append the url variable "appendMe" with a value of
	<input type="text" name="appendMe" value="some appended text" />
	<input type="submit" value="Go">
</cfform>

