
<script>
	showResult1 = function(btn){
		console.log(btn);
	}

	showResult2 = function(btn, msg){
		console.log(btn);
		if (btn != 'cancel' && msg != '') alert("Your favorite golf course is " + msg);
	}
	
	showMessage = function(mb){
		ColdFusion.MessageBox.show(mb);
	}
</script>
<div style="width:400px; margin:15 auto">
	<a href="javascript: showMessage('mb1');">Click me</a> to see an alert.</br>
	<a href="javascript: showMessage('mb2');">Click me</a> to see an confirmation.</br>
	<a href="javascript: showMessage('mb3');">Click me</a> to open a prompt.
</div>
<cfmessagebox name="mb1" type="alert"  
        message="You have not talked about golf in the last 2 minutes!"  
        callbackhandler="showResult1"
		icon="warning" /> 
		   
<cfmessagebox name="mb2" type="confirm"  
        message="Do you like golf?"  
        labelNO="No, I hate the silly game" 
		labelYES="Maybe just a little..."  
        callbackhandler="showResult1"
		icon="question"
		buttonType="yesnocancel" />
		
<cfmessagebox name="mb3" type="prompt"  
        message="What is your favorite golf course?"  
        labelOK="Continue" 
		labelCANCEL="Get me out of here..."  
        callbackhandler="showResult2" 
		multiline="true"/>