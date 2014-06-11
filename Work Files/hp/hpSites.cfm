<cfinclude template="../connection/connection.cfc">
<!--Check if User has been authenticated-->
<cfset Session.RL = "#cgi.script_name#">
<cfset User = "#checkUser()#">

<cfif StructKeyExists(url,'logoff')>
  <cfset StructClear(Session)>
  <cflocation url="../signin.cfm" addtoken="NO" >
</cfif>
<!--Set up Page Variables for Header include-->
	<cfset This.PageName = 'Field Experience Sites'>
    <cfset This.Icon = 'fa fa-building-o'>
<!--Set up Page Variables for Navigation include-->    
    <cfset This.CurrentLevel = '1'>
    <cfset This.HostName = '#cgi.script_name#'>
    <cfset This.ActiveFolder = 'hp'>
<!--Database Calls-->
    <cfquery name="rSitesTotal" datasource="#datasource2#">
        SELECT COUNT(*) as Total  
        FROM Sites 
    </cfquery>
    
     <cfquery name="rSitesAT" datasource="#datasource2#" maxrows="5">
        SELECT COUNT(*) as Total  
        FROM Sites 
        WHERE (Cast(DateCreated as DATE) = Cast(GETDATE() as DATE))
    </cfquery>  
    
     <cfquery name="rSitesActive" datasource="#datasource2#" maxrows="5">
        SELECT COUNT(*) as Total  
        FROM Sites 
        WHERE Status='1'
    </cfquery>  
    
     <cfquery name="rSitesExp" datasource="#datasource2#" maxrows="5">
        SELECT S.ID, S.SiteName, S.DateCreated
		FROM Sites S
        ORDER BY S.DateCreated DESC
    </cfquery>             
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Ashar Babar Concepts">
  <link rel="shortcut icon" href="../images/favicon.ico" type="image/png">
  

  <title>AZAHEC Admin - Health Profession Students</title>

  <link href="../css/style.default.css" rel="stylesheet">
  <link href="../css/jquery.datatables.css" rel="stylesheet">
  <link href="../css/morris.css" rel="stylesheet"> 
  <link id="fontswitch" rel="stylesheet" href="/css/font.helvetica-neue.css">
  <link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">	
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="/js/html5shiv.js"></script>
  <script src="/js/respond.min.js"></script>
  <![endif]-->

</head>

<body>

<!-- Preloader -->
<div id="preloader">
    <div id="status">
        <i class="fa fa-spinner fa-spin"></i>
    </div>
    
</div>

<div id="ua-web-branding-banner-v1" class="ua-wrapper bgLight dark-gray-grad twenty-five">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>



<section>
  <!-- leftpanel -->
  	<cfinclude template="../includes/leftpanel.cfm">
  <!-- leftpanel -->
  
  <div class="mainpanel">
    <!-- header -->
    <cfinclude template="../includes/header.cfm" >
    <!-- header -->     
    
    <div class="contentpanel">
    <div class="row">
                        
                        <!-- col-md-6 -->
                        <div class="col-md-8 mb30">
                          <div id="bar-chart" style="height: 300px; position: relative;"></div>
                        </div><!-- col-md-6 -->
                    
                    
                        <div class="col-md-4 mb30">
                          <div class="quikstat">
                          <ul>
                          <li>
                          	<div class="left">
                            	<span class="text-muted"><cfoutput>#rSitesTotal.Total#</cfoutput></span>
                          	</div>
                          	<div class="right">
                            	<span class="text-info">Total Sites</span>
                          	</div>                            
                          </li>                          
                          <li>
                          	<div class="left">
                            	<span class="text-muted"><cfoutput>#rSitesAT.Total#</cfoutput></span>
                          	</div>
                          	<div class="right">
                            	<span class="text-info">Added Today</span>
                          	</div>                            
                          </li>
                          <li>
                          	<div class="left">
                            	<span class="text-muted"><cfoutput>#rSitesActive.Total#</cfoutput></span>
                          	</div>
                          	<div class="right">
                            	<span class="text-info">Active Sites</span>
                          	</div>                            
                          </li>
                          <li>
                          	<div class="left">
                            	<span class="text-muted">00</span>
                          	</div>
                          	<div class="right">
                            	<span class="text-info">Current Experience</span>
                          	</div>                            
                          </li>                                                    
                          </ul>
                       
                          </div>
                        </div><!-- col-md-6 -->
                    </div>                    
      <div class="panel"><!-- panel-heading-->
                        <div class="panel-body">
                            <div class="btn-group mr10">
                                <a class="btn btn-primary" href="ae/aSite.cfm"><i class="fa fa-plus mr5"></i> Add New Site</a>
                                <button id="chatview" class="btn btn-primary" type="button"><i class="fa fa-search mr5"></i> Advanced Search</button>
                            </div>

                            
                            <div class="btn-group">
                                <button data-toggle="dropdown" class="btn btn-success dropdown-toggle" type="button">
                                    <i class="fa fa-arrow-circle-o-down mr5"></i> Report
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Excel</a></li>
                                </ul>
                            </div>
                            
                            <br><br>
                            
