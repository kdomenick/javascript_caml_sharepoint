<!-- *********************************************************************************************************************  
Pull from a Sharepoint List that contains links to video files (actual video files stored outside of Sharepoint).  Display the output as an embedded video with controls.  Also display the name of the person who created the video (ows_Author).  Some splitting/slicing has to occur in order to remove extra characters from the author field.  Only one video is displayed at a time.  Each video link has an expiration date, and the query excludes anything that has expired.

In this example, the name of the Sharepoint list is "Featured Video" and events have a Title (ows_Title) and video link (Video_x0020_link). 

 *************************************************************************************************************************  
 -->

<div class="wrapper container class"> <!-- add your class -->
	<script type="text/javascript">
			var result = "";
            var myQueryOptions = "<QueryOptions><ViewAttributes Scope='Recursive' IncludeRootFolder='True' /></QueryOptions>";
	        var myQuery = "<Query><Where><Geq><FieldRef Name='Expire' /><Value Type='DateTime' IncludeTimeValue='FALSE'><Today /></Value></Geq></Where><OrderBy><FieldRef Name='Created_x0020_Date' Ascending='FALSE' /></OrderBy></Query>";
			$().SPServices({
				operation: "GetListItems",
				async: false,
				listName: "Featured Video",
				CAMLViewFields: "<ViewFields><FieldRef Name='Title' /><FieldRef Name='Description' /><FieldRef Name='Video_x0020_link' /><FieldRef Name='Author' /></ViewFields>",
				CAMLQuery: myQuery,
				CAMLRowLimit: 1, //limits to 1 item at a time
				CAMLQueryOptions: myQueryOptions,
				completefunc: function (xData, Status) {
				   if (Status == "success") {
  				      var itemCount = Number($(xData.responseXML).find("rs\\:data, data").attr("ItemCount"));
                      if (itemCount > 0) {
                          $(xData.responseXML).find("z\\:row, row").each(function()  {
                            var author = [];
                      	 	var auth = $(this).attr("ows_Author");
                      	 	author = auth.split(";#");
                      	 	author = author.slice(1,2);
				            result = "<h4 class='nopad'>" + $(this).attr("ows_Title") + "</h4>"
				            + "<div class='author'>" + "Created By: "+ author + "</div>"
				            + "<video controls >"
				            + "<source src='" + $(this).attr("ows_Video_x0020_link") + "' type='video/mp4'> </video>"; 
				          	document.write(result);
				          });
				      }
				    }
				  }
         		});
	</script>
	
</div>
