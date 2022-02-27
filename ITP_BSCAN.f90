PROGRAM test_itp2

USE MD_linear_ITP
IMPLICIT NONE

CHARACTER (LEN=120) :: INPUT_PATH
CHARACTER (LEN=120) :: OUTPUT_PATH
CHARACTER (LEN=120) :: OUTPUT_PATH2


!     +++++++++++++++++++++++++++++++++++++++
!++++++THE DIFFERENCE OF INTERPOLATED NUMBER+++++
!     +++++++++++++++++++++++++++++++++++++++
REAL*8 :: D_ITP = 9.0
INTEGER, PARAMETER :: D_ITP2 = 9

!     +++++++++++++++++++++++++++++++++++
!++++++THE NUMBER OF INTERPOLATED VALUES++++++
!     +++++++++++++++++++++++++++++++++++
INTEGER, PARAMETER :: ITP_N = D_ITP2 - 1

!INPUT_NUMBER AND OUTPUT_NUMBER
INTEGER, PARAMETER :: TRA = 50
!INTEGER, PARAMETER :: TRA = 35
!INTEGER, PARAMETER :: TRA = 6


INTEGER, PARAMETER :: ROWS = 4096
INTEGER, PARAMETER :: I_N = TRA
INTEGER, PARAMETER :: O_N = I_N + ITP_N * (I_N-1)  

!INPUT_VALUE AND OUPUT_VALUE
REAL*8, DIMENSION(1, 1:I_N, 1:ROWS) :: I_V 
REAL*8, DIMENSION(1, 1:O_N, ROWS) :: O_V 
REAL*8, DIMENSION(1, 1:O_N, ROWS) :: T_V 

INTEGER :: I, Y, Z, k

!INPUT_PATH = "/home/changwan/INTERPOLATION/HILBERT_STACKED_A_GPR.txt"
!INPUT_PATH = "/home/changwan/INTERPOLATION/HILBERT_BSCAN_STACKED_IMAGE.txt"
!INPUT_PATH = "/home/changwan/GPR_DATA/KOREA/INBO_ri/220223_4.PRJ/output.txt"
INPUT_PATH = "/home/changwan/GPR_DATA/KOREA/INBO_ri/220223_4.PRJ/dB_output.txt"



!INPUT_PATH = "/home/changwan/INTERPOLATION/input_values.txt"
OUTPUT_PATH = "/home/changwan/GPR_DATA/KOREA/INBO_ri/220223_4.PRJ/ITP_dB_output.txt"
!OUTPUT_PATH2 = "/home/changwan/INTERPOLATION/original_values.txt"


OPEN(UNIT=10, FILE=INPUT_PATH, FORM='FORMATTED' &
     , STATUS='OLD',ACTION='READ')
OPEN(UNIT=20, FILE=OUTPUT_PATH, STATUS='REPLACE' &
     , ACTION='WRITE')
!OPEN(UNIT=21, FILE=OUTPUT_PATH2, STATUS='REPLACE' &
!     , ACTION='WRITE')


READ(10,*) I_V


DO Z = 1, ROWS 
!Z = 1
   CALL  linear(D_ITP, I_N, I_V(1,:,Z), O_N, O_V(1,:,Z))   
   PRINT *, "Z=", Z
END DO

DO Z =1, ROWS
!Z = 1
    WRITE(20,*) ( O_V(1, Y, Z), Y = 1, O_N )
END DO


PRINT *, "I_N=",I_N
PRINT *, "O_N=",O_N
!ORIGINAL DATA
!   DO I = 1, I_N
!      T_V(1,I+(ITP_N*(I-1)),Z) = I_V(1,I,Z)
!   END DO

!Z = 1
!    WRITE(21,*) ( T_V(1, Y, Z), Y = 1, O_N )
!PRINT *, T_V(1,:,1)

END PROGRAM
