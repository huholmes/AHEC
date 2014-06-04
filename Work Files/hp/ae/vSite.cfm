<cfset pageName = listFirst(listLast(CGI.ScriptName, '/'), '?')>
<cfinclude template="../../connection/connection.cfc">
<!--Check if User has been authenticated-->
<!--Check if User want to log off-->
<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="../../signin.cfm" addtoken="NO" >
</cfif>
<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'View Field Experience Site'>
    <cfset This.Icon = 'fa fa-plus'>
    
    <cfset This.CurrentLevel = '2'>
    <cfset This.HostName = '#cgi.script_name#'>
    <cfset This.ActiveFolder = 'hp'>
    <cfset This.ActiveSubFolder = 'hpSites'>

<!--Database Calls-->
    <cfquery name="rSiteTypes" datasource="#datasource2#">
        SELECT * FROM SiteTypes ORDER BY ID ASC
    </cfquery>
    
    <cfquery name="rPartners" datasource="#datasource2#">
        SELECT * FROM Partners ORDER BY ID ASC
    </cfquery>
    
    <cfquery name="rPopulations" datasource="#datasource2#">
        SELECT * FROM Populations ORDER BY ID ASC
    </cfquery>                                          

    <cfquery name="rCities" datasource="#datasource2#">
        SELECT * FROM Cities ORDER BY ID ASC
    </cfquery>  
    
<!--Fetch Record-->
<cfif StructKeyExists(url,'id')>
      <cfset Session.SiteID="#url.id#"> 
<cfelse>
	<cfset Session.SiteID="1">    	   
</cfif>
  <!--Database Call for Viewing Site/ After Session Site ID has been set-->
      <cfstoredproc procedure="dbo.viewSite" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@SiteID" value="#Session.SiteID#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewSite" resultset="1">
      </cfstoredproc>
    
    <cfquery name="viewDegrees" datasource="#datasource2#">
        SELECT * FROM Degrees where TraineeId ='#Session.SiteID#'
    </cfquery>
    
        <cfquery name="trainees" datasource="#datasource2#">
        SELECT * FROM Trainees
    </cfquery>
<!--set default mode/failsafe-->    
<cfset Session.SiteMode="v"> 
<cfset title = 'View Field Experience Site'>
<!--check if mode has been changed to edit-->
<cfif StructKeyExists(url,'m') and #url.m# eq "e">
  <cfset Session.SiteMode="e"> 
</cfif>
<!--set page variables incase mode was changed-->  
<cfswitch expression='#Session.SiteMode#'>
        <cfcase value="v">
                <cfset mode='View'>
                <cfset title='View Field Experience Site'>
        </cfcase>
        <cfcase value="e">
                <cfset mode='Edit'>
                <cfset title='Edit Field Experience Site'>
        </cfcase>
        <cfdefaultcase>
                <cfset mode='View'>
                <cfset title='View Field Experience Site'>
        </cfdefaultcase>
    </cfswitch>
