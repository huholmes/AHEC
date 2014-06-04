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

<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'Add Field Experience Site'>
    <cfset This.Icon = 'fa fa-plus'>
<!--Set up Page Variables for Navigation include-->    
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
<!--Add Record on validation-->
<cfif IsDefined("FORM.addSiteHDN") AND FORM.addSiteHDN EQ "True">
  
    <cfquery name="getCenter" datasource="#datasource2#">
		SELECT C.id as centerid
        FROM dbo.Centers C 
		LEFT JOIN Cities CT ON CT.regionalcenter = C.center_abbrev
        WHERE CT.City='#Form.City#'
    </cfquery>    
    
  <!--Add Basic Record Fields-->
  <cfquery datasource="#datasource2#">   
    INSERT INTO dbo.Sites (status, SiteName, ContactPerson, SiteEmail, Website, GeocodeLink, Center, SiteType, FedPcHPSA, FedMentHPSA, FedDentHPSA, FedMUA, FedRural, AzMUA, AzRural, PCoffer, Notes, CreatedBy, LastEditedBy, DateCreated, DateUpdated, FedPcHPSA_DV, FedMentHPSA_DV, FedDentHPSA_DV, FedMUA_DV, FedRural_DV, PCoffer_DV)
VALUES (<cfif IsDefined("FORM.status")>
1
<cfelse>
0
</cfif>
, <cfif IsDefined("FORM.SiteName") AND #FORM.SiteName# NEQ "">
<cfqueryparam value="#FORM.SiteName#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.ContactPerson") AND #FORM.ContactPerson# NEQ "">
<cfqueryparam value="#FORM.ContactPerson#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.SiteEmail") AND #FORM.SiteEmail# NEQ "">
<cfqueryparam value="#FORM.SiteEmail#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Website") AND #FORM.Website# NEQ "">
<cfqueryparam value="#FORM.Website#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
'No Website Avaliable'
</cfif>
, <cfif IsDefined("FORM.GeocodeLink") AND #FORM.GeocodeLink# NEQ "">
<cfqueryparam value="#FORM.GeocodeLink#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
,'#getCenter.centerid#'
, <cfif IsDefined("FORM.SiteType") AND #FORM.SiteType# NEQ "">
<cfqueryparam value="#FORM.SiteType#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.FedPcHPSA") AND #FORM.FedPcHPSA# NEQ "">
<cfqueryparam value="#FORM.FedPcHPSA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.FedMentHPSA") AND #FORM.FedMentHPSA# NEQ "">
<cfqueryparam value="#FORM.FedMentHPSA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.FedDentHPSA") AND #FORM.FedDentHPSA# NEQ "">
<cfqueryparam value="#FORM.FedDentHPSA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.FedMUA") AND #FORM.FedMUA# NEQ "">
<cfqueryparam value="#FORM.FedMUA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.FedRural") AND #FORM.FedRural# NEQ "">
<cfqueryparam value="#FORM.FedRural#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.AzMUA") AND #FORM.AzMUA# NEQ "">
<cfqueryparam value="#FORM.AzMUA#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.AzRural") AND #FORM.AzRural# NEQ "">
<cfqueryparam value="#FORM.AzRural#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.PCoffer") AND #FORM.PCoffer# NEQ "">
<cfqueryparam value="#FORM.PCoffer#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Notes") AND #FORM.Notes# NEQ "">
<cfqueryparam value="#FORM.Notes#" cfsqltype="cf_sql_clob" maxlength="4000">
<cfelse>
''
</cfif>
, <cfqueryparam value="#Session.UserID#" cfsqltype="cf_sql_clob" maxlength="50">
, <cfqueryparam value="#Session.UserID#" cfsqltype="cf_sql_clob" maxlength="50">
, DEFAULT
, DEFAULT
, <cfif IsDefined("FORM.FedPcHPSA_DV") AND #FORM.FedPcHPSA_DV# NEQ "">
<cfqueryparam value="#FORM.FedPcHPSA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.FedMentHPSA_DV") AND #FORM.FedMentHPSA_DV# NEQ "">
<cfqueryparam value="#FORM.FedMentHPSA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.FedDentHPSA_DV") AND #FORM.FedDentHPSA_DV# NEQ "">
<cfqueryparam value="#FORM.FedDentHPSA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.FedMUA_DV") AND #FORM.FedMUA_DV# NEQ "">
<cfqueryparam value="#FORM.FedMUA_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.FedRural_DV") AND #FORM.FedRural_DV# NEQ "">
<cfqueryparam value="#FORM.FedRural_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.PCoffer_DV") AND #FORM.PCoffer_DV# NEQ "">
<cfqueryparam value="#FORM.PCoffer_DV#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
)
  </cfquery>
  <!--Get Site ID-->
	
    <cfquery name="GetSiteID" datasource="#datasource2#">
    	SELECT max(ID) as SiteID FROM dbo.Sites
	</cfquery> 
    
    <cfset This.ID = '#GetSiteID.SiteID#'>
 <!--Add Partners-->
    <cfloop index="Partner" list="#FORM.SitePartners#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.SitesPartners (SiteID,PartnerID)
        VALUES (#This.ID#, #Partner#)
        </cfquery> 
     </cfloop> 
 <!--Add Populations-->
    <cfloop index="Populations" list="#FORM.SitePopulations#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.SitesPopulations (SiteID,PopulationID)
        VALUES (#This.ID#, #Populations#)
        </cfquery> 
     </cfloop>  
 <!--Add Phone-->
    <cfquery datasource="#datasource2#">   
        INSERT INTO dbo.Phones (PhoneType,TypeID,OfficePhone,AlternatePhone)
    VALUES ('Site',#This.ID#,<cfif IsDefined("FORM.OfficePhone") AND #FORM.OfficePhone# NEQ "">
<cfqueryparam value="#FORM.OfficePhone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.AlternatePhone") AND #FORM.AlternatePhone# NEQ "">
<cfqueryparam value="#FORM.AlternatePhone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>)
    </cfquery> 
  <!--Add Address-->
    <cfquery datasource="#datasource2#">   
        INSERT INTO dbo.Addresses (AddressType,TypeID,Address1,Address2,City,County,State,Country,Zip,PrimaryAddress)
    VALUES ('Site',#This.ID#,<cfif IsDefined("FORM.Address1") AND #FORM.Address1# NEQ "">
<cfqueryparam value="#FORM.Address1#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Address2") AND #FORM.Address2# NEQ "">
<cfqueryparam value="#FORM.Address2#" cfsqltype="cf_sql_clob" maxlength="250">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.City") AND #FORM.City# NEQ "">
<cfqueryparam value="#FORM.City#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.County") AND #FORM.County# NEQ "">
<cfqueryparam value="#FORM.County#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.State") AND #FORM.State# NEQ "">
<cfqueryparam value="#FORM.State#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Country") AND #FORM.Country# NEQ "">
<cfqueryparam value="#FORM.Country#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Zip") AND #FORM.Zip# NEQ "">
<cfqueryparam value="#FORM.Zip#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
,1
)
  </cfquery>
  <cfset Session.NewSiteAdded="Yes">
  <cfset Session.SiteMode="V">
  
  <cflocation url="aSite.cfm" addtoken="no">
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Ashar Babar Concepts">
<link rel="shortcut icon" href="../../images/favicon.ico" type="image/png">
<title>AZAHEC Admin - Add Field Experience Site</title>
<link href="../../css/style.default.css" rel="stylesheet">
  
