<script src="/js/jquery.js"></script>

<script>
	var play = false;
	var mute = false;
	$(document).ready(function(){
		$("#play").click(function(){
			if(!play){
				$("#play").attr("src", "/files/stop.png");
				$("#play").attr("title", "Stop");
				ColdFusion.Mediaplayer.startPlay("knockDown");
				play = true;
			}
			else{
				$("#play").attr("src", "/files/play.png");
				$("#play").attr("title", "Play");
				ColdFusion.Mediaplayer.stopPlay("knockDown");
				play = false;
			}
		})

		
		$("#mute").click(function(){
			if(!mute) {
				ColdFusion.Mediaplayer.setMute("knockDown", true);
				mute = true;
			}
			else {
				ColdFusion.Mediaplayer.setMute("knockDown", false);
				mute = false;
			}
		})
		
		
	})
</script>

<style>
	a img{border:none;}
</style>

<cfmediaplayer 
	source="files/MAX09.flv" 
	align="center" 
	name="knockDown" 
	hidetitle="true"
	controlbar="false" />
	<div style="text-align:center">
		<a href="javascript:;"><img id="play" src="files/play.png" title="Play" /></a>
	    <a href="javascript:;"><img id="mute" src="files/mute.png" title="Mute" /></a>
	</div>
