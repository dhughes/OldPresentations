<div style="color:#F00">WARNING: This example application requires CFMX7 Enterprise or Developer Edition, and for Sean Corfield's concurrency library to be installed and tested independently of the framework!</div><br />

<form>
Enter a number to count to:
<input type="text" name="number" id="number">
<input type="button" value="Go" onClick="var win=window.open('index.cfm?event=startCount&number=' + document.getElementById('number').value, 'count', 'height=600,width=800,status=yes,toolbar=no,menubar=no,location=yes,resizable=yes,scrollbars=yes');win.focus()">
</form>
