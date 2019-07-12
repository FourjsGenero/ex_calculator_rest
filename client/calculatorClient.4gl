#+
#+ Generated from calculatorClient
#+
IMPORT com
IMPORT xml
IMPORT util
IMPORT os

#+
#+ Global Endpoint user-defined type definition
#+
TYPE tGlobalEndpointType RECORD # Rest Endpoint
    Address RECORD # Address
        Uri STRING # URI
    END RECORD,
    Binding RECORD # Binding
        Version STRING, # HTTP Version (1.0 or 1.1)
        ConnectionTimeout INTEGER, # Connection timeout
        ReadWriteTimeout INTEGER, # Read write timeout
        CompressRequest STRING # Compression (gzip or deflate)
    END RECORD
END RECORD

PUBLIC DEFINE Endpoint
    tGlobalEndpointType
    = (Address:(Uri: "http://localhost:8092/ws/r/Calculator"))

# Error codes
PUBLIC CONSTANT C_SUCCESS = 0

################################################################################
# Operation /Modulo
#
# VERB: GET
#
PUBLIC FUNCTION modulo(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE resp_body INTEGER

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.Create()
        LET query = base.StringBuffer.Create()
        CALL fullpath.append("/Modulo")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", p_x))
            ELSE
                CALL query.append(SFMT("x=%1", p_x))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", p_y))
            ELSE
                CALL query.append(SFMT("y=%1", p_y))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HTTPRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeout(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeout(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.DoRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET resp_body = resp.getTextResponse()
                    RETURN C_SUCCESS, resp_body
                END IF
                RETURN -1, resp_body

            OTHERWISE
                RETURN resp.getStatusCode(), resp_body
        END CASE
    CATCH
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Divide
#
# VERB: GET
#
PUBLIC FUNCTION divide(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE resp_body INTEGER

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.Create()
        LET query = base.StringBuffer.Create()
        CALL fullpath.append("/Divide")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", p_x))
            ELSE
                CALL query.append(SFMT("x=%1", p_x))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", p_y))
            ELSE
                CALL query.append(SFMT("y=%1", p_y))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HTTPRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeout(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeout(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.DoRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET resp_body = resp.getTextResponse()
                    RETURN C_SUCCESS, resp_body
                END IF
                RETURN -1, resp_body

            OTHERWISE
                RETURN resp.getStatusCode(), resp_body
        END CASE
    CATCH
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Multiply
#
# VERB: GET
#
PUBLIC FUNCTION multiply(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE resp_body INTEGER

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.Create()
        LET query = base.StringBuffer.Create()
        CALL fullpath.append("/Multiply")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", p_x))
            ELSE
                CALL query.append(SFMT("x=%1", p_x))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", p_y))
            ELSE
                CALL query.append(SFMT("y=%1", p_y))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HTTPRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeout(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeout(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.DoRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET resp_body = resp.getTextResponse()
                    RETURN C_SUCCESS, resp_body
                END IF
                RETURN -1, resp_body

            OTHERWISE
                RETURN resp.getStatusCode(), resp_body
        END CASE
    CATCH
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Minus
#
# VERB: GET
#
PUBLIC FUNCTION minus(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE resp_body INTEGER

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.Create()
        LET query = base.StringBuffer.Create()
        CALL fullpath.append("/Minus")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", p_x))
            ELSE
                CALL query.append(SFMT("x=%1", p_x))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", p_y))
            ELSE
                CALL query.append(SFMT("y=%1", p_y))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HTTPRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeout(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeout(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.DoRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET resp_body = resp.getTextResponse()
                    RETURN C_SUCCESS, resp_body
                END IF
                RETURN -1, resp_body

            OTHERWISE
                RETURN resp.getStatusCode(), resp_body
        END CASE
    CATCH
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################

################################################################################
# Operation /Add
#
# VERB: GET
#
PUBLIC FUNCTION add(p_x INTEGER, p_y INTEGER) RETURNS(INTEGER, INTEGER)
    DEFINE fullpath base.StringBuffer
    DEFINE query base.StringBuffer
    DEFINE contentType STRING
    DEFINE req com.HTTPRequest
    DEFINE resp com.HTTPResponse
    DEFINE resp_body INTEGER

    TRY

        # Prepare request path
        LET fullpath = base.StringBuffer.Create()
        LET query = base.StringBuffer.Create()
        CALL fullpath.append("/Add")
        IF p_x IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&x=%1", p_x))
            ELSE
                CALL query.append(SFMT("x=%1", p_x))
            END IF
        END IF
        IF p_y IS NOT NULL THEN
            IF query.getLength() > 0 THEN
                CALL query.append(SFMT("&y=%1", p_y))
            ELSE
                CALL query.append(SFMT("y=%1", p_y))
            END IF
        END IF
        IF query.getLength() > 0 THEN
            CALL fullpath.append("?")
            CALL fullpath.append(query.toString())
        END IF

        # Create request and configure it
        LET req =
            com.HTTPRequest.Create(
                SFMT("%1%2", Endpoint.Address.Uri, fullpath.toString()))
        IF Endpoint.Binding.Version IS NOT NULL THEN
            CALL req.setVersion(Endpoint.Binding.Version)
        END IF
        IF Endpoint.Binding.ConnectionTimeout <> 0 THEN
            CALL req.setConnectionTimeout(Endpoint.Binding.ConnectionTimeout)
        END IF
        IF Endpoint.Binding.ReadWriteTimeout <> 0 THEN
            CALL req.setTimeout(Endpoint.Binding.ReadWriteTimeout)
        END IF
        IF Endpoint.Binding.CompressRequest IS NOT NULL THEN
            CALL req.setHeader(
                "Content-Encoding", Endpoint.Binding.CompressRequest)
        END IF

        # Perform request
        CALL req.setMethod("GET")
        CALL req.setHeader("Accept", "text/plain")
        CALL req.DoRequest()

        # Retrieve response
        LET resp = req.getResponse()
        # Process response
        INITIALIZE resp_body TO NULL
        LET contentType = resp.getHeader("Content-Type")
        CASE resp.getStatusCode()

            WHEN 200 #Success
                IF contentType MATCHES "*text/plain*" THEN
                    # Parse TEXT response
                    LET resp_body = resp.getTextResponse()
                    RETURN C_SUCCESS, resp_body
                END IF
                RETURN -1, resp_body

            OTHERWISE
                RETURN resp.getStatusCode(), resp_body
        END CASE
    CATCH
        RETURN -1, resp_body
    END TRY
END FUNCTION
################################################################################