<link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
var geocoder;
var map;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(-34.397, 150.644);
  var mapOptions = {
    zoom: 8,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

function codeAddress() {
  var address = document.getElementById('address').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
<style type="text/css">
      #panel {
        position: absolute;
        top: 5px;
        left: 50%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999; }
	#map-canvas {
        height: 500px;
        margin: 0px;
        padding: 0p		
      }
</style>
</head>

<body>


<!--UA Web Banner -->
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark blue-grad"> <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
<p>The University of Arizona</p>
  </a> </div>
<section> 
  
  <!-- leftpanel -->
  <cfinclude template="../../includes/leftpanel.cfm">
  <!-- leftpanel --> 
  
  <!-- mainpanel start -->
  <div class="mainpanel"> 
    
    <!-- header -->
    <cfinclude template="../../includes/header.cfm" >
    <!-- header --> 
    
    <!-- content dynamic -->
    <div class="contentpanel">
    <form class="form-horizontal form-bordered" id="addSite" method="Post">
      
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Add Field Experience Site</h4>
          <p>Please use this form to add new a new field experience site. Make sure to fill out all the required fields.</p>
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
  </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel end -->
  <!-- Modal for GeoCoding -->
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true" style="display: none;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">X</button>
            <h4 class="modal-title">Add GeoCode Tag</h4>
        </div>
        <div class="modal-body">
        
            <div id="panel">
              <input id="address" type="textbox" value="">
              <input type="button" value="Geocode" onclick="codeAddress()">
            </div>
            <div id="map-canvas"></div>
        </div>
    </div>
  </div>
</div>
  <!-- Modal for End of Completion -->
  <div class="modal fade" id="exitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title" id="myModalLabel">Record Successfully added</h4>
      </div>
      <div class="modal-body">
        Site record <cfoutput>#This.ID#</cfoutput> was successfully added
      </div>
      <div class="modal-footer">
        <a class="btn btn-primary" href="vSite.cfm?id=#this.ID#">View Added Record</a>
        <a class="btn btn-primary" href="aSite.cfm">Add New Record</a>
        
        <a class="btn btn-default pull-left" href="../hpSites.cfm">Back to Sites</a>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div>
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
  jQuery("#addSite").validate({
    highlight: function(element) {
      jQuery(element).closest('.reqd').removeClass('has-success').addClass('has-error');
    },
    success: function(element) {
      jQuery(element).closest('.reqd').removeClass('has-error');
	  jQuery(element).closest('label').remove();
    },
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
},

  });
 	  	
});

</script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
	
    });
</script>

<cfif IsDefined("Session.NewSiteAdded") AND #Session.NewSiteAdded# EQ "Yes">
	<cfset Session.NewSiteAdded = "No">
	<cfoutput>
	   <script type="text/javascript">
       jQuery(document).ready(function() {
       $( '#exitModal' ).modal('show');
		});
       </script>
   </cfoutput> 
</cfif>
<p>&nbsp;</p>
</body>
</html>
