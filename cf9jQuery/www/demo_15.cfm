
<script src="/js/jquery.js"></script>
<script src="/js/jquery.random.js"></script>
<script>
	var myNum = 0;
	$(document).ready(function(){
		$(".link").click(function(){
			showMessage('mb' + $(this).attr("ref"));
		})
		
		
	})
	showResult1 = function(btn){
		console.log(btn);
	}

	showResult2 = function(btn, msg){
		console.log(btn);
		if (btn != 'cancel' && msg != '') alert("Your favorite golf course is " + msg);
	}
	
	showMessage = function(mb){
		ColdFusion.MessageBox.show(mb);
		$(".ext-mb-question").removeClass("myIcon"+myNum);
		myNum = $.randomBetween(1,3);
		$(".ext-mb-question").addClass("myIcon"+myNum);
	}
</script>

<style>
	.x-window-dlg .myIcon1 {
    background-image:url(files/icon_032.png); 
}
.x-window-dlg .myIcon2 {
    background-image:url(files/skull_32.png); 
}
.x-window-dlg .myIcon3 {
    background-image:url(files/beer_32.png); 
}
</style>

<div style="width:400px; margin:15 auto">
	<a href="javascript:;" class="link" ref="1">Click me</a> to see an alert.</br>
	<a href="javascript:;" class="link" ref="2">Click me</a> to see an confirmation.</br>
	<a href="javascript:;" class="link" ref="3">Click me</a> to open a prompt.
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