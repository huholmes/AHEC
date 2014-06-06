<cfset pageName = listFirst(listLast(CGI.ScriptName, '/'), '?')>
<cfinclude template="../../connection/connection.cfc">
<!--Check if User has been authenticated-->
<!--Check if User want to log off-->
<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="../../signin.cfm" addtoken="NO" >
</cfif>
<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'View Trainee'>
    <cfset This.Icon = 'fa fa-plus'>
    
    <cfset This.CurrentLevel = '2'>
    <cfset This.HostName = '#cgi.script_name#'>
    <cfset This.ActiveFolder = 'hp'>
    <cfset This.ActiveSubFolder = 'hpTrainees'>

<!--Database Calls-->
<cfquery name="rInstitutions" datasource="#datasource2#">
	SELECT * FROM Institutions ORDER BY Institution ASC
</cfquery>

<cfquery name="rDisciplines" datasource="#datasource2#">
	SELECT * FROM Disciplines ORDER BY Discipline ASC
</cfquery>

<cfquery name="rDegrees" datasource="#datasource2#">
	SELECT * FROM DegreeList ORDER BY DegreeTitle ASC
</cfquery>  
<!--Fetch Record-->
<cfif StructKeyExists(url,'id')>
      <cfset Session.TraineeID="#url.id#"> 
<cfelse>
	<cfset Session.TraineeID="1">    	   
</cfif>
  <!--Database Call for Viewing Trainee/ After Session Trainee ID has been set-->
      <cfstoredproc procedure="dbo.viewTrainee" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@traineeID" value="#Session.TraineeID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewTrainee" resultset="1">
      </cfstoredproc>
    
    <cfquery name="viewDegrees" datasource="#datasource2#">
        SELECT * FROM Degrees where TraineeId ='#Session.TraineeID#'
    </cfquery>
    
        <cfquery name="trainees" datasource="#datasource2#">
        SELECT * FROM Trainees
    </cfquery>
<!--set default mode/failsafe-->    
<cfset Session.TraineeMode="v"> 
<cfset title = 'View HP Trainee'>
<!--check if mode has been changed to edit-->
<cfif StructKeyExists(url,'m') and #url.m# eq "e">
  <cfset Session.TraineeMode="e"> 
</cfif>
<!--set page variables incase mode was changed-->  
<cfswitch expression='#Session.TraineeMode#'>
        <cfcase value="v">
                <cfset mode='View'>
                <cfset title='View HP Trainee'>
        </cfcase>
        <cfcase value="e">
                <cfset mode='Edit'>
                <cfset title='Edit HP Trainee'>
        </cfcase>
        <cfdefaultcase>
                <cfset mode='View'>
                <cfset title='View HP Trainee'>
        </cfdefaultcase>
    </cfswitch>
<!--update record on validation-->
<cfif IsDefined("FORM.editTraineeHDN") AND FORM.editTraineeHDN EQ "True">
  <cfquery datasource="#datasource2#">   
    UPDATE dbo.Trainees
