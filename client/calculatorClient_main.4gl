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

IMPORT FGL calculatorClient

MAIN
  DEFINE op1        INTEGER
  DEFINE op2        INTEGER
  DEFINE result     INTEGER
  DEFINE remaind    INTEGER

  DEFINE wsstatus INTEGER
  
  CLOSE WINDOW SCREEN
  
  OPEN WINDOW w1 WITH FORM "calculatorClient" ATTRIBUTE (TEXT="Web Services calculator demo",STYLE="naked")

  INPUT BY NAME op1,op2 ATTRIBUTE (UNBUFFERED)
     ON ACTION plus     
        CALL calculatorClient.Add(op1, op2) RETURNING wsstatus, result
        LET remaind = 0
        DISPLAY BY NAME result, remaind
     ON ACTION minus    
        CALL calculatorClient.Minus(op1, op2) RETURNING wsstatus, result        
        LET remaind = 0
        DISPLAY BY NAME result, remaind
     ON ACTION multiply 
        CALL calculatorClient.Multiply(op1, op2) RETURNING wsstatus, result
        LET remaind = 0
        DISPLAY BY NAME result, remaind
     ON ACTION divide   
        CALL calculatorClient.Divide(op1, op2) RETURNING wsstatus, result
        CALL calculatorClient.Modulo(op1, op2) RETURNING wsstatus, remaind
        DISPLAY BY NAME result, remaind
        
     ON ACTION close
        EXIT INPUT    
    END INPUT

  CLOSE WINDOW w1
  
END MAIN