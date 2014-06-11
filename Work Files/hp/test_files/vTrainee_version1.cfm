<cfset pageName = listFirst(listLast(CGI.ScriptName, '/'), '?')>
<cfinclude template="../../connection/connection.cfc">
<!--Check if User has been authenticated-->
<cfif IsDefined("Session.UserID")>
<cfelse>
	<cflocation url="../../signin.cfm" addtoken="NO">
</cfif>
<!--Check if User want to log off-->
<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="../../signin.cfm" addtoken="NO" >
</cfif>
<!--Set Up page level, will be used to determine Forwarding Links-->
<cfset This.PageName = 'View HP Trainee'>
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
       
      <cfstoredproc procedure="dbo.viewTrainee" datasource="#datasource2#">
        <cfprocparam type="IN" dbvarname="@traineeID" value="#url.id#" cfsqltype="CF_SQL_CHAR">
        
        <cfprocresult name="viewTrainee" resultset="1">
      </cfstoredproc>
    
    <cfquery name="viewDegrees" datasource="#datasource2#">
        SELECT * FROM Degrees where TraineeId ='#url.id#'
    </cfquery>
</cfif>



<cfset this.m="v">
<!--check if mode has been changed to edit-->
<cfif StructKeyExists(url,'m')>
	<cfswitch expression='#url.m#'>
        <cfcase value="v">
            	<cfset inputstyle1='disabled'>
    			<cfset inputstyle2='readonly'>
                <cfset title='View HP Trainee'>
        </cfcase>
        <cfcase value="e">
            	<cfset inputstyle1=''>
    			<cfset inputstyle2=''>
                <cfset title='Edit HP Trainee'>
        </cfcase>
    </cfswitch>
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

  <title>AZAHEC Admin - HP Students</title>

  <link href="../../css/style.default.css" rel="stylesheet">
  <link href="../../css/jquery.datatables.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">	
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->

</head>

<body>

