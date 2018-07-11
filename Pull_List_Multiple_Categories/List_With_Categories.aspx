<!-- *********************************************************************************************************************  
Pull from a Sharepoint List items with a category field.  In this example, the List Item category values are: Lost, Found, Free, and Wanted.  Each item has an expiration date.  The query excludes any item that has expired.  Also display the name of the person who created the item (ows_Author) as well as some contact and other brief info.  Some splitting/slicing has to occur in order to remove extra characters from the author field. 

In this example, the name of the Sharepoint list is "Lost, Found, Free, Wanted" and the fields are the title (ows_Title), category field (ows_Lost_x002c__x0020_Found_x0020_or), Location (ows_Location), phone number (ows_Phone_x0020_Number) and author.  The output links the title to the original item.

 *************************************************************************************************************************  
 -->

<div class="wrapper container class"><!-- your wrapper/container class -->
	<script type="text/javascript">
		var result = "";
        var myQueryOptions = "<QueryOptions><ViewAttributes Scope='RecursiveAll' IncludeRootFolder='True' /></QueryOptions>";
        var myQuery = "<Query><OrderBy><FieldRef Name='Created_x0020_Date' Ascending='FALSE' /></OrderBy><Where><And><Eq><FieldRef Name='Active' /><Value Type='Choice'>Active</Value></Eq><Geq><FieldRef Name='Expires' /><Value Type='DateTime' IncludeTimeValue='FALSE'><Today /></Value></Geq></And></Where></Query>";
		$().SPServices({
			operation: "GetListItems",
			async: false,
			listName: "Lost, Found, Free, Wanted",
			CAMLViewFields: "<ViewFields><FieldRef Name='ID' /><FieldRef Name='Title' /><FieldRef Name='Lost_x002c__x0020_Found_x0020_or' /><FieldRef Name='Location' /><FieldRef Name='Author' /><FieldRef Name='Phone_x0020_Number' /></ViewFields>",
			CAMLQuery: myQuery,
			CAMLRowLimit: 10, //control how many items are retured
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
			             result =  "<span class='bold'>" + $(this).attr("ows_Lost_x002c__x0020_Found_x0020_or") + "</span> - " 
			             + "<a class='lostitem' href='/Lists/Lost%20Found%20%20Free/DispForm.aspx?ID=" + $(this).attr("ows_ID") + "&RootFolder=returnurl'>" 
			             + $(this).attr("ows_Title") + "</a>, " + $(this).attr("ows_Location")+ ", " 
			             + "Contact: " + $(this).attr("ows_Phone_x0020_Number")
			             + "<div class='author'>" + "Created By: "+ author + "</div>";
			             document.write(result);
			          });
			      }
			    }
			  }
     		});
	</script>
	<ul class="menu-list"><li><a class="button" href="link to full list">MORE</a></li></ul>
</div>
