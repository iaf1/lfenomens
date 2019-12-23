      PROGRAM AA
      IMPLICIT NONE
      DOUBLE PRECISION CTIME
      INTEGER I

      DO I=1,10      

      READ(*,*) CTIME
      
      WRITE(*,*) "TEMP CHRONO: ", INT(CTIME/3600), "H", 
     &      MOD(INT(CTIME)/60,60), "MIN", MOD(INT(CTIME),60), "S"
      ENDDO
      END
