Summary

I work for AT&T as an architect on a big data project called TData. TData is a high speed real time prediction platform that ingests and analyzes large amounts of customer and content data to enable AT&T to provide relevant offers to its customers visting its web properties.  A useful visualization for our project would depict the number of recommendations that TData serves for a given time period by service type of our customers.  A service type specifies what services a customer has (Wireless, Voice, IPTV + Internet, etc) with 31 categories in all.  Another important concept of this project is a slot, or inventory space.  It is an area on one of our web pages where the promotion that TData provides is displayed.  These inventory slots can be configured and added as needed.

The data immediately showed that the majority of customers viewing our promotions are Wireless only.  This is evident when looking at the data over all slots or for specific slots.  Some of the slots, for example those on Uverse.com (1253, 1252) show more Uverse service types, but overall the trend is very clear.


Design

My first step was getting the data needed for the visualization.  I found a query our reporting group was using and updated it for Direct TV. The query included (service_type_query.sql).  My latest data was for October 14th (TdataRV210_14.csv.)

For the first chart (index_first.html), I followed the world cup example from class. The initial graph shows the distribution of service types over all the inventory slots.  The array used to hold this data is named 'big_nest' and has a key of service type id and values that contain an 'agg_cnt', which is the sum of all the recommendations for that service type over all our inventory slots.   This array is bound to the selection.  The x-axis graph is service type (a number from 1 to 31) and the y-axis is the number of recommendations shown on 10-14 for a certain service type, summing up all the slots that display our TData recommendations.  Each service type, count point is a separate circle drawn on the graph.

For the interaction I used a drop down list that contains all the inventory slots, where a user can select a slot and see the distribution for only that slot.  When a user selects a new option, the update function is called, which takes a slot name and redraws the scale of the y axis and all the data points using an 'agg_cnt' for that slot only.  This data is kept in the 'nested' array, which has a first level key of inventory slot, then a second level key of service type id along with the values array containing 'agg_cnt'.  When update is called, the nested array is filtered by the slot name selected, called 'filtered' with values that contain the key of service type id and values with 'agg_cnt' for the slot selected).   This array is bound to the selection.


Feedback

I asked a coworker to look over my visualization.  His main comment was that it needed better color with more emphasis on the data.  The circles were small and hard to see.  For the second iteration (index_second.html) I switched from little circles to a bar chart, colored brightly, and used an ordinal axis for the x axis as the service type numbers were not really numeric data. 

I also shared the project with my supervisor.  He suggested showing the service type descriptions, instead of the service type numbers, on the chart.  Since the description field in the original data was too fine-grained (multiple descriptions for one service type) I brought in another csv file (ServiceTypeMap.csv), which has the service type id to service type description mapping.  When transforming the data, I used this table to update the service description in our main data to this top level description and to sort the x axis labels so that the descriptions are still in numeric order by service type id. I rotated the service type labels and increased the bottom margin so that they would be readable.  He also suggested labeling the axes, and only changing the dynamic part of the heading when the chart was updated. This final visualization is shown in index_third.html.

He had some other suggestions.  One is to allow the user to select a time period for the data, and connect to the back end Vertica DB so that the data can be refreshed.  Another is to sort slot names by consumption engine so that the list is easier to traverse.  I hope to implement these feature in upcoming weeks.

Resources

Stackoverflow
http://bost.ocks.org/mike/bar/3/
Udacity Data Vis class
TData dataset