SET Status=<cfif IsDefined("FORM.Status") AND #FORM.Status# NEQ "">
<cfqueryparam value="#FORM.Status#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, LastName=<cfif IsDefined("FORM.LastName") AND #FORM.LastName# NEQ "">
<cfqueryparam value="#FORM.LastName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, FirstName=<cfif IsDefined("FORM.FirstName") AND #FORM.FirstName# NEQ "">
<cfqueryparam value="#FORM.FirstName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, MiddleName=<cfif IsDefined("FORM.MiddleName") AND #FORM.MiddleName# NEQ "">
<cfqueryparam value="#FORM.MiddleName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, MaidenName=<cfif IsDefined("FORM.MaidenName") AND #FORM.MaidenName# NEQ "">
<cfqueryparam value="#FORM.MaidenName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmailPreferred=<cfif IsDefined("FORM.EmailPreferred") AND #FORM.EmailPreferred# NEQ "">
<cfqueryparam value="#FORM.EmailPreferred#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmailUniversity=<cfif IsDefined("FORM.EmailUniversity") AND #FORM.EmailUniversity# NEQ "">
<cfqueryparam value="#FORM.EmailUniversity#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmailPermanent=<cfif IsDefined("FORM.EmailPermanent") AND #FORM.EmailPermanent# NEQ "">
<cfqueryparam value="#FORM.EmailPermanent#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Phone=<cfif IsDefined("FORM.Phone") AND #FORM.Phone# NEQ "">
<cfqueryparam value="#FORM.Phone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmergContactName=<cfif IsDefined("FORM.EmergContactName") AND #FORM.EmergContactName# NEQ "">
<cfqueryparam value="#FORM.EmergContactName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, EmergContactPhone=<cfif IsDefined("FORM.EmergContactPhone") AND #FORM.EmergContactPhone# NEQ "">
<cfqueryparam value="#FORM.EmergContactPhone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, InstitutionID=<cfif IsDefined("FORM.Institution") AND #FORM.Institution# NEQ "">
<cfqueryparam value="#FORM.Institution#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, InstitutionLevel=<cfif IsDefined("FORM.InstitutionLevel") AND #FORM.InstitutionLevel# NEQ "">
<cfqueryparam value="#FORM.InstitutionLevel#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, DisciplineID=<cfif IsDefined("FORM.Discipline") AND #FORM.Discipline# NEQ "">
<cfqueryparam value="#FORM.Discipline#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, Enrollment=<cfif IsDefined("FORM.Enrollment") AND #FORM.Enrollment# NEQ "">
<cfqueryparam value="#FORM.Enrollment#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, DOB=<cfif IsDefined("FORM.DOB") AND #FORM.DOB# NEQ "">
<cfqueryparam value="#FORM.DOB#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, Sex=<cfif IsDefined("FORM.Sex") AND #FORM.Sex# NEQ "">
<cfqueryparam value="#FORM.Sex#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Ethnicity=<cfif IsDefined("FORM.Ethnicity") AND #FORM.Ethnicity# NEQ "">
<cfqueryparam value="#FORM.Ethnicity#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Race=<cfif IsDefined("FORM.Race") AND #FORM.Race# NEQ "">
<cfqueryparam value="#FORM.Race#" cfsqltype="cf_sql_clob" maxlength="150">
<cfelse>
''
</cfif>
, RuralBackground=<cfif IsDefined("FORM.RuralBackground") AND #FORM.RuralBackground# NEQ "">
<cfqueryparam value="#FORM.RuralBackground#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Disadvantaged=<cfif IsDefined("FORM.Disadvantaged") AND #FORM.Disadvantaged# NEQ "">
<cfqueryparam value="#FORM.Disadvantaged#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, AZbackground=<cfif IsDefined("FORM.AZbackground") AND #FORM.AZbackground# NEQ "">
<cfqueryparam value="#FORM.AZbackground#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, MilitaryStatusPre=<cfif IsDefined("FORM.MilitaryStatusPre") AND #FORM.MilitaryStatusPre# NEQ "">
<cfqueryparam value="#FORM.MilitaryStatusPre#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, SpecialHousing=<cfif IsDefined("FORM.SpecialHousing") AND #FORM.SpecialHousing# NEQ "">
<cfqueryparam value="#FORM.SpecialHousing#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, Notes=<cfif IsDefined("FORM.Notes") AND #FORM.Notes# NEQ "">
<cfqueryparam value="#FORM.Notes#" cfsqltype="cf_sql_clob" maxlength="4000">
<cfelse>
''
</cfif>
, LastEditedBy='#SESSION.UserID#', DateUpdated=DEFAULT WHERE ID='#Session.TraineeID#'
  </cfquery>
  
      <cfset Session.TraineeRecordEdit="Yes">
      <cfset Session.TraineeMode="V">
      <cflocation url = "?id=#Session.TraineeID#" addtoken="no">
</cfif>

<!--Open Navigation-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Ashar Babar Concepts">
  <link rel="shortcut icon" href="../../images/favicon.ico" type="image/png">

  <title>AZAHEC Admin - View Trainee</title>

  <link href="../../css/style.default.css" rel="stylesheet">
  <link href="../../css/jquery.datatables.css" rel="stylesheet">
  <link href="../../css/jquery.gritter.css" rel="stylesheet">
  <link id="fontswitch" rel="stylesheet" href="/css/font.helvetica-neue.css">
  <link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">	
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->

</head>

<body>

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<!--UA Web Banner -->
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark red-grad">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>



<section>
  
    <!-- leftpanel -->
  	<cfinclude template="../../includes/leftpanel.cfm">
  <!-- leftpanel -->
  
  <!-- mainpanel start -->
  <div class="mainpanel">
    
	  <!-- header -->
  		<cfinclude template="../../includes/header.cfm">
  	  <!-- header -->
    
        <!-- content dynamic -->