<div class="row">
            <div class="panel">
                <div class="panel-body">

 			<div class="table-responsive">
          <table class="table" id="table2">
              <thead>
                 <tr>
                    <th width="9%">ID</th>
                    <th width="35%">Site Name</th>
                    <th width="10%">Status</th>
                    <th width="21%">City</th>
                    <th width="15%">Website</th>
                    <th width="10%"></th>
                 </tr>
              </thead>
			<tbody></tbody>
           </table>
                     </div>         
        
      </div><!-- row -->
                          
                </div><!-- panel-body -->
            </div>
                            
                        </div><!-- panel-body -->
                    </div>
    </div><!-- contentpanel -->
    
  </div><!-- mainpanel -->
  
 <div class="rightpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs nav-justified">
        <li class="active"><a href="#rp-search" data-toggle="tab"><i class="fa fa-search"></i></a></li>
    </ul>
        
    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="rp-search">
            
            <h5 class="sidebartitle">Advanced Search</h5>
            <ul class="chatuserlist">
                <li>
                    <div class="media">
            <h4 class="subtitle-light mb5">Name</h4>
            <input type="text" value="Search Term" class="form-control" />
            
            <div class="mb20"></div>
            
            <h4 class="subtitle-light mb5">Profession</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Profession...">
                  <option value=""></option>
                  <option value="United States">Doctor</option>
                  <option value="United Kingdom">Burse</option>
                  <option value="Afghanistan">General Practioti...</option>
                  <option value="Aland Islands">Big Doctor</option>
                  <option value="Albania">Small Doctor</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle-light mb5">Region</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Region...">
                  <option value=""></option>
                  <option value="SEAHEC">South East AHEC</option>
                  <option value="GVAHEC">Greater Valley AHEC</option>
                  <option value="NAHEC">Northern AHEC</option>
                  <option value="EAHEC">Eastern AHEC</option>
                  <option value="WAHEC">Western AHEC</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle-light mb5">Email</h4>
            <input type="text" value="Email Address" class="form-control" />
                    </div><!-- media -->
                </li>

            </ul>
        </div>

        
    </div><!-- tab-content -->
  </div>
  
  
