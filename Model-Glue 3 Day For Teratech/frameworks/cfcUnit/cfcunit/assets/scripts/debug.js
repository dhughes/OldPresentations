/*
   Copyright (c) 2006, Paul Kenney
   All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
   
//==================================================================
function debug_toggleContents(source)
{
	var switchToState = debug_toggleSource(source);
	var container = source.parentNode;
	var i = 0;
	
	for(i=1; i<container.childNodes.length; i++)
	{
		target = container.childNodes[i];
		if(target.style)
			debug_toggleTarget(target, switchToState);
	}
}

//==================================================================
function debug_toggleSource(source)
{
	if(source.style.fontStyle == 'italic')
	{
		source.style.fontStyle = 'normal';
		source.title = 'click to collapse';
		return 'open';
	}
	else
	{
		source.style.fontStyle = 'italic';
		source.title = 'click to expand';
		return 'closed';
	}
}

//==================================================================
function debug_toggleTarget (target, switchToState)
{
	if(switchToState == 'open')
		target.style.display = '';
	else
		target.style.display = 'none';
}