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

<cfcomponent displayname="StackFilterTest" extends="org.cfcunit.framework.TestCase" output="false" hint="">

	<!---------------------------------------------------------------------------->
	
	<cfproperty name="fFiltered" type="string" hint=""/>
	<cfproperty name="fUnfiltered" type="string" hint=""/>
	
	<cfset variables.fFiltered = NULL>
	<cfset variables.fUnfiltered = NULL>
	<cfset variables.fBaseTestRunner = NULL>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="setUp" returntype="void" access="private" output="false">
		<cfset variables.fUnfiltered = createUnfilteredStackTrace()>
		<cfset variables.fFiltered = createFilteredStackTrace()>
		<cfset variables.fBaseTestRunner = newObject("org.cfcunit.runner.BaseTestRunner")>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="testFilter" returntype="void" access="public" output="false">
		<cfset var expected = variables.fFiltered>
		<cfset var actual = variables.fBaseTestRunner.getFilteredTraceFromString(variables.fUnfiltered)>
		
		<cfset assertEqualsString(variables.fFiltered, variables.fBaseTestRunner.getFilteredTraceFromString(variables.fUnfiltered))>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="createFilteredStackTrace" returntype="string" access="private" output="false">
		<cfset var traceString = NULL>
		<cfset var output = NULL>
		<cfset var newLine = Chr(13) & Chr(10)>
		<cfset var hTab = Chr(9)>
		<cfset var line = NULL>
		<cfset var rootDir = ExpandPath("/cfcunit")>
		
		<cfoutput>
		<cfsavecontent variable="traceString">
			coldfusion.runtime.CustomException:
			at cfStackFilterTest2ecfc682174456$funcTESTERROR.runFunction(#rootDir#\cfc\tests\runner\StackFilterTest.cfc:17)
			at cfTestCase2ecfc2082517284$funcRUNTEST.runFunction(#rootDir#\cfc\framework\TestCase.cfc:137)
			at cfTestCase2ecfc2082517284$funcRUNBARE.runFunction(#rootDir#\cfc\framework\TestCase.cfc:114)
			at cf$run2ecfc1087960363$funcPROTECT.runFunction(#rootDir#\cfc\framework\TestResult\$run.cfc:6)
			at cfTestResult2ecfc1820102668$funcRUNPROTECTED.runFunction(#rootDir#\cfc\framework\TestResult.cfc:171)
			at cfTestResult2ecfc1820102668$funcRUN.runFunction(#rootDir#\cfc\framework\TestResult.cfc:159)
			at cfTestCase2ecfc2082517284$funcRUN.runFunction(#rootDir#\cfc\framework\TestCase.cfc:167)
			at cfTestSuite2ecfc2006137638$funcRUNTEST.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:366)
			at cfTestSuite2ecfc2006137638$funcRUN.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:356)
			at cfTestSuite2ecfc2006137638$funcRUNTEST.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:366)
			at cfTestSuite2ecfc2006137638$funcRUN.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:356)
			at cfTestRunner2ecfc1263382722$funcDORUN.runFunction(#rootDir#\cfc\textui\TestRunner.cfc:67)
			at cfTestRunner2ecfc1263382722$funcSTART.runFunction(#rootDir#\cfc\textui\TestRunner.cfc:157)
			at cfTestRunner2ecfc1263382722$funcEXECUTE.runFunction(#rootDir#\cfc\textui\TestRunner.cfc:84)
			at cfAllTests2ecfm1468790210.runPage(#rootDir#\testing\runner\AllTests.cfm:26)
		</cfsavecontent>
		</cfoutput>
		
		<cfloop list="#Trim(traceString)#" index="line" delimiters="#newLine#">
			<cfset line = Trim(line)>
			<cfif Left(line, 3) IS "at ">
				<cfset line = hTab & line>
			</cfif>
			<cfset output = output & line & newLine>
		</cfloop>
		
		<cfreturn output/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->
	
	<cffunction name="createUnfilteredStackTrace" returntype="string" access="private" output="false">
		<cfset var traceString = NULL>
		<cfset var output = NULL>
		<cfset var newLine = Chr(13) & Chr(10)>
		<cfset var hTab = Chr(9)>
		<cfset var line = NULL>
		<cfset var rootDir = ExpandPath("/cfcunit")>
		
		<cfoutput>
		<cfsavecontent variable="traceString">
			coldfusion.runtime.CustomException: 
			at coldfusion.tagext.lang.ThrowTag.doStartTag(ThrowTag.java:124)
			at coldfusion.runtime.CfJspPage._emptyTag(CfJspPage.java:1871)
			at cfStackFilterTest2ecfc682174456$funcTESTERROR.runFunction(#rootDir#\cfc\tests\runner\StackFilterTest.cfc:17)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:359)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:196)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:139)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1582)
			at coldfusion.tagext.lang.InvokeTag.doEndTag(InvokeTag.java:331)
			at cfTestCase2ecfc2082517284$funcRUNTEST.runFunction(#rootDir#\cfc\framework\TestCase.cfc:137)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.CfJspPage._invokeUDF(CfJspPage.java:1768)
			at cfTestCase2ecfc2082517284$funcRUNBARE.runFunction(#rootDir#\cfc\framework\TestCase.cfc:114)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cf$run2ecfc1087960363$funcPROTECT.runFunction(#rootDir#\cfc\framework\TestResult\$run.cfc:6)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cfTestResult2ecfc1820102668$funcRUNPROTECTED.runFunction(#rootDir#\cfc\framework\TestResult.cfc:171)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.CfJspPage._invokeUDF(CfJspPage.java:1768)
			at cfTestResult2ecfc1820102668$funcRUN.runFunction(#rootDir#\cfc\framework\TestResult.cfc:159)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cfTestCase2ecfc2082517284$funcRUN.runFunction(#rootDir#\cfc\framework\TestCase.cfc:167)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cfTestSuite2ecfc2006137638$funcRUNTEST.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:366)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.CfJspPage._invokeUDF(CfJspPage.java:1768)
			at cfTestSuite2ecfc2006137638$funcRUN.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:356)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cfTestSuite2ecfc2006137638$funcRUNTEST.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:366)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.CfJspPage._invokeUDF(CfJspPage.java:1768)
			at cfTestSuite2ecfc2006137638$funcRUN.runFunction(#rootDir#\cfc\framework\TestSuite.cfc:356)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cfTestRunner2ecfc1263382722$funcDORUN.runFunction(#rootDir#\cfc\textui\TestRunner.cfc:67)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.filter.SilentFilter.invoke(SilentFilter.java:44)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.CfJspPage._invokeUDF(CfJspPage.java:1768)
			at cfTestRunner2ecfc1263382722$funcSTART.runFunction(#rootDir#\cfc\textui\TestRunner.cfc:157)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.CfJspPage._invokeUDF(CfJspPage.java:1768)
			at cfTestRunner2ecfc1263382722$funcEXECUTE.runFunction(#rootDir#\cfc\textui\TestRunner.cfc:84)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:338)
			at coldfusion.runtime.UDFMethod$ReturnTypeFilter.invoke(UDFMethod.java:286)
			at coldfusion.runtime.UDFMethod$ArgumentCollectionFilter.invoke(UDFMethod.java:250)
			at coldfusion.filter.FunctionAccessFilter.invoke(FunctionAccessFilter.java:53)
			at coldfusion.runtime.UDFMethod.runFilterChain(UDFMethod.java:203)
			at coldfusion.runtime.UDFMethod.invoke(UDFMethod.java:165)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:192)
			at coldfusion.runtime.TemplateProxy.invoke(TemplateProxy.java:130)
			at coldfusion.runtime.CfJspPage._invoke(CfJspPage.java:1622)
			at cfAllTests2ecfm1468790210.runPage(#rootDir#\testing\runner\AllTests.cfm:26)
			at coldfusion.runtime.CfJspPage.invoke(CfJspPage.java:147)
			at coldfusion.tagext.lang.IncludeTag.doStartTag(IncludeTag.java:357)
			at coldfusion.filter.CfincludeFilter.invoke(CfincludeFilter.java:62)
			at coldfusion.filter.ApplicationFilter.invoke(ApplicationFilter.java:107)
			at coldfusion.filter.RequestMonitorFilter.invoke(RequestMonitorFilter.java:43)
			at coldfusion.filter.PathFilter.invoke(PathFilter.java:80)
			at coldfusion.filter.ExceptionFilter.invoke(ExceptionFilter.java:47)
			at coldfusion.filter.BrowserDebugFilter.invoke(BrowserDebugFilter.java:52)
			at coldfusion.filter.ClientScopePersistenceFilter.invoke(ClientScopePersistenceFilter.java:28)
			at coldfusion.filter.BrowserFilter.invoke(BrowserFilter.java:35)
			at coldfusion.filter.GlobalsFilter.invoke(GlobalsFilter.java:43)
			at coldfusion.filter.DatasourceFilter.invoke(DatasourceFilter.java:22)
			at coldfusion.CfmServlet.service(CfmServlet.java:105)
			at coldfusion.bootstrap.BootstrapServlet.service(BootstrapServlet.java:89)
			at jrun.servlet.ServletInvoker.invoke(ServletInvoker.java:91)
			at jrun.servlet.JRunInvokerChain.invokeNext(JRunInvokerChain.java:42)
			at jrun.servlet.JRunRequestDispatcher.invoke(JRunRequestDispatcher.java:252)
			at jrun.servlet.ServletEngineService.dispatch(ServletEngineService.java:527)
			at jrun.servlet.jrpp.JRunProxyService.invokeRunnable(JRunProxyService.java:192)
			at jrunx.scheduler.ThreadPool$ThreadThrottle.invokeRunnable(ThreadPool.java:451)
			at jrunx.scheduler.WorkerThread.run(WorkerThread.java:66)
		</cfsavecontent>
		</cfoutput>
		
		<cfloop list="#Trim(traceString)#" index="line" delimiters="#newLine#">
			<cfset line = Trim(line)>
			<cfif Left(line, 3) IS "at ">
				<cfset line = hTab & line>
			</cfif>
			<cfset output = output & line & newLine>
		</cfloop>
		
		<cfreturn output/>
	</cffunction>
	
	<!---------------------------------------------------------------------------->

</cfcomponent>