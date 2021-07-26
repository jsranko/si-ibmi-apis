**FREE
/if defined(SIIWSP)
/eof
/endif

/define SIIWSP

// -----------------------------------------------------------------------------

// 2xx Success
dcl-c cSIIWS_ResponseCode_OK const(200);
dcl-c cSIIWS_ResponseCode_Created const(201);
dcl-c cSIIWS_ResponseCode_Accepted const(202);
dcl-c cSIIWS_ResponseCode_NonAuthoritativeInformation const(203);
dcl-c cSIIWS_ResponseCode_NoContent const(204);
dcl-c cSIIWS_ResponseCode_ResetContent const(205);
dcl-c cSIIWS_ResponseCode_PartialContent const(206);

// 4xx Client Error
dcl-c cSIIWS_ResponseCode_BadRequest const(400);
dcl-c cSIIWS_ResponseCode_Unauthorized const(401);
dcl-c cSIIWS_ResponseCode_PaymentRequired const(402);
dcl-c cSIIWS_ResponseCode_Forbidden const(403);
dcl-c cSIIWS_ResponseCode_NotFound const(404);
dcl-c cSIIWS_ResponseCode_MethodNotAllowed const(405);
dcl-c cSIIWS_ResponseCode_NotAcceptable const(406);
dcl-c cSIIWS_ResponseCode_ProxyAuthenticationRequired const(407);
dcl-c cSIIWS_ResponseCode_RequestTimeout const(408);
dcl-c cSIIWS_ResponseCode_Conflict const(409);
dcl-c cSIIWS_ResponseCode_Gone const(410);
dcl-c cSIIWS_ResponseCode_LengthRequired const(411);
dcl-c cSIIWS_ResponseCode_PreconditionFailed const(412);
dcl-c cSIIWS_ResponseCode_PayloadTooLarge const(413);
dcl-c cSIIWS_ResponseCode_URITooLong const(414);
dcl-c cSIIWS_ResponseCode_UnsupportedMediaType const(415);
dcl-c cSIIWS_ResponseCode_RequestedRangeNotSatisfiable const(416);
dcl-c cSIIWS_ResponseCode_ExpectationFailed const(417);
dcl-c cSIIWS_ResponseCode_ImATeapot const(418);
dcl-c cSIIWS_ResponseCode_MisdirectedRequest const(421);
dcl-c cSIIWS_ResponseCode_TooEarly const(425);
dcl-c cSIIWS_ResponseCode_UpgradeRequired const(426);
dcl-c cSIIWS_ResponseCode_PreconditionRequired const(428);
dcl-c cSIIWS_ResponseCode_TooManyRequests const(429);
dcl-c cSIIWS_ResponseCode_RequestHeaderFieldsTooLarge const(431);
dcl-c cSIIWS_ResponseCode_UnavailableForLegalReasons const(451);

// 5xx Server Error
dcl-c cSIIWS_ResponseCode_InternalServerError const(500);
dcl-c cSIIWS_ResponseCode_NotImplemented const(501);
dcl-c cSIIWS_ResponseCode_BadGateway const(502);
dcl-c cSIIWS_ResponseCode_ServiceUnavailable const(503);
dcl-c cSIIWS_ResponseCode_GatewayTimeout const(504);
dcl-c cSIIWS_ResponseCode_HTTPVersionNotSupported const(505);
dcl-c cSIIWS_ResponseCode_VariantAlsoNegotiates const(506);
dcl-c cSIIWS_ResponseCode_NotExtended const(510);
dcl-c cSIIWS_ResponseCode_NetworkAuthenticationRequired const(511);

// -----------------------------------------------------------------------------
dcl-s tSIIWS_HttpStatus int(10) template;
dcl-s tSIIWS_HttpHeaderEntry char(512) template;
dcl-s tSIIWS_ResponseCount int(10) template;
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

