<!-- *********************************************************************************************************************  
Pull from a Sharepoint List containing images.  In this example, the images are advertisement banners that are displayed in rotation using a second javascript (code not shown) 

In this example, each image has an expiration date.  The query excludes any image that has expired.  
The location of the image is pulled through the File Reference field (ows_FileRef).  Some splitting/slicing has to occur in order to remove extra characters from the File Reference.   
In this example, the name of the Sharepoint list is "Image Banners" and banners have a URL field (ows_URL) that they link to in the output.

 *************************************************************************************************************************  
 -->

<div class="slideshow"> <!-- add your class -->
	<script type="text/javascript">	
		var result = "";
		var myQueryOptions = "<QueryOptions><ViewAttributes Scope='RecursiveAll' IncludeRootFolder='True' /></QueryOptions>";
   		var myQuery = "<Query><Where><Geq><FieldRef Name='Expire' /><Value Type='DateTime' IncludeTimeValue='FALSE'><Today /></Value></Geq></Where><OrderBy><FieldRef Name='Title' Ascending='FALSE' /></OrderBy></Query>";
		$().SPServices({
		operation: "GetListItems",
		async: false,
		listName: "Image Banners",
		CAMLViewFields: "<ViewFields><FieldRef Name='ID' /><FieldRef Name='Title' /><FieldRef Name='URL' /><FieldRef Name='Expire' /><FieldRef Name='FileRef' /></ViewFields>",
		CAMLQuery: myQuery,
		CAMLRowLimit: 10,  //adjust to control number of items returned.
		CAMLQueryOptions: myQueryOptions,
		completefunc: function (xData, Status) {
   			if (Status == "success") {
	     	 var itemCount = Number($(xData.responseXML).find("rs\\:data, data").attr("ItemCount"));
                  	if (itemCount > 0) {
                      	$(xData.responseXML).find("z\\:row, row").each(function()  {
                         	var imageurl = [];
                      	 	var imgu = $(this).attr("ows_FileRef");
                       	 	imageurl = imgu.split(";#");
                       	 	imageurl = imageurl.slice(1,2); 
			             	result = "<a href='" + $(this).attr("ows_URL") + "'>" + "<img u='image' src='http://yourserver/" + imageurl + "'>" + "</a>"; 
			             	document.write(result);
			          	});
			      	}
			    	}
			  	}
   			});
         	
	</script>
</div>
