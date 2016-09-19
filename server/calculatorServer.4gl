#
#       (c) Copyright 2008, Four Js AsiaPac - www.4js.com.au/local
#
#       MIT License (http://www.opensource.org/licenses/mit-license.php)
#
#       Permission is hereby granted, free of charge, to any person
#       obtaining a copy of this software and associated documentation
#       files (the "Software"), to deal in the Software without restriction,
#       including without limitation the rights to use, copy, modify, merge,
#       publish, distribute, sublicense, and/or sell copies of the Software,
#       and to permit persons to whom the Software is furnished to do so,
#       subject to the following conditions:
#
#       The above copyright notice and this permission notice shall be
#       included in all copies or substantial portions of the Software.
#
#       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#       EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
#       OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#       NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
#       BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
#       ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#       CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#       THE SOFTWARE.
#
#       calculatorServer.4gl Server of REST based web service example
#
#       reuben January 2009 Created by taking $FGLDIR/demo/WebServices/calculator/server/calculatorServer.4gl
#                           and modifying to be a REST based web service rather than a SOAP based web service
#

#+ calculatorServer.4gl
#+
#+ Server of REST based calculator web service example

IMPORT com
IMPORT xml

MAIN
  DEFINE request com.HTTPServiceRequest  
  DEFINE doc xml.DomDocument
  DEFINE ok SMALLINT
  DEFINE desc STRING 
      
  DEFER INTERRUPT

  # Starts the server on the port number specified by the FGLAPPSERVER environment variable
  DISPLAY "Starting server..."
  CALL com.WebServiceEngine.Start()
  DISPLAY "The server is listening."

  WHILE TRUE
	TRY
       LET request = com.WebServiceEngine.getHTTPServiceRequest(-1)
	CATCH
	   IF int_flag THEN
	      LET int_flag = 0
	      DISPLAY "Service Interrupted"
	   ELSE
	      DISPLAY "Request Error"
	   END IF
	   EXIT WHILE
	END TRY
	IF request IS NULL THEN
	   EXIT WHILE
	END IF
	DISPLAY SFMT("Processing %1", request.getURL())
	CALL process_http_request(request.getURL()) RETURNING ok, doc, desc
	CASE
	   WHEN doc IS NOT NULL # Successfully communicated and returned an XML document
	      CALL request.sendXMLResponse(200,"", doc)
	   WHEN ok # Ok but no XML document, e.g. favicon.ico call
	      CALL request.sendResponse(200, "")
	   OTHERWISE # An error of some form, an unspecified method
	      CALL request.sendResponse(400, desc)
    END CASE
  END WHILE
  DISPLAY "Server stopped"
  
END MAIN


#+ process_http_result(url) RETURNING ok, doc, desc
#+
#+ Process the URL that was received.  From the URL identify the method, call the appropriate function for that method passing the arguments
#+
#+ @param url STRING The URL received by the server program
#+
#+ @return ok SMALLINT TRUE/FALSE indicating if the URL passed in was something we were expecting and therefore able to process successfully
#+
#+ @return doc xml.DomDocument The XML Document to return
#+
#+ @return desc STRING If the method wasn't one we were expecting return a message to indicate this
FUNCTION process_http_request(url)
DEFINE url, address, method, arglist STRING
DEFINE doc xml.DomDocument
DEFINE ok SMALLINT
DEFINE code INTEGER
DEFINE desc STRING

   # Turn the URL into the address, method, and a list of arguments
   CALL split_url(url) RETURNING address, method, arglist

   CASE method
      WHEN "calculator"
	     CALL rest_calculator(arglist) RETURNING ok, doc
      WHEN "favicon.ico"
	     # ignore this method, called if enter URL in a browser 
		 LET ok = TRUE
		 LET doc = NULL
		 LET desc = ""
	  OTHERWISE
	     # return some error if any other method is called
	     LET ok = FALSE
		 LET doc = NULL
	     LET desc =  "Unspecified method"
   END CASE
   RETURN ok, doc, desc
END FUNCTION




# Probably have a function for each of the methods called