</section>
<div class="modal fade in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title" id="myModalLabel">Advanced Search</h4>
      </div>
      <div class="modal-body">
            
            <h4 class="subtitle mb5">Name</h4>
            <input type="text" value="Search Term" class="form-control" />
            
            <div class="mb20"></div>
            
            <h4 class="subtitle mb5">Profession</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Profession...">
                  <option value=""></option>
                  <option value="United States">Doctor</option>
                  <option value="United Kingdom">Burse</option>
                  <option value="Afghanistan">General Practioti...</option>
                  <option value="Aland Islands">Big Doctor</option>
                  <option value="Albania">Small Doctor</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle mb5">Region</h4>
            <select class="form-control chosen-select" data-placeholder="Choose a Region...">
                  <option value=""></option>
                  <option value="SEAHEC">South East AHEC</option>
                  <option value="GVAHEC">Greater Valley AHEC</option>
                  <option value="NAHEC">Northern AHEC</option>
                  <option value="EAHEC">Eastern AHEC</option>
                  <option value="WAHEC">Western AHEC</option>
                </select>
            
            <div class="mb20"></div>
            
            <h4 class="subtitle mb5">Email</h4>
            <input type="text" value="Email Address" class="form-control" />
                          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">Search</button>
      </div>
    </div><!-- modal-content -->
  </div><!-- modal-dialog -->
</div>

<script src="../js/jquery-1.10.2.min.js"></script>
<script src="../js/jquery-migrate-1.2.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/modernizr.min.js"></script>
<script src="../js/jquery.sparkline.min.js"></script>
<script src="../js/toggles.min.js"></script>
<script src="../js/retina.min.js"></script>
<script src="../js/jquery.cookies.js"></script>
<script src="../js/morris.min.js"></script>
<script src="../js/raphael-2.1.0.min.js"></script>
<script src="../js/jquery.datatables.min.js"></script>

<script src="../js/jquery-ui-1.10.3.min.js"></script>
<script src="../js/chosen.jquery.min.js"></script>

<script src="../js/custom.js"></script>
<script>
    jQuery(document).ready(function() {
    
  new Morris.Line({
        // ID of the element in which to draw the chart.
        element: 'bar-chart',
        // Chart data records -- each entry in this array corresponds to a point on
        // the chart.
        data: [
            { y: '2006', a: 30, b: 35 },
            { y: '2007', a: 75,  b: 80 },
            { y: '2008', a: 50,  b: 65 },
            { y: '2009', a: 30,  b: 65 },
            { y: '2010', a: 40,  b: 95 },
            { y: '2011', a: 66,  b: 101 },
            { y: '2012', a: 120, b: 50 }
        ],
        xkey: 'y',
        ykeys: ['a', 'b'],
        labels: ['Trainees', 'Experiences'],
        lineColors: ['#D9534F', '#428BCA'],
        lineWidth: '2px',
        hideHover: true
    });
		
        
    });
</script>
<script>
$(document).ready(function() {
var userTable = $('#table2').dataTable({
  "sAjaxSource": "sources/dsSites.cfc?method=GetSites",
  "sPaginationType": "full_numbers",
  "aoColumns": [
    { "mDataProp": "ID" , "sTitle": "ID"},
    { "mDataProp": "SITENAME" , "sTitle": "Site Name"},
    { "mDataProp": "STATUS" , "sTitle": "Status",
	"mRender" : function (data, type, row) {
	        if (data == 1) {
            sReturn = 'Active';
            return sReturn;
        }
        else {
            sReturn = 'Inactive';
            return sReturn;
        }
	},
	
	},
    { "mDataProp": "CITY" , "sTitle": "City"},
	{ "mDataProp": "WEBSITE" , "sTitle": "Website",
    "mRender" : function (data, type, row) {
	        if (data == 'No Website Avaliable') {
            sReturn = 'N/A';
            return sReturn;
        }
        else {
            sReturn = '<a href="'+data+'">Visit Website</a>';
            return sReturn;
        }
	}	
	},
	{ "mData": "ID" , //its null here because history column will contain the mRender
    "mRender" : function (data, type, row) {
	return '<a href="ae/vSite.cfm?id='+data+'"><i class="fa fa-pencil"></i></a>';
	} }	

  ]
  
});


    
    jQuery("select").chosen({
      'min-width': '100px',
      'white-space': 'nowrap',
      disable_search_threshold: 10
    });
	
  // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
  
  });
</script>

</body>
</html>
