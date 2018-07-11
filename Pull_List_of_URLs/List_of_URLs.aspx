<!-- *********************************************************************************************************************  
Pull from a Sharepoint List that contains URLs and display those URLs in order of most-recently created  
In this example, the name of the Sharepoint list is "URL List" and all List Items have an expiration date field.  This query will only pull items that have not expired.  Each List Item also has a URL (ows_Web_x0020_Link) and a title field (ows_LinkTitle).  

 *************************************************************************************************************************  
 -->


<div class="wrapper for styling"> <!-- change to suit your wrapper/container class -->
	<script type="text/javascript">
		var result = "";
        var myQueryOptions = "<QueryOptions><ViewAttributes Scope='RecursiveAll' IncludeRootFolder='True' /></QueryOptions>";
        var myQuery = "<Query><Where><Geq><FieldRef Name='Expires' /><Value Type='DateTime' IncludeTimeValue='FALSE'><Today /></Value></Geq></Where><OrderBy><FieldRef Name='Created_x0020_Date' Ascending='FALSE' /></OrderBy></Query>";
		$().SPServices({
			operation: "GetListItems",
			async: false,
			listName: "URL List",
			CAMLViewFields: "<ViewFields><FieldRef Name='ID' /><FieldRef Name='LinkTitle' /><FieldRef Name='Web_x0020_Link' /><FieldRef Name='Expires' /><FieldRef Name='Author' /></ViewFields>",
			CAMLQuery: myQuery,
			CAMLRowLimit: 4,  //Adjust this number to control how many items are returned.
			CAMLQueryOptions: myQueryOptions,
			completefunc: function (xData, Status) {
			   if (Status == "success") {
				      var itemCount = Number($(xData.responseXML).find("rs\\:data, data").attr("ItemCount"));
                  if (itemCount > 0) {
                      $(xData.responseXML).find("z\\:row, row").each(function()  {
			             result = "<a href='" + $(this).attr("ows_Web_x0020_Link") + "'>" + $(this).attr("ows_LinkTitle") + "</a>" ;
			             document.write(result + "<br/>");
			          });
			      }
			    }
			  }
     		});
		</script>	
</div>
