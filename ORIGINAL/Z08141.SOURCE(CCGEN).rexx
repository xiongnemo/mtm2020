/**************************** REXX *********************************/
/* This exec illustrates the use of "EXECIO 0 ..." to open, empty, */
/* or close a file. It reads records from file indd, allocated     */
/* to 'sams.input.dataset', and writes selected records to file    */
/* outdd, allocated to 'sams.output.dataset'. In this example, the */
/* data set 'smas.input.dataset' contains variable-length records  */
/* (RECFM = VB).                                                   */
/*******************************************************************/
"FREE FI(outdd)"
"ALLOC FI(outdd) DA('Z08141.OUTPUT.CUST16') SHR REUSE"
eofflag = 2                 /* Return code to indicate end-of-file */
return_code = 0                /* Initialize return code           */
out_ctr = 0                    /* Initialize # of lines written    */


DO WHILE (out_ctr < 500) /* Loop 500 VAILD OUT   */
    digit_count = 0
    cc_digits = ""
    DO WHILE (digit_count < 16)
        cc_digits = cc_digits || D2C(RANDOM(240, 249))
        digit_count = digit_count + 1
    end
    if luhn(cc_digits) then
    DO
        line_to_write.1 = cc_digits
        "EXECIO 1 DISKW outdd (STEM line_to_write." /* Write it to outdd  */
        out_ctr = out_ctr + 1        /* Increment output line ctr */
    END
END
IF out_ctr > 0 THEN             /* Were any lines written to outdd?*/
  DO                               /* Yes.  So outdd is now open   */
     /****************************************************************/
   /* Since the outdd file is already open at this point, the      */
   /* following "EXECIO 0 DISKW ..." command will close the file,  */
   /* but will not empty it of the lines that have already been    */
   /* written. The data set allocated to outdd will contain out_ctr*/
   /* lines.                                                       */
   /****************************************************************/

  "EXECIO 0 DISKW outdd (FINIS" /* Closes the open file, outdd     */
  SAY 'File outdd now contains ' out_ctr' lines.'
END
ELSE                         /* Else no new lines have been        */
                             /* written to file outdd              */
  DO                         /* Erase any old records from the file*/

   /****************************************************************/
   /* Since the outdd file is still closed at this point, the      */
   /* following "EXECIO 0 DISKW " command will open the file,   */
   /* write 0 records, and then close it.  This will effectively   */
   /* empty the data set allocated to outdd.  Any old records that */
   /* were in this data set when this exec started will now be     */
   /* deleted.                                                     */
   /****************************************************************/

   "EXECIO 0 DISKW outdd (OPEN FINIS"  /*Empty the outdd file      */
   SAY 'File outdd is now empty.'
   END
"FREE FI(outdd)"
EXIT

luhn:
Parse Arg ccn                /* credit card number       */
sum=0                        /* initialize test sum      */
even=0                       /* even indicator           */
Do i=length(ccn) To 1 By -1  /* process all digits       */
  c=substr(ccn,i,1)          /* pick one digit at a time */
  If even Then Do            /* even numbered digit      */
    c=c*2                    /* double it                */
    If c>=10 Then            /* 10, 12, 14, 16, 18       */
      c=c-9                  /* Sum of the two digits    */
    End                      /* end of even numbered     */
  even=\even                 /* flip even indicator      */
  sum=sum+c                  /* add into test sum        */
  End
Return right(sum,1) = 0     /* ok if last digit is 0    */