<div class="contentpanel">
      
      <div class="row">
        <div class="col-sm-3">
          <img src="../../images/profilr.jpg" class="thumbnail img-responsive" alt="" style="margin-left:auto;margin-right:auto;"/>
          
          <div class="mb30"></div>
            <h5 class="subtitle">Trainee Tasks</h5>
                
<div class="widget-todo mb5">
              <ul class="todo-list">
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="CP" checked disabled>
                        <label for="CP">Complete Profile</label>
                    </div>
                </li>
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="AE" disabled>
                        <label for="AE">Add Experience</label>
                    </div>
                </li>
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="AE" disabled>
                        <label for="AE">Add Support Info</label>
                    </div>
                </li>                
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="CR" disabled>
                        <label for="CR">Completion Report</label>
                    </div>
                </li>
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="GC" disabled>
                        <label for="GC">Graduation Check</label>
                    </div>
                </li>
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="FUR" disabled>
                        <label for="FUR">Follow Up Report</label>
                    </div>
                </li>
                <li>
                    <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="AFU" disabled>
                        <label for="AFU">Additional Follow Up</label>
                    </div>
                </li>
              </ul>
          </div>				
			<h5 class="subtitle">Contact</h5>
<ul class="profile-social-list">
            <li><i class="fa fa-envelope-square"></i> <a href="">Email Address</a></li>
          </ul>                
          <div class="mb30"></div>
          
          <div class="mb30"></div>
          
        </div><!-- col-sm-3 -->
        <div class="col-sm-9">
          <div class="profile-header">
                    <h2 class="profile-name"><cfoutput>#viewTrainee.FirstName# #viewTrainee.LastName#</cfoutput></h2>
					<p><i class="fa fa-tags"></i> Trainee ID: <strong><cfoutput>#viewTrainee.ID#</cfoutput></strong></p>
                    <p><i class="fa fa-pencil-square-o"></i> Last Edited: <strong><cfoutput>#viewTrainee.LastEditedBy#</cfoutput> on <cfoutput>#viewTrainee.DateUpdated#</cfoutput></strong></p>
                    <div class="mb5"></div>
							<div class="btn-group mr10">
                                <a href="?m=e" class="btn btn-primary"><i class="fa fa-pencil"></i> Edit Profile</a>
                                <button class="btn btn-danger" type="button"><i class="fa fa-trash-o mr5"></i> Delete</button>
                            </div>  
							<div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-default dropdown-toggle" type="button">
                                    <i class="fa fa-plus mr5"></i> Add
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Add Field Experience</a></li>
                                    <li><a href="#">Add Degree Information</a></li>
                                    <li><a href="#">Add Support Information</a></li>
                                    <li><a href="#">Add Address</a></li>
                                    <li><a href="#">Add Completion Report</a></li>
                                    <li><a href="#">Add FollowUp Report</a></li>
                                </ul>
                            </div>  
							<div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-success dropdown-toggle" type="button">
                                    <i class="fa fa-arrow-circle-o-down mr5"></i> Export
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">PDF</a></li>
                                    <li><a href="#">Print</a></li>
                                </ul>
                            </div>                                                             
                  </div>

          
          <!-- Nav tabs -->
        <ul class="nav nav-tabs nav-justified nav-profile">
          <li class="active"><a href="#profile" data-toggle="tab"><strong>Profile</strong></a></li>
          <li><a href="#rotations" data-toggle="tab"><strong>Experiences</strong></a></li>
          <li><a href="#degrees" data-toggle="tab"><strong>Degrees</strong></a></li>
          <li><a href="#degrees" data-toggle="tab"><strong>Completion</strong></a></li>
          <li><a href="#degrees" data-toggle="tab"><strong>Follow Ups</strong></a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
          <div class="tab-pane active" id="profile">
            <!-- activity-list -->
