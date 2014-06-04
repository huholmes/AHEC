    <!--Construct links for Folder-->
    <cfset navLevelPG =  '#This.CurrentLevel#'> 
    <cfquery name="BreadCrumbs" datasource="#datasource2#">
        SELECT * FROM Navigation WHERE accessType = '#Session.AccessLevel#' AND navLevel = '#This.ActiveFolder#'
    </cfquery>
            		<cfset navFolder = '#BreadCrumbs.folder#'>
                    <cfset navSubFolder = '#BreadCrumbs.subfolder#'>    
                    <cfset navPage = '#BreadCrumbs.page#'> 
                    <cfset pnavLink = '#constructLink()#'> 
    <!--Construct links for Sub Folder-->
    <cfif isdefined("This.ActiveSubFolder")>
		<cfquery name="SBreadCrumbs" datasource="#datasource2#">
		SELECT * FROM Navigation WHERE accessType = '#Session.AccessLevel#' AND navLevel = '#This.ActiveSubFolder#'
		</cfquery> 
            		<cfset navFolder = '#SBreadCrumbs.folder#'>
                    <cfset navSubFolder = '#SBreadCrumbs.subfolder#'>    
                    <cfset navPage = '#SBreadCrumbs.page#'> 
                    <cfset spnavLink = '#constructLink()#'>  
    </cfif>     
    <div class="headerbar">
      
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      
      
      <div class="header-right">
        <ul class="headermenu">
          <!--<li>
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <p><i class="glyphicon glyphicon-warning-sign"></i>
                </p>
              </button>
<div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title">Report Error/Suggestion</h5>
                <ul class="dropdown-list user-list">
                  <li class="new">
                    <div class="thumb"><span class="fa fa-hdd-o" style="font-size:36px;"></span></div>
                    <div class="desc">
                      <h5><a href="">Database Error</a> <span class="badge badge-danger">High</span></h5>
                    </div>
                  </li>
                  <li class="new">
                    <div class="thumb"><span class="fa fa-code" style="font-size:36px;"></span></div>
                    <div class="desc">
                      <h5><a href="">HTML Error</a> <span class="badge badge-warning">Normal</span></h5>
                    </div>
                  </li>
                  <li>
                    <div class="thumb"><span class="fa fa-terminal" style="font-size:36px;"></span></div>
                    <div class="desc">
                      <h5><a href="">Javascript Error</a> <span class="badge badge-warning">Normal</span></h5>
                    </div>
                  </li>
                  <li>
                    <div class="thumb"><span class="fa fa-comment" style="font-size:36px;"></span></div>
                    <div class="desc">
                      <h5><a href="">General Suggestion</a> <span class="badge badge-primary">Low</span></h5>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </li>!-->
          
          <li>
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
              <i class="glyphicon glyphicon-envelope"></i></button>
              <div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title">You Have 1 New Message</h5>
                <ul class="dropdown-list gen-list">
                  <li class="new">
                    <a href="#">
                    <div class="thumb"><span class="fa fa-envelope" style="font-size:36px;"></span></div>
                    <span class="desc">
                      <span class="name">Programs Office <span class="badge badge-success">new</span></span>
                      <span class="msg">Pending Data Required</span>
                    </span>
                    </a>
                  </li>

                  <li class="new"><a href="#">Read All Messages</a></li>
                </ul>
              </div>
            </div>
          </li>
          <li>
            <div class="btn-group">
              <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
              <i class="glyphicon glyphicon-globe"></i></button>
              <div class="dropdown-menu dropdown-menu-head pull-right">
                <h5 class="title">You Have 1 New Notifications</h5>
                <ul class="dropdown-list gen-list">
                  <li class="new">
                    <a href="#">
                    <div class="thumb"><span class="fa fa-square" style="font-size:36px;"></span></div>
                    <span class="desc">
                      <span class="name">Updates Required <span class="badge badge-warning">new</span></span>
                      <span class="msg">please update records as soon as possible</span>
                    </span>
                    </a>
                  </li>
                  <li class="new"><a href="#">See All Notifications</a></li>
                </ul>
              </div>
            </div>
          </li>
          <li>
            <div class="btn-group">
              <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <img src="../images/photos/loggeduser.png" alt="" />
                <cfoutput>#Session.UserID#</cfoutput>
                <span class="caret"></span>
              </button>
              <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
                <li><a href="#"><i class="glyphicon glyphicon-user"></i> My Profile</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> Account Settings</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-question-sign"></i> Help</a></li>
                <li><a href="?logoff"><i class="glyphicon glyphicon-log-out"></i> Log Out</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div><!-- header-right -->
      
    </div><!-- headerbar -->
    
    <div class="pageheader">
      <h2><i class="<cfoutput>#This.Icon#</cfoutput>"></i> <cfoutput>#This.PageName#</cfoutput></h2>
      <div class="breadcrumb-wrapper">
        <span class="label">You are here:</span>
        <ol class="breadcrumb">
          <li><a href="<cfoutput>#pnavLink#</cfoutput>"><cfoutput>#BreadCrumbs.NavTitle#</cfoutput></a></li>
          <cfif isdefined("This.ActiveSubFolder")>
          	<li><a href="<cfoutput>#spnavLink#</cfoutput>"><cfoutput>#SBreadCrumbs.NavTitle#</cfoutput></a></li>
          </cfif>
          <li class="active"><cfoutput>#This.PageName#</cfoutput></li>
        </ol>
      </div>
    </div>