<!--update record on validation-->
<cfif IsDefined("FORM.editSiteHDN") AND FORM.editTraineeHDN EQ "True">
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
, LastEditedBy='#SESSION.UserID#', DateUpdated=DEFAULT WHERE ID='#Session.SiteID#'
  </cfquery>
  
      <cfset Session.SiteRecordEdit="Yes">
      <cfset Session.SiteMode="V">
      <cflocation url = "?id=#Session.SiteID#" addtoken="no">
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
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark blue-grad">
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
          <ul class="profile-social-list">
            <a href="?p=t" class="btn btn-primary mb20 w100"><i class="fa fa-download"></i> Print Report</a><br>
            <a href="?m=e" class="btn btn-success mb10 w100"><i class="fa fa-pencil"></i> Edit Site</a><br>
            <button class="btn btn-white mb5 w100"><i class="fa fa-plus-circle"></i> Add Address</button><br>
            <button class="btn btn-white mb5 w100"><i class="fa fa-plus-circle"></i> Add Phone Number</button><br>
          </ul>
          
          <div class="mb30"></div>
          
        </div><!-- col-sm-3 -->
        <div class="col-sm-9">
          
          <div class="profile-header">
            <h2 class="profile-name"><cfoutput>#viewSite.SiteName#</cfoutput></h2>


            <p><i class="fa fa-tags"></i> Site ID: <strong><cfoutput>#viewSite.ID#</cfoutput></strong></p>
            <p><i class="fa fa-pencil-square-o"></i> Last Edited by: <strong><cfoutput>#viewSite.LastEditedBy# on #viewSite.DateUpdated#</cfoutput></strong></p>

            <div class="panel-body">
          
          <div class="tinystat mr20">
            <div id="sparkline" class="chart mt5"><canvas width="44" height="30" style="display: inline-block; width: 44px; height: 30px; vertical-align: top;"></canvas></div>
            <div class="datainfo">
              <span class="text-muted">Total Trainees</span>
              <h4>1,205</h4>
            </div>
          </div><!-- tinystat -->
              
          <div class="tinystat mr20">
            <div id="sparkline2" class="chart mt5"><canvas width="50" height="33" style="display: inline-block; width: 50px; height: 33px; vertical-align: top;"></canvas></div>
            <div class="datainfo">
              <span class="text-muted">Total Experiences</span>
              <h4>501</h4>
            </div>
          </div><!-- tinystat -->

              
        </div>
            <div class="mb5"></div>

          </div><!-- profile-header -->
          
          <!-- Nav tabs -->
        <ul class="nav nav-tabs nav-dark">
          <li class="active"><a href="#profile" data-toggle="tab"><strong>Profile</strong></a></li>
          <li><a href="#rotations" data-toggle="tab"><strong>Current Experiences</strong></a></li>
          <li><a href="#degrees" data-toggle="tab"><strong>Address/Phone</strong></a></li>
          <li><a href="#map" data-toggle="tab"><strong>Map</strong></a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
          <div class="tab-pane active" id="profile">
            <!-- activity-list -->
