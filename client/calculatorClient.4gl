#+
#+ Generated from calculatorClient
#+
IMPORT com
IMPORT util

#+
#+ Global Endpoint user-defined type definition
#+
TYPE tGlobalEndpointType RECORD # Rest Endpoint
    Address RECORD # Address
        Uri STRING # URI
    END RECORD,
    Binding RECORD # Binding
        Version STRING, # HTTP Version (1.0 or 1.1)
        Cookie STRING, # Cookie to be set
        Request RECORD # HTTP request
            Headers DYNAMIC ARRAY OF RECORD # HTTP Headers
                Name STRING,
                Value STRING
            END RECORD
        END RECORD,
        Response RECORD # HTTP request
            Headers DYNAMIC ARRAY OF RECORD # HTTP Headers
                Name STRING,
                Value STRING
            END RECORD
        END RECORD,
        ConnectionTimeout INTEGER, # Connection timeout
        ReadWriteTimeout INTEGER, # Read write timeout
        CompressRequest STRING # Compression (gzip or deflate)
    END RECORD
END RECORD

PUBLIC DEFINE Endpoint tGlobalEndpointType =
    (Address:(Uri: "http://localhost:8092/Calculator"))

# Unexpected error details
PUBLIC DEFINE wsError RECORD
    code INTEGER,
    description STRING
END RECORD

# Error codes
PUBLIC CONSTANT C_SUCCESS = 0

