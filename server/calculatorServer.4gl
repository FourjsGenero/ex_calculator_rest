

#+ add(x,y) RETURING INTEGER
#+
#+ Adds the two parameters together
#+
#+ @param x INTEGER
#+ 
#+ @param y INTEGER
#+
#+ @return INTEGER The result of adding the two parameters together
FUNCTION add(
    x INTEGER ATTRIBUTES(WSQuery),
    y INTEGER ATTRIBUTES(WSQuery)
    )
    ATTRIBUTES (WSGet, WSPath='/Add')
    RETURNS INTEGER

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
FUNCTION minus(    
    x INTEGER ATTRIBUTES(WSQuery),
    y INTEGER ATTRIBUTES(WSQuery)
    )
    ATTRIBUTES (WSGet, WSPath='/Minus')
    RETURNS INTEGER
    
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
FUNCTION multiply(    
    x INTEGER ATTRIBUTES(WSQuery),
    y INTEGER ATTRIBUTES(WSQuery)
    )
    ATTRIBUTES (WSGet, WSPath='/Multiply')
    RETURNS INTEGER
        
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
FUNCTION divide(    
    x INTEGER ATTRIBUTES(WSQuery),
    y INTEGER ATTRIBUTES(WSQuery)
    )
    ATTRIBUTES (WSGet, WSPath='/Divide')
    RETURNS INTEGER
    
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
FUNCTION modulo(
    x INTEGER ATTRIBUTES(WSQuery),
    y INTEGER ATTRIBUTES(WSQuery)
    )
    ATTRIBUTES (WSGet, WSPath='/Modulo')
    RETURNS INTEGER
    
    RETURN x MOD y
END FUNCTION