PROGRAM test_itp2

USE MD_linear_ITP
IMPLICIT NONE

CHARACTER (LEN=120) :: INPUT_PATH
CHARACTER (LEN=120) :: OUTPUT_PATH
CHARACTER (LEN=120) :: OUTPUT_PATH2


!     +++++++++++++++++++++++++++++
!++++++THE NUMBER OF INTERPOLATION++++++
!     +++++++++++++++++++++++++++++
REAL*8 :: N_ITP = 2.0

!INPUT_NUMBER AND OUTPUT_NUMBER
INTEGER, PARAMETER :: TRA = 23 
INTEGER, PARAMETER :: ROWS = 4096
INTEGER, PARAMETER :: I_N = TRA
INTEGER, PARAMETER :: O_N =  2 * I_N - 1

!INPUT_VALUE AND OUPUT_VALUE
REAL*8, DIMENSION(1, 1:I_N, 1:ROWS) :: I_V 
REAL*8, DIMENSION(1, 1:O_N, 1:ROWS) :: O_V 
REAL*8, DIMENSION(1, 1:O_N, 1:ROWS) :: T_V 

INTEGER :: I, Y, Z, k

INPUT_PATH = "/home/changwan/INTERPOLATION/HILBERT_STACKED_A_GPR.txt"
!INPUT_PATH = "/home/changwan/INTERPOLATION/input_values.txt"
OUTPUT_PATH = "/home/changwan/INTERPOLATION/output_values.txt"
OUTPUT_PATH2 = "/home/changwan/INTERPOLATION/original_values.txt"


OPEN(UNIT=10, FILE=INPUT_PATH, FORM='FORMATTED' &
     , STATUS='OLD',ACTION='READ')
OPEN(UNIT=20, FILE=OUTPUT_PATH, STATUS='REPLACE' &
     , ACTION='WRITE')
!OPEN(UNIT=21, FILE=OUTPUT_PATH2, STATUS='REPLACE' &
!     , ACTION='WRITE')


READ(10,*) I_V

DO Z = 1, ROWS 
!Z = 1
   CALL  linear(N_ITP, I_N, I_V(1,:,Z), O_N, O_V(1,:,Z))   
   PRINT *, "Z=", Z
END DO

DO Z =1, ROWS
!Z = 1
    WRITE(20,*) ( O_V(1, Y, Z), Y = 1, O_N )
END DO



!ORIGINAL DATA
!k = 0
!   DO I = 1, I_N
!      T_V(1,I+k,Z) = I_V(1,I,Z)
!      k = k+1
!   END DO

!Z = 1
!    WRITE(21,*) ( T_V(1, Y, Z), Y = 1, O_N )
!PRINT *, T_V
END PROGRAM
