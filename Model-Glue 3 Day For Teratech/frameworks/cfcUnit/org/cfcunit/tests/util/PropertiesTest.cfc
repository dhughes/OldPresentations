<!---
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
--->

<cfcomponent name="PropertiesTest" extends="org.cfcunit.framework.TestCase" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testDefaultConstructor" returntype="void" access="public" output="false">
		<cfset var props = newObject("org.cfcunit.util.Properties").init()>
		<cfset var expectedNames = arrayNew(1)>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames, "There should be zero property names.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testConstructorWithDefaults" returntype="void" access="public" output="false">
		<cfset var defaults = newObject("org.cfcunit.util.Properties").init()>
		<cfset var props = newObject("org.cfcunit.util.Properties").init(defaults)>
		<cfset var expectedNames = listToArray("one", ",")>
		<cfset var actualNames = "">
		
		<cfset defaults.setProperty("one", "1")>
		
		<cfset actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames, "There should be one name called 'one'.")> 
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testGetNonExistentPropertyWithoutDefaults" returntype="void" access="public" output="false">
		<cfset var props = newObject("org.cfcunit.util.Properties").init()>

		<cfset assertEqualsString("", props.getProperty("NotHere"), "Should be empty string.")>
		<cfset assertEqualsString("where", props.getProperty("NotHere", "where"), "Should match specified default.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testGetNonExistentPropertyWithDefaults" returntype="void" access="public" output="false">
		<cfset var defaults = newObject("org.cfcunit.util.Properties").init()>
		<cfset var props = newObject("org.cfcunit.util.Properties").init(defaults)>
		
		<cfset defaults.setProperty("one", "1")>

		<cfset assertEqualsString("1", props.getProperty("one"), "Should be value in default properties.")>
		<cfset assertEqualsString("1", props.getProperty("one", "2"), "Specified default should be overridden by default properties.")>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testLoadEmptyFile" returntype="void" access="public" output="false">
		<cfset var props = newPropertiesForFile("empty.properties")>
		<cfset var expectedNames = arrayNew(1)>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testLoadSingleProperty" returntype="void" access="public" output="false">
		<cfset var props = newPropertiesForFile("single.properties")>
		<cfset var expectedNames = listToArray("a")>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames)>
		<cfset assertEqualsString("1", props.getProperty("a"))>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testLoadMultipleProperties" returntype="void" access="public" output="false">
		<cfset var props = newPropertiesForFile("multiple.properties")>
		<cfset var expectedNames = listToArray("a,b")>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames)>
		<cfset assertEqualsString("1", props.getProperty("a"))>
		<cfset assertEqualsString("2", props.getProperty("b"))>
	</cffunction>
	

	<!------------------------------------------------------------------------------------>
	

	<cffunction name="testLoadDuplicateNames" returntype="void" access="public" output="false">
		<cfset var props = newPropertiesForFile("duplicates.properties")>
		<cfset var expectedNames = listToArray("a")>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames)>
		<cfset assertEqualsString("2", props.getProperty("a"))>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testLoadComments" returntype="void" access="public" output="false">
		<cfset var props = newPropertiesForFile("comments.properties")>
		<cfset var expectedNames = arrayNew(1)>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames)>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="testLoadAllFormatVariations" returntype="void" access="public" output="false">
		<cfset var props = newPropertiesForFile("all.properties")>
		<cfset var expectedNames = listToArray("a,a.2,aa,b,b:3,b=3,b==3,c,d,e,f,g,h,i,j,k", ",")>
		<cfset var actualNames = props.propertyNames()>
		
		<cfset assertEqualsArray(expectedNames, actualNames)>
		
		<cfset assertEqualsString("1", props.getProperty("a"))>
		<cfset assertEqualsString("2", props.getProperty("a.2"))>
		<cfset assertEqualsString("", props.getProperty("aa"))>
		<cfset assertEqualsString("3", props.getProperty("b"))>
		<cfset assertEqualsString("4", props.getProperty("b:3"))>
		<cfset assertEqualsString("5", props.getProperty("b=3"))>
		<cfset assertEqualsString("6", props.getProperty("b==3"))>
		<cfset assertEqualsString("b=7", props.getProperty("c"))>
		<cfset assertEqualsString("8", props.getProperty("d"))>
		<cfset assertEqualsString("9", props.getProperty("e"))>
		<cfset assertEqualsString("1011", props.getProperty("f"))>
		<cfset assertEqualsString("12", props.getProperty("g"))>
		<cfset assertEqualsString("13 14", props.getProperty("h"))>
		<cfset assertEqualsString("\15", props.getProperty("i"))>
		<cfset assertEqualsString("16\", props.getProperty("j"))>
		<cfset assertEqualsString("17\m", props.getProperty("k"))>
	</cffunction>

	
	<!------------------------------------------------------------------------------------>
	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="newPropertiesForFile" returntype="org.cfcunit.util.Properties" access="private" output="false">
		<cfargument name="fileName" type="string" required="true"/>
		
		<cfset var props = newObject("org.cfcunit.util.Properties").init()>
		<cfset var filePath = expandPath("/org/cfcunit/tests/util/PropertiesTest/" & arguments.fileName)>
		
		<cfreturn props.load(filePath)/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>