variable temp
variable merge-temp

: top-two-vals ( addr addr -- n n )
  over @ over @ ;

: under-val ( addr addr -- addr addr n )
  over @ ;

: diff-top-two ( addr addr -- n )
  2dup - ;

: merge-step ( right mid left -- right mid+ left+ )
  top-two-vals < if
    under-val temp ! 
    diff-top-two over dup cell+ rot move
    temp @ over !
    temp ! cell+ 2dup = if dup else temp @ then
  then cell+ ;

: merge ( right mid left -- right left )
  dup merge-temp ! begin 2dup > while merge-step repeat 2drop merge-temp @ ;
 
: mid ( l r -- mid ) over - 2/ cell negate and + ;
 
: mergesort ( right left -- right left )
  2dup cell+ <= if exit then
  swap 2dup mid recurse rot recurse merge ;
 
: sort ( addr len -- )  cells over + swap mergesort 2drop ;
 
create test 8 , 1 , 5 , 3 , 9 , 0 , 2 , 7 , 6 , 4 ,
 
: .array ( addr len -- ) 0 do dup i cells + @ . loop drop ;
 
test 10 2dup sort .array       \ 0 1 2 3 4 5 6 7 8 9
