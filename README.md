# ex_calculator_rest
The SOAP based calculator web services demo refactored as RESTful

This example was refactored after Genero 3.20 to use the new high-level RESTful Web Services.  I still have a little bit of tidyup to do but I wanted to get something checked in

This example takes the SOAP based calculator web services demo that is shipped in the Genero product as FGLDIR/demo/WebServices/calculator and has refeactored it to use RESTful techniques.

It consists of two programs, calculatorServer and calculatorClient.  Build and run the calculatorServer example, leave it running, and then run the calculatorClient example.   Communication is controlled via FGLAPPSERVER environment variable.  The Studio project sets it to 8092, but you are free to change it to a different port.

If you are having trouble configuring and running, note the screenshot below ...

Note how calculatorClient is default app.

I have right-clicked on calculatorServer app to launch the server program first (see in Tasks it was launched before calculatorClient)
Then I have executed the calculatorClient app
Typed in values and pressed operation.

In the Output panel (not shown) you will see something like

TODO add new screenshot
