IMPORT com
IMPORT FGL calculatorServer

MAIN
DEFINE result INTEGER

    CALL com.WebServiceEngine.RegisterRestService("calculatorServer","Calculator")
    CALL com.WebServiceEngine.Start()
    WHILE TRUE
        LET result = com.WebServiceEngine.ProcessServices(-1)
        -- handling of result found here 
        -- http://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_gws_restful_high_level_publish_module.html
        CASE result
            WHEN 0
                DISPLAY "Request processed." 
            WHEN -1
                DISPLAY "Timeout reached."
            WHEN -2
                DISPLAY "Disconnected from application server."
                EXIT PROGRAM   # The Application server has closed the connection
            WHEN -3
                DISPLAY "Client Connection lost."
            WHEN -4
                DISPLAY "Server interrupted with Ctrl-C."
            WHEN -9
                DISPLAY "Unsupported operation."
            WHEN -10
                DISPLAY "Internal server error."
            WHEN -23
                DISPLAY "Deserialization error."
            WHEN -35
                DISPLAY "No such REST operation found."
            WHEN -36
                DISPLAY "Missing REST parameter."
            OTHERWISE 
                DISPLAY "Unexpected server error " || result || "."
                EXIT WHILE 
        END CASE
        IF int_flag<>0 THEN
            LET int_flag=0
            EXIT WHILE
        END IF     
    END WHILE
END MAIN