################################################################################
# Operation /Add
#
# VERB: GET
# ID:          add
#
PUBLIC FUNCTION add(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE headerName STRING
    DEFINE ind INTEGER
    DEFINE req com.HttpRequest
    DEFINE resp com.HttpResponse
    DEFINE resp_body INTEGER
    DEFINE txt STRING

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.create()
        LET query = base.StringBuffer.create()
        CALL fullpath.append("/Add")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", util.Strings.urlEncode(p_x)))
            ELSE
                CALL query.append(SFMT("x=%1", util.Strings.urlEncode(p_x)))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", util.Strings.urlEncode(p_y)))
            ELSE
                CALL query.append(SFMT("y=%1", util.Strings.urlEncode(p_y)))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HttpRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.Cookie IS NOT NULL THEN
            CALL req.setHeader("Cookie", Endpoint.Binding.Cookie)
        END IF
        IF Endpoint.Binding.Request.Headers.getLength() > 0 THEN
            FOR ind = 1 TO Endpoint.Binding.Request.Headers.getLength()
                CALL req.setHeader(
                    Endpoint.Binding.Request.Headers[ind].Name,
                    Endpoint.Binding.Request.Headers[ind].Value)
            END FOR
        END IF
        CALL Endpoint.Binding.Response.Headers.clear()
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeOut(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeOut(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.doRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                # Retrieve response runtime headers
                IF resp.getHeaderCount() > 0 THEN
                    FOR ind = 1 TO resp.getHeaderCount()
                        LET headerName = resp.getHeaderName(ind)
                        CALL Endpoint.Binding.Response.Headers.appendElement()
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Name =
                            headerName
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Value =
                            resp.getHeader(headerName)
                    END FOR
                END IF
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET txt = resp.getTextResponse()
                    LET resp_body = txt
                    RETURN C_SUCCESS, resp_body
                END IF
                LET wsError.code = resp.getStatusCode()
                LET wsError.code = "Unexpected Content-Type"
                RETURN -1, resp_body

            OTHERWISE
                LET wsError.code = resp.getStatusCode()
                LET wsError.description = resp.getStatusDescription()
                RETURN -1, resp_body
        END CASE
    CATCH
        LET wsError.code = status
        LET wsError.description = sqlca.sqlerrm
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Divide
#
# VERB: GET
# ID:          divide
#
PUBLIC FUNCTION divide(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE headerName STRING
    DEFINE ind INTEGER
    DEFINE req com.HttpRequest
    DEFINE resp com.HttpResponse
    DEFINE resp_body INTEGER
    DEFINE txt STRING

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.create()
        LET query = base.StringBuffer.create()
        CALL fullpath.append("/Divide")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", util.Strings.urlEncode(p_x)))
            ELSE
                CALL query.append(SFMT("x=%1", util.Strings.urlEncode(p_x)))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", util.Strings.urlEncode(p_y)))
            ELSE
                CALL query.append(SFMT("y=%1", util.Strings.urlEncode(p_y)))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HttpRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.Cookie IS NOT NULL THEN
            CALL req.setHeader("Cookie", Endpoint.Binding.Cookie)
        END IF
        IF Endpoint.Binding.Request.Headers.getLength() > 0 THEN
            FOR ind = 1 TO Endpoint.Binding.Request.Headers.getLength()
                CALL req.setHeader(
                    Endpoint.Binding.Request.Headers[ind].Name,
                    Endpoint.Binding.Request.Headers[ind].Value)
            END FOR
        END IF
        CALL Endpoint.Binding.Response.Headers.clear()
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeOut(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeOut(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.doRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                # Retrieve response runtime headers
                IF resp.getHeaderCount() > 0 THEN
                    FOR ind = 1 TO resp.getHeaderCount()
                        LET headerName = resp.getHeaderName(ind)
                        CALL Endpoint.Binding.Response.Headers.appendElement()
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Name =
                            headerName
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Value =
                            resp.getHeader(headerName)
                    END FOR
                END IF
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET txt = resp.getTextResponse()
                    LET resp_body = txt
                    RETURN C_SUCCESS, resp_body
                END IF
                LET wsError.code = resp.getStatusCode()
                LET wsError.code = "Unexpected Content-Type"
                RETURN -1, resp_body

            OTHERWISE
                LET wsError.code = resp.getStatusCode()
                LET wsError.description = resp.getStatusDescription()
                RETURN -1, resp_body
        END CASE
    CATCH
        LET wsError.code = status
        LET wsError.description = sqlca.sqlerrm
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Minus
#
# VERB: GET
# ID:          minus
#
PUBLIC FUNCTION minus(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE headerName STRING
    DEFINE ind INTEGER
    DEFINE req com.HttpRequest
    DEFINE resp com.HttpResponse
    DEFINE resp_body INTEGER
    DEFINE txt STRING

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.create()
        LET query = base.StringBuffer.create()
        CALL fullpath.append("/Minus")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", util.Strings.urlEncode(p_x)))
            ELSE
                CALL query.append(SFMT("x=%1", util.Strings.urlEncode(p_x)))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", util.Strings.urlEncode(p_y)))
            ELSE
                CALL query.append(SFMT("y=%1", util.Strings.urlEncode(p_y)))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HttpRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.Cookie IS NOT NULL THEN
            CALL req.setHeader("Cookie", Endpoint.Binding.Cookie)
        END IF
        IF Endpoint.Binding.Request.Headers.getLength() > 0 THEN
            FOR ind = 1 TO Endpoint.Binding.Request.Headers.getLength()
                CALL req.setHeader(
                    Endpoint.Binding.Request.Headers[ind].Name,
                    Endpoint.Binding.Request.Headers[ind].Value)
            END FOR
        END IF
        CALL Endpoint.Binding.Response.Headers.clear()
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeOut(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeOut(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.doRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                # Retrieve response runtime headers
                IF resp.getHeaderCount() > 0 THEN
                    FOR ind = 1 TO resp.getHeaderCount()
                        LET headerName = resp.getHeaderName(ind)
                        CALL Endpoint.Binding.Response.Headers.appendElement()
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Name =
                            headerName
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Value =
                            resp.getHeader(headerName)
                    END FOR
                END IF
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET txt = resp.getTextResponse()
                    LET resp_body = txt
                    RETURN C_SUCCESS, resp_body
                END IF
                LET wsError.code = resp.getStatusCode()
                LET wsError.code = "Unexpected Content-Type"
                RETURN -1, resp_body

            OTHERWISE
                LET wsError.code = resp.getStatusCode()
                LET wsError.description = resp.getStatusDescription()
                RETURN -1, resp_body
        END CASE
    CATCH
        LET wsError.code = status
        LET wsError.description = sqlca.sqlerrm
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Modulo
#
# VERB: GET
# ID:          modulo
#
PUBLIC FUNCTION modulo(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE headerName STRING
    DEFINE ind INTEGER
    DEFINE req com.HttpRequest
    DEFINE resp com.HttpResponse
    DEFINE resp_body INTEGER
    DEFINE txt STRING

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.create()
        LET query = base.StringBuffer.create()
        CALL fullpath.append("/Modulo")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", util.Strings.urlEncode(p_x)))
            ELSE
                CALL query.append(SFMT("x=%1", util.Strings.urlEncode(p_x)))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", util.Strings.urlEncode(p_y)))
            ELSE
                CALL query.append(SFMT("y=%1", util.Strings.urlEncode(p_y)))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HttpRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.Cookie IS NOT NULL THEN
            CALL req.setHeader("Cookie", Endpoint.Binding.Cookie)
        END IF
        IF Endpoint.Binding.Request.Headers.getLength() > 0 THEN
            FOR ind = 1 TO Endpoint.Binding.Request.Headers.getLength()
                CALL req.setHeader(
                    Endpoint.Binding.Request.Headers[ind].Name,
                    Endpoint.Binding.Request.Headers[ind].Value)
            END FOR
        END IF
        CALL Endpoint.Binding.Response.Headers.clear()
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeOut(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeOut(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.doRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                # Retrieve response runtime headers
                IF resp.getHeaderCount() > 0 THEN
                    FOR ind = 1 TO resp.getHeaderCount()
                        LET headerName = resp.getHeaderName(ind)
                        CALL Endpoint.Binding.Response.Headers.appendElement()
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Name =
                            headerName
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Value =
                            resp.getHeader(headerName)
                    END FOR
                END IF
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET txt = resp.getTextResponse()
                    LET resp_body = txt
                    RETURN C_SUCCESS, resp_body
                END IF
                LET wsError.code = resp.getStatusCode()
                LET wsError.code = "Unexpected Content-Type"
                RETURN -1, resp_body

            OTHERWISE
                LET wsError.code = resp.getStatusCode()
                LET wsError.description = resp.getStatusDescription()
                RETURN -1, resp_body
        END CASE
    CATCH
        LET wsError.code = status
        LET wsError.description = sqlca.sqlerrm
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Multiply
#
# VERB: GET
# ID:          multiply
#
PUBLIC FUNCTION multiply(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE headerName STRING
    DEFINE ind INTEGER
    DEFINE req com.HttpRequest
    DEFINE resp com.HttpResponse
    DEFINE resp_body INTEGER
    DEFINE txt STRING

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.create()
        LET query = base.StringBuffer.create()
        CALL fullpath.append("/Multiply")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", util.Strings.urlEncode(p_x)))
            ELSE
                CALL query.append(SFMT("x=%1", util.Strings.urlEncode(p_x)))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", util.Strings.urlEncode(p_y)))
            ELSE
                CALL query.append(SFMT("y=%1", util.Strings.urlEncode(p_y)))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HttpRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.Cookie IS NOT NULL THEN
            CALL req.setHeader("Cookie", Endpoint.Binding.Cookie)
        END IF
        IF Endpoint.Binding.Request.Headers.getLength() > 0 THEN
            FOR ind = 1 TO Endpoint.Binding.Request.Headers.getLength()
                CALL req.setHeader(
                    Endpoint.Binding.Request.Headers[ind].Name,
                    Endpoint.Binding.Request.Headers[ind].Value)
            END FOR
        END IF
        CALL Endpoint.Binding.Response.Headers.clear()
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeOut(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeOut(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.doRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                # Retrieve response runtime headers
                IF resp.getHeaderCount() > 0 THEN
                    FOR ind = 1 TO resp.getHeaderCount()
                        LET headerName = resp.getHeaderName(ind)
                        CALL Endpoint.Binding.Response.Headers.appendElement()
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Name =
                            headerName
                        LET Endpoint.Binding.Response.Headers[
                                Endpoint.Binding.Response.Headers.getLength()]
                                    .Value =
                            resp.getHeader(headerName)
                    END FOR
                END IF
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET txt = resp.getTextResponse()
                    LET resp_body = txt
                    RETURN C_SUCCESS, resp_body
                END IF
                LET wsError.code = resp.getStatusCode()
                LET wsError.code = "Unexpected Content-Type"
                RETURN -1, resp_body

            OTHERWISE
                LET wsError.code = resp.getStatusCode()
                LET wsError.description = resp.getStatusDescription()
                RETURN -1, resp_body
        END CASE
    CATCH
        LET wsError.code = status
        LET wsError.description = sqlca.sqlerrm
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################
