VARIABLE CHANGED

0 CHANGED !

: DUP-FIRST
  DUP @
;

: ADDR-OF-SECOND
  DUP 1 CELLS +
;

: MOVE-SECOND-VALUE-TO-FIRST
  @ OVER !
;

: INC-ADDR
  1 CELLS +
;

: SWAPPER ( ADDR -- )
  DUP-FIRST >R
  ADDR-OF-SECOND
  MOVE-SECOND-VALUE-TO-FIRST
  R> SWAP                              \ Retrieve first value and swap with addr so addr is on top of stack
  INC-ADDR
  !                                    \ Store first value in second
;

: SWAP-IF ( ADDR -- )
  DUP @
  OVER 1 CELLS + @
  > IF
    SWAPPER
    -1 CHANGED !
  ELSE
    DROP                               \ If we don't swap then addr will not be consumed so do that here
  THEN
;

: BUBBLE-SORT ( ADDR N -- )
  1 -
  BEGIN
    2DUP
    0 CHANGED !
    0 DO
      DUP I CELLS +
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
  DISPLAY-TEST-DATA
;