<!-- form goes here -->
<form class="form-horizontal form-bordered" id="addSite" method="Post">
      
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title"><cfoutput>#title#</cfoutput></h4>
        </div>
		
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
              <div class="reqd">
                <label class="col-sm-2 control-label">Status <span class="asterisk">*</span></label>
                <div class="col-sm-4">
                  <div class="rdio rdio-primary">
                    <input type="radio" name="status" value="1" id="statusActive" checked="checked">
                    <label for="statusActive">Active</label>
                  </div>
                  <div class="rdio rdio-primary">
                    <input type="radio" name="status" value="0" id="statusInActive" disabled>
                    <label for="statusInActive">Inactive</label>
                  </div>
                </div>
              </div>
          </div>
          <div class="form-group">
              <div class="reqd">
                <label class="col-sm-2 control-label">Site Name <span class="asterisk">*</span></label>
                <div class="col-sm-4">
                  <input type="text" placeholder="Enter Site Name" class="form-control" name="SiteName" required>
                </div>
              </div>
          </div>

        </div>        
      </div>  

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Contact Information</h4>
        </div>
		
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Contact Person</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Enter Contact Person" class="form-control" name="ContactPerson">
            </div>
          </div>
          <div class="form-group">
          <div class="reqd">
              <label class="col-sm-2 control-label">Office Phone <span class="asterisk">*</span></label>
                <div class="col-sm-4">
                  <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                    <input type="text" placeholder="Office Number" id="OfficePhone" name="OfficePhone" class="form-control" required>
                  </div>
                  <label class="error" for="OfficePhone"></label>
                </div>
                
          </div>
            <label class="col-sm-2 control-label">Alternate Phone</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" placeholder="Alternate Number" id="AlternatePhone" name="AlternatePhone" class="form-control">
              </div>              
            </div>
          </div>
		<div class="form-group">
            <label class="col-sm-2 control-label">Site Email</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" placeholder="Office Email" id="SiteEmail" name="SiteEmail" class="form-control">
              </div>
            </div>
            <div class="reqd">
            <label class="col-sm-2 control-label">Site Website </label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-globe"></i></span>
                <input type="text" placeholder="Site Website Address" id="Website" name="Website" class="form-control">
              </div> 
              <span class="help-block">* Leave blank if No Website Avaliable</span>
        
            </div>
          </div>  
          </div>          
		
                  
        </div>
        <!-- panel-body --> 
        
      </div>
      <div class="panel panel-default">
                          <div class="panel-heading panel-heading">
                            <h4 class="panel-title">Site Address</h4>
                          </div>
                          <div class="panel-body  panel-body-nopadding"> 
                            
                            <div class="form-group">
                            <div class="reqd">
                              <label class="col-sm-2 control-label">Street Address 1 <span class="asterisk">*</span></label>
                              <div class="col-sm-4">
                                <input type="text" placeholder="Street Address 1" class="form-control"  name="Address1" required>
                              </div>
                              </div>
                              <label class="col-sm-2 control-label">Street Address 2</label>
                              <div class="col-sm-4">
                                <input type="text" placeholder="Street Address 2" class="form-control"  name="Address2">
                              </div>
                            </div>
                            <div class="form-group">
                            <div class="reqd">
                              <label class="col-sm-2 control-label">City <span class="asterisk">*</span></label>
                              <div class="col-sm-4">
                                  <select class="form-control" data-placeholder="Choose a City..." name="City" required>
                                      <option value="">Choose a City...</option>
                                    <cfoutput query="rCities">
                                       <option value="#City#">#City#</option>
                                    </cfoutput>
                                  </select>                                
                              </div>
                             </div> 
                              <label class="col-sm-2 control-label">County </label>
                              <div class="col-sm-4">
                                <input type="text" placeholder="County" class="form-control"  name="County">
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="col-sm-2 control-label">State <span class="asterisk">*</span></label>
                              <div class="col-sm-4">
                                <select class="form-control" name="state" id="state" required>
                                  <option value="AZ">Arizona</option>
                                  <option value="">-----------</option>
                                </select>
                              </div>
                              
                              <label class="col-sm-2 control-label">Country/Zip <span class="asterisk">*</span></label>
                              <div class="col-sm-3">
                                <input type="text" placeholder="Country" class="form-control" value="United States of America"  name="Country">
                              </div>

                              <div class="col-sm-1 reqd">
                                <input type="text" placeholder="Zip Code" class="form-control"  name="Zip" required>
                              </div>
                            </div>
                            
                        <div class="form-group">
                            <label class="col-sm-2 control-label">GeoCode Tag</label>
                            <div class="col-sm-4">
                              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
                                <input type="text" placeholder="Geo Code" id="GeoCodeLink" name="GeoCodeLink" data-toggle="modal" data-target=".bs-example-modal-lg" class="form-control">
                              </div>
                            </div>
                          
                          </div> 
                                                     
                          </div>
      </div>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Site Characteristics</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
          <div class="reqd">
            <label class="col-sm-2 control-label">Site Type <span class="asterisk">*</span></label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose a Site Type..." name="SiteType" required>
                  <option value="">Choose a Site Type...</option>
                <cfoutput query="rSiteTypes">
                   <option value="#ID#">#SiteType#</option>
                </cfoutput>
              </select>
            </div>
            </div>
		</div>
          <div class="form-group">  
          <div class="reqd" >      
            <label class="col-sm-2 control-label">Site's Partners/Consortia <span class="asterisk">*</span></label>
            <div class="col-sm-6">
              <select class="form-control chosen-select" multiple data-placeholder="Choose Site's Partners/Consortia..." name="SitePartners" required>
                <option value=""></option>
                <cfoutput query="rPartners">
                    <option value="#ID#">#Partner#</option>
                </cfoutput>
              </select>
              <label class="error" for="SitePartners"></label>
            </div>
          </div>
          </div>
          
          <div class="form-group">
          <div class="reqd">
            <label class="col-sm-2 control-label">Vunerable Populations Served <span class="asterisk">*</span></label>
            <div class="col-sm-6">
              <select class="form-control chosen-select" multiple data-placeholder="Choose Vunerable Populations Served..." name="SitePopulations" required>
                <option value=""></option>
                <cfoutput query="rPopulations">
                    <option value="#ID#">#Population#</option>
                </cfoutput>
              </select>
              <label class="error" for="SitePopulations"></label>
            </div>
          </div>
           </div>         
        </div>
        <!-- panel-body --> 
        
      </div>
