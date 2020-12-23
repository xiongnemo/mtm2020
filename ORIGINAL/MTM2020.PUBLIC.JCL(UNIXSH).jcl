//UNIXSH   JOB 1,NOTIFY=&SYSUID
//* --------------------------
//SHELL    EXEC PGM=BPXBATCH
//STDOUT   DD SYSOUT=*
//STDERR   DD SYSOUT=*
//STDPARM  DD *
sh echo ' '                               ;
echo '+---------------------------+'      ;
echo '| copy files                |'      ;
echo '+---------------------------+'      ;
echo ' '                                  ;
cp /z/public/hello hello                  ;
cp /z/public/zoamerge zoamerge            ;
cp /z/public/luhn.py luhn.py              ;
cp /z/public/uss2script.sh uss2script.sh  ;
mkdir mtmdirectory                        ;
cd mtmdirectory                           ;
cp /z/mtmdirectory/inhere inhere
/*
