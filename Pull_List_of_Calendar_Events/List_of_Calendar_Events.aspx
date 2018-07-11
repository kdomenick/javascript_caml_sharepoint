<!-- *********************************************************************************************************************  
Pull from a Sharepoint Calendar and display an event title and date.  Exclude events that occurred in the past, and show upcoming events in order of date/time field ascending.  Also display the name of the person who created the event (ows_Author).  Some splitting/slicing has to occur in order to remove extra characters from the author field.   
In this example, the name of the Sharepoint list is "Happenings" and events have a Title (ows_Title) and date/time (ows_EventDate). 
The title is output to a URL that links to the actual calendar event entry based on the event ID (ows_ID).

 *************************************************************************************************************************  
 -->

 <div class="your wrapper class"> <!-- update to your wrapper class -->
	<script type="text/javascript">
		var result = "";
        var myQueryOptions = "<QueryOptions><ViewAttributes Scope='Recursive' IncludeRootFolder='True' /></QueryOptions>";
        var myQuery = "<Query><Where><Geq><FieldRef Name='EventDate' /><Value Type='DateTime' IncludeTimeValue='FALSE'><Today /></Value></Geq></Where><OrderBy><FieldRef Name='EventDate' Ascending='TRUE' /></OrderBy></Query>";
		$().SPServices({
			operation: "GetListItems",
			async: false,
			listName: "Happenings",
			CAMLViewFields: "<ViewFields><FieldRef Name='ID' /><FieldRef Name='Title' /><FieldRef Name='EventDate' /><FieldRef Name='Author' /></ViewFields>",
			CAMLQuery: myQuery,
			CAMLRowLimit: 5, //adjust to control number of items displayed
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
                      	 var inputdate = $(this).attr("ows_EventDate");
                      	 var displaydate = convertDate(inputdate, "date") + " " + convertDate(inputdate, "time");
			             result = displaydate + "<br/>" + "<a href='/Lists/Happenings/DispForm.aspx?ID=" + $(this).attr("ows_ID") + "&RootFolder=returnurl'>" + $(this).attr("ows_Title") + "</a> " + "<div class='author'>" + "Created By: "+ author + "</div>";
			             document.write(result);
			          });
			      }
			    }
			  }
     		});
	</script>
	<ul class="menu-list"><li><a class="button" href="link to full calendar">MORE</a></li></ul>
</div>