<!-- Preloader -->
<!---<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>--->
<!--UA Web Banner -->
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgLight dark-gray-grad twenty-five">
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
          <img src="../../images/profilr.jpg" class="thumbnail img-responsive" alt="" />
          
          <div class="mb30"></div>
          <ul class="profile-social-list">
            <button class="btn btn-success mb20 w100"><i class="fa fa-pencil"></i> Edit Trainee</button><br>
            <button class="btn btn-white mb5 w100"><i class="fa fa-plus-circle"></i> Add Rotation</button><br>
            <button class="btn btn-white mb5 w100"><i class="fa fa-plus-circle"></i> Add Degree</button><br>
            <button class="btn btn-white w100"><i class="fa fa-plus-circle"></i> Add Support Info</button>
          </ul>
          
          <div class="mb30"></div>
          
        </div><!-- col-sm-3 -->
        <div class="col-sm-9">
          
          <div class="profile-header">
            <h2 class="profile-name"><cfoutput>#viewTrainee.FirstName# #viewTrainee.LastName#</cfoutput></h2>
            <div class="profile-location"><i class="fa fa-map-marker"></i> Created by: <strong><cfoutput>#viewTrainee.CreatedBy# on #viewTrainee.DateCreated#</cfoutput></strong>
            <p><i class="fa fa-map-marker"></i> Last Edited by: <strong><cfoutput>#viewTrainee.LastEditedBy# on #viewTrainee.DateUpdated#</cfoutput></strong></p>
            </div>
            
            <div class="mb10"></div>

          </div><!-- profile-header -->
          
          <!-- Nav tabs -->
        <ul class="nav nav-tabs nav-justified nav-profile">
          <li class="active"><a href="#profile" data-toggle="tab"><strong>Profile</strong></a></li>
          <li><a href="#rotations" data-toggle="tab"><strong>Rotations</strong></a></li>
          <li><a href="#degrees" data-toggle="tab"><strong>Degrees</strong></a></li>
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
              <select class="form-control" <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.Status#</cfoutput></option>
                <option value="Continuing">Continuing</option>
                <option value="Graduated">Graduated</option>
                <option value="Leave of Absense">Leave of Absense</option>
                <option value="Withdrew">Withdrew</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Last Name <span class="asterisk">*</span></label>
            <div class="col-sm-4">
              <input type="text" value="<cfoutput>#viewTrainee.LastName#</cfoutput>" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
            </div>
            <label class="col-sm-2 control-label">First Name <span class="asterisk">*</span></label>
            <div class="col-sm-4">
              <input type="text" value="<cfoutput>#viewTrainee.FirstName#</cfoutput>" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Middle Name</label>
            <div class="col-sm-4">
              <input type="text" value="<cfoutput>#viewTrainee.MiddleName#</cfoutput>" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
            </div>
            <label class="col-sm-2 control-label">Maiden Name</label>
            <div class="col-sm-4">
              <input type="text" value="<cfoutput>#viewTrainee.MaidenName#</cfoutput>" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
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
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmailPreferred#</cfoutput>" id="preferredemail" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
              </div>
            </div>
            <label class="col-sm-2 control-label">University Email</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmailUniversity#</cfoutput>" id="uniemail" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Permanent Email</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmailPermanent#</cfoutput>" id="permemail" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
              </div>
            </div>
            <label class="col-sm-2 control-label">Phone Number</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.Phone#</cfoutput>" id="phone" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Emergency Contact</label>
            <div class="col-sm-4">
              <input type="text" value="<cfoutput>#viewTrainee.EmergContactName#</cfoutput>" id="emergencycontact" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
            </div>
            <label class="col-sm-2 control-label">Emergency Phone</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.EmergContactPhone#</cfoutput>" id="emergencyphone" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
              </div>
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
              <select class="form-control chosen-select" data-placeholder="Choose an Organization..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value="#viewTrainee.InstitutionID#"><cfoutput>#viewTrainee.Institution#</cfoutput></option>
                <cfoutput query="rInstitutions">
                    <option value="#ID#">#Institution#</option>
                  </cfoutput>
              </select>
            </div>
            <label class="col-sm-2 control-label">Level</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose an Level..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value="#viewTrainee.InstitutionLevel#"><cfoutput>#viewTrainee.InstitutionLevel#</cfoutput></option>
                <option value="Vocational training">Vocational training</option>
                <option value="Undergraduate program">Undergraduate program</option>
                <option value="Graduate program">Graduate program</option>
                <option value="Fellowship">Fellowship</option>
                <option value="Residency">Residency</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Primary Discipline <span class="asterisk">*</span></label>
            <div class="col-sm-4">
              <select class="form-control chosen-select" data-placeholder="Choose an Organization..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value="#viewTrainee.Discipline#"><cfoutput>#viewTrainee.Discipline#</cfoutput></option>
                <cfoutput query="rDisciplines">
                    <option value="#ID#">#Discipline#</option>
                  </cfoutput>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Enrollment</label>
            <div class="col-sm-4">
              <select class="form-control " data-placeholder="Choose an Enrollment type..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.Enrollment#</cfoutput></option>
                <option value="PT">Part Time</option>
                <option value="FT">Full Time</option>
              </select>
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
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                <input type="text" value="<cfoutput>#viewTrainee.DOB#</cfoutput>" id="DOB" class="form-control" <cfoutput>#inputstyle2#</cfoutput>>
              </div>
            </div>
            <label class="col-sm-2 control-label">Sex <span class="asterisk">*</span></label>
            <div class="col-sm-4">
              <div class="rdio rdio-primary">
                <input type="radio" name="sex" value="Male" id="sexMale" required>
                <label for="sexMale">Male</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="sex" value="female" id="sexFemale">
                <label for="sexFemale">Female</label>
              </div>
              <label class="error" for="sex"></label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="Ethnicity">Ethnicity</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose an Ethnicity..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value="0"><cfoutput>#viewTrainee.Ethnicity#</cfoutput></option>
                <option value="Hispanic/Latino">Hispanic/Latino</option>
                <option value="Non-Hispanic/Non-Latino">Non-Hispanic/Non-Latino</option>
                <option value="Not reported">Not reported</option>
              </select>
            </div>
            <label class="col-sm-2 control-label">Race</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose a Race..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value="0"><cfoutput>#viewTrainee.Race#</cfoutput></option>
                <option value="American Indian or Alsaka Native">American Indian or Alsaka Native</option>
                <option value="Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)">Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)</option>
                <option value="Other Asian">Other Asian</option>
                <option value="Black or African American">Black or African American</option>
                <option value="Native Hawaiian/Other Pacific Islander">Native Hawaiian/Other Pacific Islander</option>
                <option value="White">White</option>
                <option value="Other(Not Reported)">Other(Not Reported)</option>
                <option value="More than one race">More than one race</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Rural Background</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose a Background..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.RuralBackground#</cfoutput></option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              <span class="help-block">Did the trainee grow up in a rural area (&lt;50,000 people)?</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Disadvantaged</label>
            <div class="col-sm-8">
              <select class="form-control" data-placeholder="Choose an Enrollment type..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.Disadvantaged#</cfoutput></option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
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
              <select class="form-control" data-placeholder="Choose a Background type..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.AZbackground#</cfoutput></option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              <span class="help-block">Did the trainee grow up in Arizona?</span> </div>
            <label class="col-sm-2 control-label">Military Status</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose an Enrollment type..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.MilitaryStatusPre#</cfoutput></option>
                <option value="Individual is not a Veteran">Individual is not a Veteran</option>
                <option value="Active duty military">Active duty military</option>
                <option value="Reservist">Reservist</option>
                <option value="Veteran - Prior Service">Veteran - Prior Service</option>
                <option value="Veteran - Retired">Veteran - Retired</option>
                <option value="Not reported">Not reported</option>
              </select>
              <span class="help-block">Military status (pre-matriculation)</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Special Housing</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose a housing type..." <cfoutput>#inputstyle1#</cfoutput>>
                <option value=""><cfoutput>#viewTrainee.Specialhousing#</cfoutput></option>
                <option value="Family">Family</option>
                <option value="Disability accommodation">Disability accommodation</option>
                <option value="Gender-specific">Gender-specific</option>
                <option value="Pets allowed">Pets allowed</option>
                <option value="Religious preference">Religious preference</option>
                <option value="Single-occupant">Single-occupant</option>
              </select>
              <span class="help-block">Special housing needs</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" <cfoutput>#inputstyle1#</cfoutput>>Notes</label>
            <div class="col-sm-10">
              <textarea class="form-control" rows="3"><cfoutput>#viewTrainee.notes#</cfoutput></textarea>
            </div>
          </div>
        </div>
        <!-- panel-body -->
        
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
                <td><cfoutput>#anticdate#</cfoutput></td>
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

<script src="../../js/custom.js"></script>

<script>
// Form validation

jQuery(document).ready(function(){ 
$.validator.setDefaults({ ignore: ":hidden:not(select)" })
  jQuery("#editTrainee").validate({
    highlight: function(element) {
      jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    },
    success: function(element) {
      jQuery(element).closest('.form-group').removeClass('has-error');
    }
  });
});


</script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
	
    });
	

</script>

</body>
</html>
