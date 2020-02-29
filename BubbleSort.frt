VARIABLE CHANGED

0 CHANGED !

: GET-VAL-OF 
  DUP @
;

: NEXT-ADDR 
  DUP 1 CELLS +
;

: STORE-VAL-IN-UNDER-ADDR 
  @ OVER !
;

: INC-ADDR
  1 CELLS +
;

: SWAP-ADJ-VALS ( ADDR -- )
  GET-VAL-OF >R
  NEXT-ADDR 
  STORE-VAL-IN-UNDER-ADDR 
  R> SWAP                              \ Retrieve first value and swap with addr so addr is on top of stack
  INC-ADDR
  !                                    \ Store first value in second
;

: GET-VAL-OF-UNDER-ADDR ( ADDR -- N )
  OVER 1 CELLS + @ ;

: RESET-CHANGE-FLAG ( -- )
  0 CHANGED ! ;

: SET-CHANGE-FLAG ( -- )
  -1 CHANGED ! ;

: PUSH-N'TH-ADDR ( ADDR N -- ADDR )
  OVER SWAP CELLS + ;

: SWAP-IF ( ADDR -- )
  GET-VAL-OF 
  GET-VAL-OF-UNDER-ADDR
  > IF
    SWAP-ADJ-VALS 
    SET-CHANGE-FLAG
  ELSE
    DROP                               \ If we don't swap then addr will not be consumed so do that here
  THEN
;

: BUBBLE-SORT ( ADDR N -- )
  1 -
  BEGIN
    2DUP
    RESET-CHANGE-FLAG
    0 DO
      I PUSH-N'TH-ADDR
      SWAP-IF
    LOOP
    DROP                               \ Remove left-over duplicated ADDR
    CHANGED @ INVERT
  UNTIL
;

VARIABLE TESTARR 9 CELLS ALLOT

: GEN-TEST-DATA
  10 0 DO 10 I - TESTARR I CELLS + ! LOOP
;

: DISPLAY-TEST-DATA
  10 0 DO TESTARR I CELLS + ? CR LOOP
;

: RUN-TEST
  GEN-TEST-DATA
  TESTARR 10 BUBBLE-SORT
  CR
  DISPLAY-TEST-DATA
;
