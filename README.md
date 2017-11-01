# ex_calculator_rest
The SOAP based calculator web services demo refactored as RESTful

Note: this program was created before a similar example was added to the Genero documentation here http://4js.com/online_documentation/fjs-fgl-manual-html/#c_gws_rest_client_v_server.html.  It is independent of that example, I would suggest comparing both and noting the techniques used.

This example takes the SOAP based calculator web services demo that is shipped in the Genero product as FGLDIR/demo/WebServices/calculator and has refeactored it to use RESTful techniques.

It consists of two programs, calculatorServer and calculatorClient.  Build and run the calculatorServer example, leave it running, and then run the calculatorClient example.   Communication is controlled via FGLAPPSERVER environment variable.  The Studio project sets it to 8092, but you are free to change it to a different port.

The API uses a simple GET and a URL of the form ...

http://_address_/calculator?operator=_value_&param1=_value_&param2=_value_

Valid values for the operator argument are add, minus, multiply, and divide.
Valid values for param1, and param2 are any integer

The result is an XML Document of the form ...
```xml
    <CALCULATOR>
         <INPUT operator="add" param1="1" param2="2"/>
         <OUTPUT result="3" remaind="0"/>
    </CALCULATOR>
```
... where INPUT node contains details of what was passed, and OUTPUT node contains the results.

The server program uses some helper functions that are in FGLDIR/src/WSHelper.4gl to get from the URL the method and arguments.  (early versions of this program had its own functions in lib_rest.4gl to do this, but better to use the functions we supply so lib_rest.4gl has been deleted.)

(Note: This example was written before JSON was added to Genero.  Its on my TODO list to add JSON to this example)

If you are having trouble configuring and running, note the screenshot below ...

Note how calculatorClient is default app.

I have right-clicked on calculatorServer app to launch the server program first (see in Tasks it was launched before calculatorClient)
Then I have executed the calculatorClient app
Typed in values and pressed operation.

In the Output panel (not shown) you will see something like

    *** Running 'calculatorClient' ***
    --> $(gstrun)
    ::info:(GS-1025) Display client already running on 'localhost:6400'
    Processing http://localhost:8092/calculator?operator=add&param1=1&param2=2

<img alt="Setup screenshot" src="https://user-images.githubusercontent.com/13615993/32254383-478c671c-bf05-11e7-9a3c-8fe67947d93e.png" width="75%" />

I would suggest you become familiar with the error messages if the server is not running, and also note what happens if you type the URL directly into a browser.