<form class="form-horizontal form-bordered" id="editTrainee" method="Post">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title"><cfoutput>#title#</cfoutput></h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Status <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">
              <select class="form-control" name="status" required>
                <option value="<cfoutput>#viewTrainee.Status#</cfoutput>"><cfoutput>#viewTrainee.Status#</cfoutput></option>
                <option value="Continuing">Continuing</option>
                <option value="Graduated">Graduated</option>
                <option value="Leave of Absense">Leave of Absense</option>
                <option value="Withdrew">Withdrew</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Status#</cfoutput></label>
                </cfcase>
            </cfswitch>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Last Name <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">
              <input type="text" value="<cfoutput>#viewTrainee.LastName#</cfoutput>" class="form-control" name="LastName" required>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.LastName#</cfoutput></label>
                </cfcase>
            </cfswitch>
            </div>
            <label class="col-sm-2 control-label">First Name <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">            
              <input type="text" value="<cfoutput>#viewTrainee.FirstName#</cfoutput>" class="form-control" name="FirstName" required>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.FirstName#</cfoutput></label>
                </cfcase>
            </cfswitch>              
              
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Middle Name</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <input type="text" value="<cfoutput>#viewTrainee.MiddleName#</cfoutput>" class="form-control" name="MiddleName">
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.MiddleName#</cfoutput></label>
                </cfcase>
            </cfswitch>  
            </div>
            <label class="col-sm-2 control-label">Maiden Name</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">                 
              <input type="text" value="<cfoutput>#viewTrainee.MaidenName#</cfoutput>" class="form-control" name="MaidenName">
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.MaidenName#</cfoutput></label>
                </cfcase>
            </cfswitch>                
            </div>
          </div>
        </div>
        <!-- panel-body --> 
        
      </div>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Contact Information</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Email Preferred <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">    
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmailPreferred#</cfoutput>" id="preferredemail" class="form-control" name="EmailPreferred" required>
				</div>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.EmailPreferred#</cfoutput></label>
                </cfcase>
            </cfswitch>  
            </div>
            <label class="col-sm-2 control-label">University Email</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">              
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmailUniversity#</cfoutput>" id="uniemail" class="form-control" name="EmailUniversity">
              </div>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.EmailUniversity#</cfoutput></label>
                </cfcase>
            </cfswitch>  
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Permanent Email</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">               
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmailPermanent#</cfoutput>" id="permemail" class="form-control" name="EmailPermanent">
          
              </div>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.EmailPermanent#</cfoutput></label>
                </cfcase>
            </cfswitch>   
            </div>
            <label class="col-sm-2 control-label">Phone Number</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">  
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.Phone#</cfoutput>" id="phone" class="form-control" name="Phone">
              </div>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Phone#</cfoutput></label>
                </cfcase>
            </cfswitch>  
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Emergency Contact</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">            
              <input type="text" value="<cfoutput>#viewTrainee.EmergContactName#</cfoutput>" id="emergencycontact" class="form-control" name="EmergContactName">
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.EmergContactName#</cfoutput></label>
                </cfcase>
            </cfswitch>                
            </div>
            <label class="col-sm-2 control-label">Emergency Phone</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmergContactPhone#</cfoutput>" id="emergencyphone" class="form-control" name="EmergContactPhone">
              </div>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.EmergContactPhone#</cfoutput></label>
                </cfcase>
            </cfswitch>  
            </div>
          </div>
        </div>
        <!-- panel-body --> 
        
      </div>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Academic/Training Program Information</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
          
            <label class="col-sm-2 control-label">Institution <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">  
              <select class="form-control chosen-select" data-placeholder="Choose an Institution..." name="Institution">
                <option value="<cfoutput>#viewTrainee.InstitutionID#</cfoutput>"><cfoutput>#viewTrainee.Institution#</cfoutput></option>
                <cfoutput query="rInstitutions">
                    <option value="#ID#">#Institution#</option>
                  </cfoutput>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Institution#</cfoutput></label>
                </cfcase>
            </cfswitch>                
            </div>
            <label class="col-sm-2 control-label">Level</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">              
              <select class="form-control" data-placeholder="Choose an Level..." name="InstitutionLevel">
                <option value="<cfoutput>#viewTrainee.InstitutionLevel#</cfoutput>"><cfoutput>#viewTrainee.InstitutionLevel#</cfoutput></option>
                <option value="Vocational training">Vocational training</option>
                <option value="Undergraduate program">Undergraduate program</option>
                <option value="Graduate program">Graduate program</option>
                <option value="Fellowship">Fellowship</option>
                <option value="Residency">Residency</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.InstitutionLevel#</cfoutput></label>
                </cfcase>
            </cfswitch>               
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Primary Discipline <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">            
              <select class="form-control chosen-select" data-placeholder="Choose an Organization..." name="Discipline">
                <option value="<cfoutput>#viewTrainee.DisciplineID#</cfoutput>"><cfoutput>#viewTrainee.Discipline#</cfoutput></option>
                <cfoutput query="rDisciplines">
                    <option value="#ID#">#Discipline#</option>
                  </cfoutput>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Discipline#</cfoutput></label>
                </cfcase>
            </cfswitch>                 
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Enrollment</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control " data-placeholder="Choose an Enrollment type..." name="Enrollment">
                <option value="<cfoutput>#viewTrainee.Enrollment#</cfoutput>"><cfoutput>#viewTrainee.Enrollment#</cfoutput></option>
                <option value="Part Time">Part Time</option>
                <option value="Full Time">Full Time</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Enrollment#</cfoutput></label>
                </cfcase>
            </cfswitch>                
            </div>
          </div>
          </div>
        <!-- panel-body --> 
        
      </div>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Demographics</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Date of Birth</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit"> 
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                <input type="text" value="<cfoutput><cfif IsDate(#viewTrainee.DOB#)>#DatePart("m",viewTrainee.DOB)#-#DatePart("d",viewTrainee.DOB)#-#DatePart("yyyy",viewTrainee.DOB)#</cfif></cfoutput>" id="DOB" class="form-control" name="DOB">
              </div>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput><cfif IsDate(#viewTrainee.DOB#)>#DatePart("m",viewTrainee.DOB)#-#DatePart("d",viewTrainee.DOB)#-#DatePart("yyyy",viewTrainee.DOB)#</cfif></cfoutput></label>
                </cfcase>
            </cfswitch>                
            </div>
            <label class="col-sm-2 control-label">Sex <span class="asterisk">*</span></label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <div class="rdio rdio-primary">
                <input type="radio" name="sex" value="Male" id="sexMale" required <cfif '#viewTrainee.Sex#'eq"Male">checked</cfif>>
                <label for="sexMale">Male</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="sex" value="Female" id="sexFemale" <cfif '#viewTrainee.Sex#'eq"Female">checked</cfif>>
                <label for="sexFemale">Female</label>
              </div>
              <label class="error" for="sex"></label>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Sex#</cfoutput></label>
                </cfcase>
            </cfswitch>                
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="Ethnicity">Ethnicity</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">            
              <select class="form-control" data-placeholder="Choose an Ethnicity..." name="Ethnicity">
                <option value="<cfoutput>#viewTrainee.Ethnicity#</cfoutput>"><cfoutput>#viewTrainee.Ethnicity#</cfoutput></option>
                <option value="Hispanic/Latino">Hispanic/Latino</option>
                <option value="Non-Hispanic/Non-Latino">Non-Hispanic/Non-Latino</option>
                <option value="Not reported">Not reported</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Ethnicity#</cfoutput></label>
                </cfcase>
            </cfswitch>               
            </div>
            </div>
            <div class="form-group">
            <label class="col-sm-2 control-label">Race</label>
            <div class="col-sm-6">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">              
              <select class="form-control" data-placeholder="Choose a Race..." name="Race">
                <option value="<cfoutput>#viewTrainee.Race#</cfoutput>"><cfoutput>#viewTrainee.Race#</cfoutput></option>
                <option value="American Indian or Alsaka Native">American Indian or Alsaka Native</option>
                <option value="Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)">Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)</option>
                <option value="Other Asian">Other Asian</option>
                <option value="Black or African American">Black or African American</option>
                <option value="Native Hawaiian/Other Pacific Islander">Native Hawaiian/Other Pacific Islander</option>
                <option value="White">White</option>
                <option value="Other(Not Reported)">Other(Not Reported)</option>
                <option value="More than one race">More than one race</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Race#</cfoutput></label>
                </cfcase>
            </cfswitch>             
            </div>
            
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Rural Background</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control" data-placeholder="Choose a Background..." name="RuralBackground">
                <option value="<cfoutput>#viewTrainee.RuralBackground#</cfoutput>"><cfoutput>#viewTrainee.RuralBackground#</cfoutput></option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.RuralBackground#</cfoutput></label>
                </cfcase>
            </cfswitch>                
              <span class="help-block">Did the trainee grow up in a rural area (&lt;50,000 people)?</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Disadvantaged</label>
            <div class="col-sm-8">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control" data-placeholder="Choose an Enrollment type..." name="Disadvantaged">
                <option value="<cfoutput>#viewTrainee.Disadvantaged#</cfoutput>"><cfoutput>#viewTrainee.Disadvantaged#</cfoutput></option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Disadvantaged#</cfoutput></label>
                </cfcase>
            </cfswitch>                 
              <span class="help-block"><strong>A trainee may be considered from a disadvantaged background if he/she can answer yes to one or more of the following statements:</strong>
              <p> 1. Student is the first generation in his/her family to attend college.</p>
              <p> 2. Student has or is currently receiving a scholarship or loan for disadvantaged students.</p>
              <p> 3. While growing up, student or family ever used federal or state assistance programs (such as free or reduced school lunch, subsidized housing, food stamps, Medicaid, etc.)</p>
              <p> 4. While growing up, student lived where there were few medical providers at a convenient distance.</p>
              </span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">AZ Background</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">              
              <select class="form-control" data-placeholder="Choose a Background type..." name="AZbackground">
                <option value="<cfoutput>#viewTrainee.AZbackground#</cfoutput>"><cfoutput>#viewTrainee.AZbackground#</cfoutput></option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.AZbackground#</cfoutput></label>
                </cfcase>
            </cfswitch>                
              <span class="help-block">Did the trainee grow up in Arizona?</span> </div>
            <label class="col-sm-2 control-label">Military Status</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">               
              <select class="form-control" data-placeholder="Choose an Enrollment type..." name="MilitaryStatusPre" >
                <option value="<cfoutput>#viewTrainee.MilitaryStatusPre#</cfoutput>"><cfoutput>#viewTrainee.MilitaryStatusPre#</cfoutput></option>
                <option value="Individual is not a Veteran">Individual is not a Veteran</option>
                <option value="Active duty military">Active duty military</option>
                <option value="Reservist">Reservist</option>
                <option value="Veteran - Prior Service">Veteran - Prior Service</option>
                <option value="Veteran - Retired">Veteran - Retired</option>
                <option value="Not reported">Not reported</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.MilitaryStatusPre#</cfoutput></label>
                </cfcase>
            </cfswitch>              
              <span class="help-block">Military status (pre-matriculation)</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Special Housing</label>
            <div class="col-sm-4">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">             
              <select class="form-control" data-placeholder="Choose a housing type..." name="Specialhousing">
                <option value="<cfoutput>#viewTrainee.Specialhousing#</cfoutput>"><cfoutput>#viewTrainee.Specialhousing#</cfoutput></option>
                <option value="Family">Family</option>
                <option value="Disability accommodation">Disability accommodation</option>
                <option value="Gender-specific">Gender-specific</option>
                <option value="Pets allowed">Pets allowed</option>
                <option value="Religious preference">Religious preference</option>
                <option value="Single-occupant">Single-occupant</option>
              </select>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.Specialhousing#</cfoutput></label>
                </cfcase>
            </cfswitch>                
              <span class="help-block">Special housing needs</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" >Notes</label>
            <div class="col-sm-10">
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">               
              <textarea class="form-control" rows="3" name="notes"><cfoutput>#viewTrainee.notes#</cfoutput></textarea>
              	</cfcase>
                <cfcase value="View">
                <label class="text-primary alignleft"><cfoutput>#viewTrainee.notes#</cfoutput></label>
                </cfcase>
            </cfswitch>               
            </div>
          </div>
        </div>
        <!-- panel-body -->
            <cfswitch expression='#mode#'>
        		<cfcase value="Edit">        
        <div class="panel-footer">
          <div class="row">
            <div class="col-sm-12 ">
              <input type="hidden" name="editTraineeHDN" value="True">
              <button class="btn btn-primary">Save</button>
              &nbsp;
              <button class="btn btn-default">Cancel</button>
            </div>
          </div>
        </div>
              	</cfcase>
                <cfcase value="View">
                
                </cfcase>
            </cfswitch>          
        
      </div>
      
    </form>
          </div>

          <div class="tab-pane" id="rotations">
            
            <div class="follower-list">
              
              <div class="media">
                <div class="media-body">
                  <h3 class="follower-name">New Rotation from </h3>
                  <div class="profile-location"><i class="fa fa-map-marker"></i> </div>
                  <div class="profile-position"><i class="fa fa-briefcase"></i> </div>
                  
                  <div class="mb20"></div>
                  
                  <button class="btn btn-sm btn-success mr5"><i class="fa fa-user"></i> Edit Rotation</button>
                </div>
              </div><!-- media -->

              
            </div><!--follower-list -->
            
          </div>
			<div class="tab-pane" id="degrees">
            
            <div class="follower-list">
              

              <div class="media">
                <div class="media-body">
	<div class="col-md-12">
          <div class="table-responsive">
          <table class="table mb30">
            <thead>
              <tr>
                <th></th>
                <th>Anticipated</th>
                <th>Date</th>
                <th>Actual</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <cfloop query="viewDegrees">
              <tr>
                <td><cfoutput>#ID#</cfoutput></td>
                <td><cfoutput>#anticdegree#</cfoutput></td>
                <td><cfoutput><cfif IsDate(#anticdate#)>#DatePart("m",anticdate)#-#DatePart("d",anticdate)#-#DatePart("yyyy",anticdate)#</cfif></cfoutput></td>
                <td><cfoutput>#actualdegree#</cfoutput></td>
                <td class="table-action">
                  <a href=""><i class="fa fa-pencil"></i></a>
                </td>
              </tr>
              </cfloop>
            </tbody>
          </table>
          </div><!-- table-responsive -->
        </div>
                </div>
              </div><!-- media -->

              
            </div><!--follower-list -->
            
          </div>
        </div><!-- tab-content -->
          
        </div><!-- col-sm-9 -->
      </div><!-- row -->
      
    </div>
        <!-- content dynamic -->
    
    <!-- contentpanel -->
    
  </div>
  <!-- mainpanel end -->
  
  <!-- rightpanel -->
  
  
</section>

<script src="../../js/jquery-1.10.2.min.js"></script>
<script src="../../js/jquery-migrate-1.2.1.min.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<script src="../../js/modernizr.min.js"></script>
<script src="../../js/jquery.sparkline.min.js"></script>
<script src="../../js/toggles.min.js"></script>
<script src="../../js/retina.min.js"></script>
<script src="../../js/jquery.cookies.js"></script>

<script src="../../js/jquery-ui-1.10.3.min.js"></script>
<script src="../../js/chosen.jquery.min.js"></script>

<script src="../../js/jquery.validate.min.js"></script>
<script src="../../js/jquery.maskedinput.min.js"></script>
<script src="../../js/jquery.gritter.min.js"></script>

<script src="../../js/custom.js"></script>

<script>
// Form validation
jQuery(document).ready(function(){ 

$.validator.setDefaults({ ignore: ":hidden:not(select)"})
  jQuery("#addTrainee").validate({
	  rules: {
		 "FirstName": {
         required: true,
         minlength: 2,
     },
		 "LastName": {
         required: true,
         minlength: 2,
     },
		 "EmailPreferred": {
         required: true,
         email: true,
     } 	 
	 	  
	  },

	messages: {
    "FirstName": {
         required: "This Field is required",
         minlength: "This field must contain at least {0} characters",
     },
    "LastName": {
         required: "This Field is required",
         minlength: "This field must contain at least {0} characters",
     },
    "EmailPreferred": {
         required: "This Field is required",
         email: "This field must contain a valid email",
     }		 	 
}
	
  });
 	  	
});

    function showError(errTitle,errMessage) {

	 return false;
	 };
</script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
	
    });
</script>

<cfif IsDefined("Session.NewTraineeAdded") AND #Session.NewTraineeAdded# EQ "Yes">
	<cfset Session.NewTraineeAdded="No">
    <cfoutput>
    <script>
    jQuery(document).ready(function() {
	 jQuery.gritter.add({
		title: 'New Trainee Added',
		text: 'Trainee record <cfoutput>#Session.TraineeID#</cfoutput> was successfully added',
      class_name: 'growl-primary',
      image: '../../images/screen.png',
		sticky: false,
		time: ''
	 });
	 return false;
	 });
	 </script>
    </cfoutput>
</cfif>

<cfif IsDefined("Session.TraineeRecordEdit") AND #Session.TraineeRecordEdit# EQ "Yes">
	<cfset Session.TraineeRecordEdit="No">
    <cfoutput>
    <script>
    jQuery(document).ready(function() {
	 jQuery.gritter.add({
		title: 'Trainee Record Updated',
		text: 'Trainee record <cfoutput>#Session.TraineeID#</cfoutput> was successfully updated',
      class_name: 'growl-primary',
      image: '../../images/screen.png',
		sticky: false,
		time: ''
	 });
	 return false;
	 });
	 </script>
    </cfoutput>
</cfif>
</body>
</html>
