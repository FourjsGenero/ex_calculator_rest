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
#       lib_rest.4gl Library routines for REST based web services
#
#       January 2009 reuben Created
#

#+ lib_rest.4gl
#+
#+ This module provides useful functions for use with the server program of a REST based Web Service



#+ split_url(url) returning address, method, arglist
#+
#+ Take the URL submitted to a REST based web service and split it into the address, method, and argument list components
#+
#+ @code
#+ CALL split_url("http://address/method?arglist")
#+
#+ @param url STRING The URL submitted to the REST based web service
#+
#+ @return address STRING The address component of the URL
#+
#+ @return method STRING The method component of the URL
#+
#+ @return arglist STRING The list of arguments components of the URL
FUNCTION split_url(url)
DEFINE url, address, method, arglist STRING
DEFINE argpos, i INTEGER

   # The argument list is what appears after the ?
   LET argpos = url.getIndexOf("?",1)
   IF argpos > 0 THEN
      LET arglist = url.SubString(argpos+1, url.getLength())
   ELSE
      LET argpos = url.getLength() + 1
      LET arglist = ""
   END IF

   # Before the argument list, the address and method are seperated
   # by the last /
   LET i = argpos
   WHILE i > 0 
      LET i = i - 1
	  IF url.getCharAt(i) = "/" THEN
	     LET address = url.SubString(1, i-1)
		 LET method = url.SubString(i+1, argpos-1)
		 EXIT WHILE
      END IF
   END WHILE
   IF i <= 0 THEN
      LET address = url.SubString(1, argpos-1)
	  LET method = ""
   END IF
   RETURN address, method, arglist
END FUNCTION



#+ get_urlarg_value(arg,arglist) RETURNING value
#+
#+ Given a list of URL arguments, return the value of the entered argument
#+
#+ @code
#+ LET param1 = get_urlarg_value("param1","param1=10&param2=20")
#+
#+ @param arg STRING The name of the argument to return the value of
#+
#+ @param arglist STRING A list of URL arguments.  Arguments seperated by & and arguments and value seperated by =
#+
#+ @return value STRING The value of the argument if it exists in the argument list
FUNCTION get_urlarg_value(arg, arglist)
DEFINE arg, arglist STRING
DEFINE value STRING
DEFINE search STRING
DEFINE argpos, nextargpos INTEGER

   LET search = arg,"="
   LET argpos = arglist.getIndexOf(search, 1)
   IF argpos = 0 THEN
      LET value = ""
   ELSE
      # have to add code to cater for &amp;, &gt; etc
	  # have to add code to cater for space or %20
      LET nextargpos = arglist.getIndexOf("&", argpos+search.getLength())
	  IF nextargpos = 0 THEN
	     LET nextargpos = arglist.getLength()+1
      END IF
	  LET value = arglist.subString(argpos+search.getLength(), nextargpos-1)
   END IF
   RETURN value
END FUNCTION
