<!---
LICENSE INFORMATION:

Copyright 2007, Joe Rinehart
 
Licensed under the Apache License, Version 2.0 (the "License"); you may not 
use this file except in compliance with the License. 

You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 
	
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.

VERSION INFORMATION:

This file is part of Model-Glue Model-Glue: ColdFusion (2.0.304).

The version number in parenthesis is in the format versionNumber.subversion.revisionNumber.
--->


//	WebHelp 5.10.001
// const strings
var gaProj = new Array();
var gsRoot = "";

function setRoot(sRoot)
{
	gsRoot = sRoot
}

function aPE(sProjPath, sRootPath)
{
	gaProj[gaProj.length] = new tocProjEntry(sProjPath, sRootPath);
}

function tocProjEntry(sProjPath, sRootPath) 
{
	if(sProjPath.lastIndexOf("/")!=sProjPath.length-1)
		sProjPath+="/";	
	this.sPPath = sProjPath;
	this.sRPath = sRootPath;
}


function window_OnLoad()
{
	if (parent && parent != this && parent.projReady) {
		parent.projReady(gsRoot, gaProj);
	}
}
window.onload = window_OnLoad;