<div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Notes</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Notes </label>
            <div class="col-sm-10">
				<textarea class="form-control" name="notes" rows="3"></textarea>
            </div>
		</div>
                    
        </div>
        <!-- panel-body --> 
        
      </div>
<!--Program Office Use Only-->
<div class="panel panel-default">

        <div class="panel-heading">
          <h4 class="panel-title">Program Office Use Only</h4>
          		<div class="panel-btns">
                <a href="" class="minimize">−</a>
		</div>
        </div>

        <div class="panel-body panel-body-nopadding">

		<!-- FedPcHPSA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Primary Care HPSA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedPcHPSA" value="Yes" id="FedPcHPSAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedPcHPSA" value="No" id="FedPcHPSANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedPcHPSA_DV" required disabled>
            </div>
          </div>
          <!-- FedMentHPSA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Mental Care HPSA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMentHPSA" value="Yes" id="FedMentHPSAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMentHPSA" value="No" id="FedMentHPSANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedMentHPSA_DV" required disabled>
            </div>
          </div>          
          <!-- FedDentHPSA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Dental Care HPSA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedDentHPSA" value="Yes" id="FedDentHPSAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedDentHPSA" value="No" id="FedDentHPSANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedDentHPSA_DV" required disabled>
            </div>
          </div>           
          <!-- FedMUA --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal MUA/P <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMUA" value="Yes" id="FedMUAYes"disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedMUA" value="No" id="FedMUANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedMUA_DV" required disabled> 
            </div>
          </div>           
          <!-- FedRural --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Federal Rural Designation <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="FedRural" value="Yes" id="FedRuralYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="FedRural" value="No" id="FedRuralNo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="FedRural_DV" required disabled>
            </div>
          </div>           
          <!-- AzMUA -->
          <div class="form-group">
            <label class="col-sm-3 control-label">Arizona MUA <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="AzMUA" value="Yes" id="AzMUAYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="AzMUA" value="No" id="AzMUANo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="SiteName" required disabled>
            </div>
          </div>            
          <!-- AzRural --> 
          <div class="form-group">
            <label class="col-sm-3 control-label">Arizona Rural Designation <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="AzRural" value="Yes" id="AzRuralYes"  disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="AzRural" value="No" id="AzRuralNo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="AzRural_DV" required disabled>
            </div>
          </div>           
          <!-- PCoffer -->
          <div class="form-group">
            <label class="col-sm-3 control-label">Primary Care Offered <span class="asterisk">*</span></label>
            <div class="col-sm-3">
              <div class="rdio rdio-primary">
                <input type="radio" name="PCoffer" value="Yes" id="PCofferYes" disabled>
                <label for="statusActive">Yes</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="PCoffer" value="No" id="PCofferNo" checked="checked">
                <label for="statusInActive">No</label>
              </div>
            </div>

            <label class="col-sm-2 control-label">Date Verified</label>
            <div class="col-sm-4">
              <input type="text" placeholder="Verification Date" class="form-control" name="PCoffer_DV" required disabled>
            </div>
          </div> 
            
            
		</div>
                    
      </div>
        <!-- panel-body --> 
      <div class="panel-footer">
          <div class="row">
            <div class="col-sm-12">
              <input type="hidden" name="addSiteHDN" value="True">
              <button class="btn btn-primary ">Submit</button>
              &nbsp;
              <button class="btn btn-default" type="reset">Reset</button>
            </div>
          </div>
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

<cfif IsDefined("Session.NewSiteAdded") AND #Session.NewSiteAdded# EQ "Yes">
	<cfset Session.NewSiteAdded="No">
    <cfoutput>
    <script>
    jQuery(document).ready(function() {
	 jQuery.gritter.add({
		title: 'New Site Added',
		text: 'Site record <cfoutput>#Session.SiteID#</cfoutput> was successfully added',
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

<cfif IsDefined("Session.SiteRecordEdit") AND #Session.SiteRecordEdit# EQ "Yes">
	<cfset Session.SiteRecordEdit="No">
    <cfoutput>
    <script>
    jQuery(document).ready(function() {
	 jQuery.gritter.add({
		title: 'Site Record Updated',
		text: 'Site record <cfoutput>#Session.SiteID#</cfoutput> was successfully updated',
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
