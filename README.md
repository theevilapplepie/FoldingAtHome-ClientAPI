FoldingAtHome - Client API
=======================

This is a very simple perl module to allow interaction with the socket daemon ( telnet ) that the Folding at Home client runs.

I've used this module to create scripts that post statistics to a simple web application to allow tracking all of my folding at home clients.

The module is very basic and has the following subroutines:

  api_options - Provides FAH Configuration, User/Team Information, and basic system information<br/>
  api_info - Provides System Information, Client Information / Client Build Information<br/>
  api_queue - Provides the current running projects<br/>
  api_slots - Provide the available slots for your FAHClient<br/>
  
  
There is an example script provided with this codebase "ClientAPITest.pl" which will provide output from your client and show the raw information from each of these subroutines.<br/>
An example of the expected output from the script is provided in ClientAPITestResult.txt<br/>

Documentation for this module is located in "ClientAPIDoc.txt"

The perl modules required for functionality are:

  JSON::XS<br/>
  Net::Telnet<br/>
  Exporter<br/>
