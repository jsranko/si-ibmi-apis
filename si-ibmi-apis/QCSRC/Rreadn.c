#include <stdio.h>
#include <stdlib.h>
#include <recio.h>
 
int main(void)
{
    _RFILE      *fp;
    _XXOPFB_T   *opfb;
    _RIOFB_T    *fb;
 
    /* Open the file for processing in arrival sequence.             */
    if (( fp = _Ropen ( "$(LIBRARY)/MY_EMP", "rr+, arrseq=Y" )) == NULL )
    {
        printf ( "Open failed\n" );
        exit ( 1 );
    }
 
    /* Get the library and file names of the file opened.            */
    opfb = _Ropnfbk ( fp );
    printf ( "Library: %10.10s\nFile:    %10.10s\n",
              opfb->library_name,
              opfb->file_name);
 
    /* Get the first record.                                         */
    _Rreadf ( fp, NULL, 20, __DFT );
    printf ( "First record:  %10.10s\n", *(fp->in_buf) );
 
    /* Delete the second record.                                     */
    fb = _Rreadn ( fp, NULL, 20, __DFT );
    _Rdelete ( fp );
 
    _Rclose ( fp );
}
