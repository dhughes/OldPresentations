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

<!--- Set the configuration mode (when to reload): -1=never, 0=dynamic, 1=always --->
<cfset MACHII_CONFIG_MODE = 0>
<cfset MACHII_CONFIG_PATH = ExpandPath("app/machii/config/mach-ii.xml")>
<cfset MACHII_RESET = FALSE>
<cfset MACHII_APP_KEY = "cfcunit">

<!--------------------------------------------------------------------------------------------->
<cfsetting showdebugoutput="false"/>

<cfinclude template="machII/mach-ii.cfm"/>

<cfsetting showdebugoutput="false"/>

<!--------------------------------------------------------------------------------------------->