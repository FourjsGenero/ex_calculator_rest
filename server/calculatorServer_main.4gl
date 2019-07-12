IMPORT com
IMPORT FGL calculatorServer

MAIN
DEFINE result INTEGER

    CALL com.WebServiceEngine.RegisterRestService("calculatorServer","Calculator")
    CALL com.WebServiceEngine.Start()
    WHILE TRUE
        LET result = com.WebServiceEngine.ProcessServices(-1)
    END WHILE
END MAIN