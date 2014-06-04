<cfinclude template="../../connection/connection.cfc">
<!--Check if User has been authenticated-->
	
<cfif IsDefined("Session.UserID")>
<cfelse>
	<cflocation url="../../signin.cfm" addtoken="NO">
</cfif>

<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="../../signin.cfm" addtoken="NO" >
</cfif>

<cfif StructKeyExists(url,'view')>
    <cfset mode='view'>
    <cfquery name="viewStudent" datasource="#datasource#">
        SELECT * FROM tbl_college_student where id ='#url.view#'
    </cfquery>
    
    <cfquery name="viewRotations" datasource="#datasource#">
        SELECT * FROM tbl_rotations where student_id ='#url.view#'
    </cfquery>
</cfif>

	
<!--Set Up page level, will be used to determine Forwarding Links-->    
	<cfset This.PageCode = 'hpstudents'>
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
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark red-grad">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>



<section>
  
    <!-- leftpanel -->
  	<cfinclude template="../../includes/leftpanelnondynamic.cfm">
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
            <button class="btn btn-success mb5 w100"><i class="fa fa-pencil"></i> Edit Student</button><br>
            <button class="btn btn-white w100"><i class="fa fa-plus-circle"></i> Add Rotation</button>
          </ul>
          
          <div class="mb30"></div>
          
        </div><!-- col-sm-3 -->
        <div class="col-sm-9">
          
          <div class="profile-header">
            <h2 class="profile-name"><cfoutput>#viewStudent.fname# #viewStudent.lname#</cfoutput></h2>
            <div class="profile-location"><i class="fa fa-map-marker"></i> <cfoutput>#viewStudent.center_id#</cfoutput></div>
            
            <div class="mb20"></div>

          </div><!-- profile-header -->
          
          <!-- Nav tabs -->
        <ul class="nav nav-tabs nav-justified nav-profile">
          <li class="active"><a href="#profile" data-toggle="tab"><strong>Profile</strong></a></li>
          <li><a href="#rotations" data-toggle="tab"><strong>Rotations</strong></a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
          <div class="tab-pane active" id="profile">
            <!-- activity-list -->
<form class="form-horizontal form-bordered">
            
            <div class="form-group">
              <label class="col-sm-2 control-label">First Name</label>
              <div class="col-sm-4">
                <label class="control-label"><strong><cfoutput>#viewStudent.fname#</cfoutput></strong></label>
              </div>

              <label class="col-sm-2 control-label">Last Name</label>
              <div class="col-sm-4">
                <label class="col-sm-2 control-label"><strong><cfoutput>#viewStudent.lname#</cfoutput></strong></label>
              </div>
            </div>
            
            <div class="form-group">
				  <label class="col-sm-2 control-label" for="Gender">Gender</label>
                  <div class="col-sm-4">
                    <label class="col-sm-2 control-label"><strong><cfoutput>#viewStudent.gender#</cfoutput></strong></label>
                  </div>

				  <label class="col-sm-2 control-label" for="Ethnicity">Ethnicity(Hispanic or Latino)</label>
              <div class="col-sm-4">
                <label class="col-sm-2 control-label"><strong><cfoutput>#viewStudent.ethnicity#</cfoutput></strong></label>
              </div>
				</div>
                
				<div class="form-group">
              <label class="col-sm-2 control-label">Race</label>
              <div class="col-sm-4">
                <label class="col-sm-2 control-label"><strong><cfoutput>#viewStudent.ethnicity#</cfoutput></strong></label>
              </div>
            </div>                
			     
			<div class="form-group">
				  <label class="col-sm-2 control-label" for="AgeRange">Age Range</label>
				  <div class="col-sm-6">
					 <div class="rdio rdio-primary">
                        <input type="radio" name="radio3" value="0" id="radioPrimary31">
                        <label for="radioPrimary31">Under 20</label>
                      </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="radio3" value="0" id="radioPrimary32">
                        <label for="radioPrimary32">20-29</label>
                      </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="radio3" value="0" id="radioPrimary33">
                        <label for="radioPrimary33">30-39</label>
                      </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="radio3" value="0" id="radioPrimary34">
                        <label for="radioPrimary34">40-49</label>
                      </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="radio3" value="0" id="radioPrimary35">
                        <label for="radioPrimary35">50-59</label>
                      </div>
				  </div>
				</div>  
                
				<div class="form-group">
                      <label class="col-sm-2 control-label" for="DateofBirth">Date of Birth</label>
                      <div class="col-sm-3">
                        <input type="text" class="form-control" placeholder="mm/dd/yyyy" id="datepicker">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                      </div>
				</div> 
                
                
			<div class="form-group">
				  <label class="col-sm-2 control-label" for="AgeRange">Support</label>
					<div class="col-sm-6">
                      <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="checkboxDefault1" />
                        <label for="checkboxDefault1">Housing</label>
                      </div>
                      
                      <div class="ckbox ckbox-primary">
                        <input type="checkbox" value="1" id="checkboxDefault2" />
                        <label for="checkboxDefault2">Transportation</label>
                      </div>
                      
                      <div class="ckbox ckbox-primary">
                        <input type="checkbox" id="checkboxDefault3"  />
                        <label for="checkboxDefault3">Living Stipend</label>
                      </div>
                      
                      <div class="ckbox ckbox-primary">
                        <input type="checkbox" id="checkboxDefault4" />
                        <label for="checkboxDefault4">Other</label>
                      </div>
                      
                      <div class="ckbox ckbox-primary">
                        <input type="checkbox" id="checkboxDefault5" />
                        <label for="checkboxDefault5">Not Specified</label>
                      </div>

                  
                </div>
				</div>                         
          </form>
          </div>
          <div class="tab-pane" id="rotations">
            
            <div class="follower-list">
              
              <cfloop query="viewRotations">
              <div class="media">
                <div class="media-body">
                  <h3 class="follower-name">New Rotation from <cfoutput>#startdate# to #enddate#</cfoutput></h3>
                  <div class="profile-location"><i class="fa fa-map-marker"></i> <cfoutput>#preceptor_id#</cfoutput></div>
                  <div class="profile-position"><i class="fa fa-briefcase"></i> <cfoutput>#site_num#</cfoutput></div>
                  
                  <div class="mb20"></div>
                  
                  <button class="btn btn-sm btn-success mr5"><i class="fa fa-user"></i> Edit Rotation</button>
                </div>
              </div><!-- media -->
			</cfloop>
              
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

<script src="../../js/custom.js"></script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
	  // Date Picker
	  jQuery('#datepicker').datepicker();
	  
	  jQuery('#datepicker-inline').datepicker();
	  
	  jQuery('#datepicker-multiple').datepicker({
		numberOfMonths: 3,
		showButtonPanel: true
  });
		
    });
</script>

</body>
</html>
