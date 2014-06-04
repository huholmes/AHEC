<cfcomponent>

<CFAPPLICATION NAME="" SESSIONMANAGEMENT="YES">
<!--Main Database Connections-->
	<cfset datasource = "ahecadmindb">
    <cfset datasource2 = "azahec">
<!--Check user authorization-->
    <cffunction name="checkUser" access="remote"> 
		<cfif IsDefined("Session.UserID")> 
        <cfelse>
            <cflocation url="../signin.cfm" addtoken="NO"> 
            <cfabort> 
         </cfif>   
    </cffunction>
    
    <cfinclude template="../procedures/navLinks.cfc">  
</cfcomponent>    