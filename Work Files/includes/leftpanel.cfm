<!---Page Levels
0 - Root
1 - Parent
2 - Sub Parent
-1 - OutSide Link

All dev files are located on level 0
All includes are located on level 0
Build links with navigation and permissions matrix
--->  
        <cfswitch expression ="#This.CurrentLevel#">
            <cfcase value = "0">
                <cfset This.RootLevel = "">
            </cfcase>
            <cfcase value = "1">
                <cfset This.RootLevel = "../">
            </cfcase>
            <cfcase value = "2">
                <cfset This.RootLevel = "../../">
            </cfcase>                                        
        </cfswitch> 
<!--Navigation Matrix-->

<div class="leftpanel margined42">
    
    <div class="logopanel">
        <h1><span><img src="<cfoutput>#This.RootLevel#</cfoutput>images/AZAHEC Admin.png" alt="logo"></span></h1>
    </div><!-- logopanel -->
        
    <div class="leftpanelinner">    
        
        <!-- This is only visible to small devices -->
        <div class="visible-xs hidden-sm hidden-md hidden-lg">   
            <div class="media userlogged">
                <img alt="" src="images/photos/loggeduser.png" class="media-object">
                <div class="media-body">
                    <h4>Display Name</h4>
                    <span>AZAHEC Admin</span>
                </div>
            </div>
          
            <h5 class="sidebartitle actitle">Account</h5>
            <ul class="nav nav-pills nav-stacked nav-bracket mb30">
              <li><a href="#"><i class="fa fa-user"></i> <span>Profile</span></a></li>
              <li><a href="#"><i class="fa fa-cog"></i> <span>Account Settings</span></a></li>
              <li><a href="#"><i class="fa fa-question-circle"></i> <span>Help</span></a></li>
              <li><a href="#"><i class="fa fa-sign-out"></i> <span>Sign Out</span></a></li>
            </ul>
        </div>
      
      <h5 class="sidebartitle"></h5>
      <ul class="nav nav-pills nav-stacked nav-bracket">
    <cfquery name="Navigation" datasource="#datasource2#">
        SELECT * FROM Navigation WHERE accessType = '#Session.AccessLevel#' AND childOf = 'none' ORDER BY navOrder ASC
    </cfquery>
            		
            <!--Pull Navigation from Database and fill using loop-->
            <cfloop query="Navigation">
                <!--Check Navigation level of the page-->
                <cfset navLevelPG =  '#This.CurrentLevel#'> 
				
   				<!--Set HasChildren from Database-->
				<cfset hasChildren = '#hasChildren#'>
                <!--Check if hasChildren is true; 0=false, 1=true-->
                <cfif hasChildren eq "0">
                <!--BuildLink variables-->
					<cfset navFolder =  '#folder#'>
                    <cfset navSubFolder =  '#subfolder#'>    
                    <cfset navPage =  '#page#'> 
                    <cfset navLink =  '#constructLink()#'>  
                    <cfset APCheck =  '#ActiveCheck()#'>
                    <cfset AFCheck =  '#navLevel#'>
                    <!--Dynamic Class variables-->
						<cfif "#trim(APCheck)#" is "#trim(This.HostName)#">
                            <cfset classLI = "active">
                        <cfelse>
                            <cfset classLI = "">
                        </cfif>  						
					<!--Dynamic Class variables-->
						<cfif "#trim(AFCheck)#" is "#trim(This.ActiveFolder)#">
                            <cfset classLI = "active">
                        <cfelse>
                            <cfset classLI = "">
                        </cfif>                      
                         
                 <!--Set up Non Parent Level-->
                    <li class="<cfoutput>#classLI#</cfoutput>">
                        <!--Set up link for navigation; Rem: Setting up page levels-->
                        <a href="<cfoutput>#navLink#</cfoutput>">
                            <!--Set up icon-->
                            <i class="<cfoutput>#icon#</cfoutput>"></i> 
                                <!--Set up span with name-->
                                <span><cfoutput>#navTitle#</cfoutput></span>
                        </a>
                     </li>
                <cfelse>
                    <cfquery name="CNavigation" datasource="#datasource2#">
        			SELECT * FROM Navigation WHERE accessType = '#Session.AccessLevel#' AND childOf = '#Navigation.navTitle#' ORDER BY navOrder ASC
    				</cfquery>
				<cfset navFolder =  '#folder#'>
				<cfset navSubFolder =  '#subfolder#'>    
                <cfset navPage =  '#page#'>               
                <cfset navLink =  '#constructLink()#'>
				<cfset APCheck =  '#ActiveCheck()#'>
                    <cfset AFCheck =  '#navLevel#'>
                    <!--Dynamic Class variables-->
						<cfif "#trim(APCheck)#" is "#trim(This.HostName)#">
                            <cfset classLI = "active">
                        <cfelse>
                            <cfset classLI = "">
                        </cfif>  						
					<!--Dynamic Class variables-->
						<cfif "#trim(AFCheck)#" is "#trim(This.ActiveFolder)#">
                            <cfset classLI = "nav-active active nav-hover">
                            <cfset classUL = 'style="display: block"'>
                        <cfelse>
                            <cfset classLI = "">
                            <cfset classUL = "">
                        </cfif>              
               
                <!--Set up Parent Level-->
                    <li class="nav-parent <cfoutput>#classLI#</cfoutput>">
                        <!--Set up link for navigation; Rem: Setting up page levels-->
                        <a href="<cfoutput>#navLink#</cfoutput>">
                            <!--Set up icon-->
                            <i class="<cfoutput>#icon#</cfoutput>"></i> 
                                <!--Set up span with name-->
                                <span><cfoutput>#navTitle#</cfoutput></span>
                        </a>
                     <!--Set up Children Levels-->
                         <ul class="children" <cfoutput>#classUL#</cfoutput>>
                            <cfloop query="CNavigation">
                <cfset classUL = "">
                <cfset classLI = "">
				<cfset navFolder =  '#folder#'>
				<cfset navSubFolder =  '#subfolder#'>    
                <cfset navPage =  '#page#'>   
                <cfset navLink =  '#constructLink()#'>   
				<cfset APCheck =  '#ActiveCheck()# '>
                 <cfset AFCheck =  '#navLevel#'>
                    <!--Dynamic Class variables-->
						<cfif "#trim(APCheck)#" is "#trim(This.HostName)#">
                            <cfset classLI = "active">
                        <cfelse>
                            <cfset classLI = "">
                        </cfif>  						
                    <!--Dynamic Class variables-->
						<cfif StructKeyExists(This,'ActiveSubFolder')>
							<cfif "#trim(AFCheck)#" is "#trim(This.ActiveSubFolder)#">
                                <cfset classLI = "active">
                            <cfelse>
                                <cfset classLI = "">
                            </cfif>                     
                    	</cfif>
                            	<li class="<cfoutput>#classLI#</cfoutput>"><a href="<cfoutput>#navLink#</cfoutput>"><i class="fa fa-caret-right"></i> <cfoutput>#navTitle#</cfoutput></a></li>
                            </cfloop>
                         </ul>
                    </li>
                </cfif>      
			</cfloop>


      </ul><!-- infosummary -->
      
    </div><!-- leftpanelinner -->
  </div>
