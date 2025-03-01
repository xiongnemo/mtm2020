       IDENTIFICATION DIVISION.
       PROGRAM-ID.    ADDONE.
       AUTHOR.        NEMO.
      *
       ENVIRONMENT DIVISION.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRT-LINE ASSIGN TO PRTLINE.
           SELECT PRT-DONE ASSIGN TO PRTDONE.

       DATA DIVISION.
       FILE SECTION.
       FD  PRT-LINE RECORD CONTAINS 80 CHARACTERS RECORDING MODE F.
       01  PRT-REC        PIC X(80) VALUE SPACES.

       FD  PRT-DONE RECORD CONTAINS 80 CHARACTERS RECORDING MODE F.
       01  PRT-REC-DONE.
           05  PRT-DATE     PIC X(8)  VALUE SPACES.
           05  FILLER       PIC X(1)  VALUE SPACES.
           05  PRT-TIME     PIC X(4)  VALUE SPACES.
           05  FILLER       PIC X(2)  VALUE SPACES.
           05  PRT-COMMENT  PIC X(27) VALUE SPACES.
           05  FILLER       PIC X(2)  VALUE SPACES.
           05  PRT-MY-NAME  PIC X(36) VALUE SPACES.

       WORKING-STORAGE SECTION.

       01  PGM-VARIABLES.
           05  PGM-COUNT    PIC 9(05).

       01  YYYYMMDD         PIC 9(8).

       01  INTEGER-FORM     PIC S9(9).

       01  REFMOD-TIME-ITEM PIC X(8).

      ****************************************************************
      *                  PROCEDURE DIVISION                          *
      ****************************************************************
       PROCEDURE DIVISION.
      *
       A000-START.
           OPEN OUTPUT PRT-LINE.
           PERFORM A000-COUNT 10 TIMES.
           PERFORM A000-DONE.
           CLOSE   PRT-LINE.
           STOP RUN.
      *
       A000-COUNT.
           ADD 1 TO PGM-COUNT.
      *    DISPLAY PGM-COUNT.
           WRITE PRT-REC FROM PGM-COUNT.
      *
       A000-DONE.
           OPEN OUTPUT PRT-DONE.
           MOVE SPACES TO PRT-REC-DONE.
           ACCEPT REFMOD-TIME-ITEM FROM TIME.
           MOVE FUNCTION CURRENT-DATE(1:8) TO YYYYMMDD.
           MOVE YYYYMMDD         TO PRT-DATE.
           MOVE REFMOD-TIME-ITEM (1:4) TO PRT-TIME.
           MOVE "Nemo" TO PRT-MY-NAME
           MOVE "My first z/OS COBOL program" TO PRT-COMMENT.
           WRITE PRT-REC-DONE.
           CLOSE PRT-DONE.
