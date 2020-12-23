       IDENTIFICATION DIVISION.
       PROGRAM-ID.    TOPACCTS.
       AUTHOR.        NEMO.
      *
       ENVIRONMENT DIVISION.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCTS-REC-IN ASSIGN TO ACCTSIN.
           SELECT ACCTS-REC-OUT ASSIGN TO TOPACCT.
           SELECT ACCTS-REC-COUNT-OUT ASSIGN TO TOPACCT.

       DATA DIVISION.
       FILE SECTION.
       FD  ACCTS-REC-OUT RECORDING MODE F.
       01  PRINT-ACCTS-REC-OUT.
           05  FIRST-NAME-OUT      PIC X(15).
           05  LAST-NAME-OUT       PIC X(15).
           05  FILLER              PIC X(05) VALUE SPACES.
           05  ACCT-BALANCE-OUT    PIC 9,999,999.99.
           05  FILLER              PIC X(33) VALUE SPACES.

       FD  ACCTS-REC-COUNT-OUT RECORDING MODE F.
       01  PRINT-ACCTS-REC-COUNT.
           05  ACCTS-REC-COUNT         PIC 9(2).
           05  RESERVED                PIC X(78).

       FD  ACCTS-REC-IN RECORDING MODE F.
       01  ACCTS-REC.
           05  FIRST-NAME          PIC X(11).
           05  LAST-NAME           PIC X(22).
           05  START-TIME          PIC X(11).
           05  END-TIME            PIC X(17).
           05  ACCT-BALANCE        PIC 9,999,999.99.
           05  RESERVED            PIC X(7).


       WORKING-STORAGE SECTION.

       01  LAST-REC         PIC X(1).

       01  ACCT-COUNT       PIC 9(1).

      ****************************************************************
      *                  PROCEDURE DIVISION                          *
      ****************************************************************
       PROCEDURE DIVISION.

       OPEN-FILES.
           OPEN INPUT ACCTS-REC-IN.
           OPEN OUTPUT ACCTS-REC-OUT.

       READ-NEXT-RECORD.
           PERFORM READ-RECORD
              PERFORM UNTIL LAST-REC = 'Y'
              PERFORM WRITE-RECORD
              PERFORM READ-RECORD
              END-PERFORM.

       CLOSE-STOP.
           DISPLAY ACCT-COUNT.
           OPEN OUTPUT ACCTS-REC-COUNT-OUT.
           MOVE ACCT-COUNT TO ACCTS-REC-COUNT.
           WRITE PRINT-ACCTS-REC-COUNT.
           CLOSE ACCTS-REC-COUNT-OUT.
           CLOSE ACCTS-REC-IN.
           CLOSE ACCTS-REC-OUT.
           STOP RUN.

       WRITE-RECORD.
           MOVE ALL SPACES TO PRINT-ACCTS-REC-OUT
           MOVE FIRST-NAME TO FIRST-NAME-OUT.
           MOVE LAST-NAME TO LAST-NAME-OUT.
           MOVE ACCT-BALANCE TO ACCT-BALANCE-OUT.
           IF ACCT-BALANCE(1:1) IS NUMERIC THEN
               IF ACCT-BALANCE(1:1) > 8 THEN
                   ADD 1 TO ACCT-COUNT
                   WRITE PRINT-ACCTS-REC-OUT
               END-IF
               IF ACCT-BALANCE(1:1) = 8 THEN
                   IF ACCT-BALANCE(3:3) >= 5 THEN
                       ADD 1 TO ACCT-COUNT
                       WRITE PRINT-ACCTS-REC-OUT
                   END-IF
               END-IF
           END-IF.

       READ-RECORD.
           READ ACCTS-REC-IN
           AT END MOVE 'Y' TO LAST-REC
           END-READ.






