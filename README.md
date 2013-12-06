FoldingAtHome-ClientAPI
=======================

This is a very simple perl module to allow interaction with the socket daemon that the Folding at Home client runs.

I've used this module to create scripts that post statistics to a simple web application to allow tracking all of my folding at home clients.

The module is very basic and has the following subroutines:

  api_options - Provides FAH Configuration, User/Team Information, and basic system information
  api_info - Provides System Information, Client Information / Client Build Information
  api_queue - Provides the current running projects
  api_slots - Provide the available slots for your FAHClient
  
  
There is an example script provided with this codebase "ClientAPITest.pl" which will provide output from your client and show the raw information from each of these subroutines.

An example of the expected output from the script is provided in ClientAPITestResult.txt

Documentation for this module is located in "ClientAPIDoc.txt"

The perl modules required for functionality are:

  JSON::XS
  Net::Telnet
  Exporter
