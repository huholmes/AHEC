<cfcomponent>
	<cffunction name="constructLink" returntype="string" access="public">
        <cfswitch expression ="#navLevelPG#">
            <cfcase value = "0">
                <cfset Session.RootLevel = "">
            </cfcase>
            <cfcase value = "1">
                <cfset Session.RootLevel = "../">
            </cfcase>
            <cfcase value = "2">
                <cfset Session.RootLevel = "../../">
            </cfcase>                                        
        </cfswitch> 
            <cfif "#navFolder#" eq 'none'>
                <cfset Session.AccessFolder = "">
            <cfelse>
                <cfset Session.AccessFolder = "#navFolder#/">
            </cfif>
            <cfif "#navSubFolder#" eq 'none'>
                <cfset Session.AccessSubFolder = "">
            <cfelse>
                <cfset Session.AccessSubFolder = "#navSubFolder#/">
            </cfif>                                          
        	<cfif "#navPage#" eq 'none'>
            	<cfreturn ''>
            <cfelse>
            	<cfreturn "#Session.RootLevel##Session.AccessFolder##Session.AccessSubFolder##navPage#">
            </cfif>
	</cffunction>
	<cffunction name="ActiveCheck" returntype="string" access="public">
            <cfif "#navFolder#" eq 'none'>
                <cfset AP.AccessFolder = "">
            <cfelse>
                <cfset AP.AccessFolder = "/#navFolder#/">
            </cfif>
            <cfif "#navSubFolder#" eq 'none'>
                <cfset AP.AccessSubFolder = "">
            <cfelse>
                <cfset AP.AccessSubFolder = "#navSubFolder#/">
            </cfif>                                          
            	<cfreturn "#AP.AccessFolder##AP.AccessSubFolder##navPage#">
	</cffunction>
</cfcomponent>