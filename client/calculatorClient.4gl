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
#       calculatorClient.4gl Client of REST based web service example
#
#       reuben January 2009 Created by taking $FGLDIR/demo/WebServices/calculator/client/calculatorClient.4gl
#                           and modifying to call a REST based web service rather than a SOAP based web service
#

#+ calculatorClient.4gl
#+
#+ Client of REST based calculator web service example

IMPORT com
IMPORT xml

MAIN
  DEFINE op1        INTEGER
  DEFINE op2        INTEGER
  
  CLOSE WINDOW SCREEN
  
  OPEN WINDOW w1 WITH FORM "calculatorClient" ATTRIBUTE (TEXT="Web Services calculator demo",STYLE="naked")
  
  INPUT BY NAME op1,op2 ATTRIBUTE (UNBUFFERED)
     ON ACTION plus     CALL calc("add", op1, op2)
     ON ACTION minus    CALL calc("minus", op1, op2)
     ON ACTION multiply CALL calc("multiply", op1, op2)
     ON ACTION divide   CALL calc("divide", op1, op2)
     ON ACTION close
       EXIT INPUT       
  END INPUT

  CLOSE WINDOW w1
  
END MAIN



#+ calc(operator, param1, param2)
#+
#+ Bridge between the INPUT and the REST Web Service handler to make the call and display results in a consistent manner
#+
#+ @code 
#+ CALL calc("add",1,2)
#+
#+ @param operator STRING The action triggered by the user
#+
#+ @param param1 INTEGER The first parameter entered by the user
#+
#+ @param param2 INTEGER The second parameter entered by the user
FUNCTION calc(operator, param1, param2)
DEFINE operator STRING
DEFINE param1   INTEGER
DEFINE param2    INTEGER

DEFINE ok         INTEGER
DEFINE error      STRING
DEFINE result     INTEGER
DEFINE remaind    INTEGER

   CALL calc_rest(operator,param1, param2) RETURNING ok, error, result, remaind
   IF ok THEN
      DISPLAY BY NAME result,remaind
      DISPLAY "OK" TO msg
   ELSE
      CLEAR result, remaind
      DISPLAY error TO msg
   END IF
END FUNCTION



#+ calc_rest(operator, param1, param2) RETURNING ok, error, result, remaind
#+
#+ Function that calls the calc REST based Web Server and interprets the result and turns it into something suitable for display in the client program
#+
#+ @code
#+ CALL calc_rest("add",1,2) RETURING ok, error, result, remaind
#+
#+ @param operator STRING The action triggered by the user
#+
#+ @param param1 INTEGER The first parameter entered by the user
#+
#+ @param param2 INTEGER The second parameter entered by the user
#+
#+ @return ok SMALLINT TRUE/FALSE indicating if the calculation was performed successfully
#+
#+ @return error STRING An error message that is suitable to display in the client program
#+
#+ @return result INTEGER The result of the calculator operation
#+
#+ @return remaind INTEGER The remainder result of the calculator operation. Only populated by divide operations
FUNCTION calc_rest(operator, param1, param2)
DEFINE operator STRING
DEFINE param1, param2 STRING
DEFINE url STRING

DEFINE result_dom xml.DomDocument
DEFINE root xml.DomNode
DEFINE child xml.DomNode
DEFINE http_req com.HTTPRequest
DEFINE http_resp com.HTTPResponse

DEFINE error_code INTEGER
DEFINE error_desc STRING
DEFINE error_text STRING
DEFINE result, remaind INTEGER

DEFINE address STRING

   LET address = "localhost:", nvl(FGL_GETENV("FGLAPPSERVER"),8090)
   
   LET url = SFMT("http://%1/calculator?operator=%2&param1=%3&param2=%4", address, operator, param1.trim(), param2.trim())

  # Create the HTTP request and get the XML response
   TRY
      LET http_req = com.HTTPRequest.Create(url)
	  CALL http_req.doRequest()
	  LET http_resp = http_req.getResponse()
	  IF http_resp.getStatusCode() != 200 THEN # 200 is HTTP success code
	     # Some error occured in the HTTP communication
	     LET error_code = http_resp.getStatusCode()
		 LET error_desc = http_resp.getStatusDescription()
		 RETURN FALSE, error_desc, 0, 0
      ELSE
	     # Successful communicaton
	     LET result_dom = http_resp.getXmlResponse()
      END IF
   CATCH
      # Some other error occured
	  LET error_code = status
	  LET error_desc = ERR_GET(error_code)
	  RETURN FALSE, error_desc, 0, 0
   END TRY	  

   LET root = result_dom.getDocumentElement()
   LET error_text = root.getAttribute("error")
   IF error_text.getLength() > 0 THEN
      # Function returned an error 
      RETURN FALSE, error_text, 0, 0
   END IF

   # Function was able to be interpreted
   # Output is the second child
   LET child = root.getLastChild()
   IF child.getNodeName() = "OUTPUT" THEN
      LET result = child.getAttribute("result")
	  LET remaind = child.getAttribute("remaind")
	  RETURN TRUE, "", result, remaind
   ELSE
      # XML Document isn't in expected format
      RETURN FALSE, "Unable to interpret result", 0, 0
   END IF
END FUNCTION
