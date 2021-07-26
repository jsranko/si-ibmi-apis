         /if not defined(QTEDBGSP)
         /define QTEDBGSP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        // Constants
        //==========================================================================================

        dcl-c cQtedbgs_DebugAttribute_UPDPROD const('*UPDPROD');
        dcl-c cQtedbgs_DebugAttribute_DEBUGJOB const('*DEBUGJOB');
        dcl-c cQtedbgs_DebugAttribute_OPMSRC const('*OPMSRC');
        dcl-c cQtedbgs_AttributeValue_YES const('*YES');
        dcl-c cQtedbgs_AttributeValue_NO const('*NO');
        dcl-c cQtedbgs_AttributeValue_LOCAL const('*LOCAL');
        dcl-c cQtedbgs_AttributeValue_REMOTE const('*REMOTE');
        //==========================================================================================
        // Tempaltes
        //==========================================================================================

        dcl-s tQtedbgs_DebugAttribute char(10) template;
        dcl-s tQtedbgs_AttributeValue char(10) template;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

        dcl-pr QteRetrieveDebugAttribute extproc(*dclcase);
          DebugAttribute like(tQtedbgs_DebugAttribute) const;
          AttributeValue like(tQtedbgs_AttributeValue);
          ErrorCode likeds(tQUSEC);
        end-pr;