#+ rest_calculator(arglist) RETURNING ok, doc
#+
#+ Takes the URL arguments, checks them, and then calls functions to do the appropriate processing for the calculator web service and constructs an XML document to return
#+
#+ @param arglist STRING The URL arguments that were received by the webserver. Arguments seperated by & and argument and value separated by =
#+
#+ @return ok SMALLINT TRUE/FALSE REturn TRUE if the calculation was able to be successfully performed, FALSE otherwise
#+ 
#+ @return doc xml.DomDocument A document containing the output or any error messages that will be returned to the client
FUNCTION rest_calculator(arglist)
DEFINE arglist STRING
DEFINE operator STRING
DEFINE param1arg, param2arg STRING
DEFINE param1, param2 INTEGER
DEFINE result, remaind INTEGER
DEFINE doc xml.DomDocument
DEFINE root_node, input_node, output_node xml.DomNode

   # Set up the document to return
   LET doc = xml.DomDocument.createDocument("CALCULATOR")

   LET root_node = doc.getDocumentElement()
   LET input_node = root_node.appendChildElement("INPUT")
   LET output_node = root_node.appendChildElement("OUTPUT")

   # Read what we can of the arguments
   LET operator = get_urlarg_value("operator", arglist)
   CALL input_node.setAttribute("operator", operator)

   LET param1arg = get_urlarg_value("param1", arglist)
   CALL input_node.setAttribute("param1", param1arg)

   LET param2arg = get_urlarg_value("param2", arglist)
   CALL input_node.setAttribute("param2", param2arg)

   # Validate the arguments
   IF operator.getLength() = 0 THEN
      CALL root_node.setAttribute("error", "operator must be specified")
	  RETURN FALSE, doc
   END IF
   IF param1arg.getLength() = 0 THEN
      CALL root_node.setAttribute("error", "param1 must be specified")
	  RETURN FALSE, doc
   END IF
   IF param2arg.getLength() = 0 THEN
      CALL root_node.setAttribute("error", "param2 must be specified")
	  RETURN FALSE, doc
   END IF
      
   TRY
      LET param1 = param1arg
   CATCH
      CALL root_node.setAttribute("error", "param1 not a number")
	  RETURN FALSE, doc
   END TRY
   IF param1arg - param1 <> 0 THEN
      CALL root_node.setAttribute("error", "param1 not an integer")
	  RETURN FALSE, doc
   END IF

   TRY
	  LET param2 = param2arg
   CATCH
      CALL root_node.setAttribute("error", "param2 not a number")
	  RETURN FALSE, doc
   END TRY
   IF param2arg - param2 <> 0 THEN
      CALL root_node.setAttribute("error", "param2 not an integer")
	  RETURN FALSE, doc
   END IF

   # do the processing
   LET remaind = 0
   CASE operator
      WHEN "add" 
	     LET result = add(param1, param2)
      WHEN "minus" 
	     LET result = minus(param1,param2)
      WHEN "multiply" 
	     LET result = multiply(param1,param2)
      WHEN "divide" 
	     IF param2 = 0 THEN
            CALL root_node.setAttribute("error", "divide by zero error")
			RETURN FALSE, doc
         END IF
	     LET result = divide(param1,param2)
	     LET remaind = modulo(param1,param2)
	  OTHERWISE
         CALL root_node.setAttribute("error", "operator not a valid value")
	     RETURN FALSE, doc
   END CASE

   # get here if we were successul
   CALL output_node.setAttribute("result", result)
   CALL output_node.setAttribute("remaind", remaind)

   RETURN TRUE, doc
END FUNCTION




# actual functions, typically these will be in another .4gl so that they can be called
# by other non web-service programs

#+ add(x,y) RETURING INTEGER
#+
#+ Adds the two parameters together
#+
#+ @param x INTEGER
#+ 
#+ @param y INTEGER
#+
#+ @return INTEGER The result of adding the two parameters together
FUNCTION add(x,y)
DEFINE x,y INTEGER
   RETURN x + y
END FUNCTION



#+ minus(x,y) RETURING INTEGER
#+
#+ Subtracts the second parameter from the first
#+
#+ @param x INTEGER
#+ 
#+ @param y INTEGER
#+
#+ @return INTEGER The result of subtracting the second parameter from the first
FUNCTION minus(x,y)
DEFINE x,y INTEGER
   RETURN x - y
END FUNCTION



#+ multiply(x,y) RETURING INTEGER
#+
#+ Multiplies the two parameters together
#+
#+ @param x INTEGER
#+ 
#+ @param y INTEGER
#+
#+ @return INTEGER The result of multiplying the two parameters together
FUNCTION multiply(x,y)
DEFINE x,y INTEGER
   RETURN x * y
END FUNCTION



#+ divide(x,y) RETURING INTEGER
#+
#+ Divides the first parameter by the second
#+
#+ @param x INTEGER
#+ 
#+ @param y INTEGER
#+
#+ @return INTEGER The result of dividing the first parameter by the second
FUNCTION divide(x,y)
DEFINE x,y INTEGER
   RETURN x / y
END FUNCTION



#+ modulo(x,y) RETURING INTEGER
#+
#+ Performs a modulo operation of the two parameters 
#+
#+ @param x INTEGER
#+ 
#+ @param y INTEGER
#+
#+ @return INTEGER The remainder as a result of x/y (otherwise known as modulo)
FUNCTION modulo(x,y)
DEFINE x,y INTEGER
   RETURN x MOD y
END FUNCTION
