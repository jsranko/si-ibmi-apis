         /if not defined(STATP)
         /define STATP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Constants
        //==========================================================================================

         dcl-c cSTAT_SUCCESSFUL const(0);
         dcl-c cSTAT_NOT_SUCCESSFUL const(-1);

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tSTAT_Return int(10) template;
         dcl-s tSTAT_FileMode uns(10) template;
         dcl-s tSTAT_FileSerialNumber uns(10) template;
         dcl-s tSTAT_NumberOfLinks uns(5) template;
         dcl-s tSTAT_UserID uns(10) template;
         dcl-s tSTAT_GroupID uns(10) template;
         dcl-s tSTAT_FileSize int(20) template;
         dcl-s tSTAT_Time int(10) template;
         dcl-s tSTAT_DeviceID uns(10) template;
         dcl-s tSTAT_Size uns(10) template;
         dcl-s tSTAT_AllocSize uns(20) template;
         dcl-s tSTAT_ObjectTypeAS400 char(11) template;
         dcl-s tSTAT_CodePage uns(5) template;
         dcl-s tSTAT_CCSID    uns(5) template;
         dcl-s tSTAT_NumberOfLinks32 uns(10) template;
         dcl-s tSTAT_DeviceID64 uns(20) template;
         dcl-s tSTAT_FileSerialNumberGenerationId uns(10) template;

         dcl-ds tSTAT qualified align template;
         // File mode
           st_mode LIKE(tSTAT_FileMode);
         // File serial number
           st_ino LIKE(tSTAT_FileSerialNumber);
         // Number of links
           st_nlink LIKE(tSTAT_NumberOfLinks);
         // Reserved
           st_reserved2 uns(5);
         // User ID of the owner of file
           st_uid LIKE(tSTAT_UserID);
         // Group ID of the group of file
           st_gid  like(tSTAT_GroupID);
         // For regular files, the file size in bytes
           st_size like(tSTAT_FileSize);
         // Time of last access
           st_atime  like(tSTAT_Time);
         // Time of last data modification
           st_mtime  like(tSTAT_Time);
         // Time of last file status change
           st_ctime  like(tSTAT_Time);
         // ID of device containing file
           st_dev  like(tSTAT_DeviceID);
         // Size of a block of the file
           st_blksize  like(tSTAT_Size);
         // Allocation size of the file
           st_allocsize like(tSTAT_AllocSize);
         // AS/400 object type
           st_objtype  like(tSTAT_ObjectTypeAS400);
         // Reserved
           st_reserved3 char(1);
         // Object data codepage
           st_codepage like(tSTAT_CodePage);
         // Object data ccsid
           st_ccsid  like(tSTAT_CCSID);
         // Device ID (if character special or block special file)
           st_rdev like(tSTAT_DeviceID);
         // Number of links-32 bit
           st_nlink32  like(tSTAT_NumberOfLinks32);
         // Device ID - 64 bit form
           st_rdev64 like(tSTAT_DeviceID64);
         // ID of device containing file - 64 bit form
           st_dev64  like(tSTAT_DeviceID64);
         // Reserved
           st_reserved1 char(36);
         // File serial number generation id
           st_ino_gen_id like(tSTAT_FileSerialNumberGenerationId);
         end-ds;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr stat like(tSTAT_Return) extproc(*dclcase);
           Path pointer value options(*string);
           Stat pointer value;
         end-pr;
