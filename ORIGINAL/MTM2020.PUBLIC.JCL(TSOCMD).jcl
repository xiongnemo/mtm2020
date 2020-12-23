//TSOCMD   JOB 1,MSGLEVEL=(0,0)
//TSOCMD   EXEC PGM=IKJEFT01
//SYSTSPRT DD DUMMY
//SYSTSIN  DD *
  netstat stats rep dsn net.stats
