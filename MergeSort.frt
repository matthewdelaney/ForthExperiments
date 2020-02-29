\ This is a more factored version of the Merge Sort example from Rosetta Code

variable temp
variable merge-temp

: top-two-vals ( addr addr -- n n )
  over @ over @ ;

: under-val ( addr addr -- addr addr n )
  over @ ;

: diff-top-two ( addr addr -- n )
  2dup - ;

: merge-step ( right mid left -- right mid+ left+ )
  top-two-vals < if				\ Is mid less than left?
    under-val temp !				\ If so, store mid in temp 
    diff-top-two over dup cell+			\ ( right mid left (mid-left) left left+
    rot move					\ Bring (mid-left) to top and MOVE
    temp @ over !				\ Retrieve mid and store in left
    temp ! cell+ 2dup = if dup else temp @ then 
  then cell+ ;

: merge ( right mid left -- right left )
  dup merge-temp ! begin 2dup > while merge-step repeat 2drop merge-temp @ ;
 
: mid ( l r -- mid ) over - 2/ cell negate and + ;
 
: mid-addr ( right left -- left right mid )
  swap 2dup mid ;

: mergesort ( right left -- right left )
  2dup cell+ <= if exit then
  mid-addr recurse				\ Call with ( right mid )
  rot
  recurse					\ Call with ( mid left )
  merge ;					\ Merge right and left
 
: sort ( addr len -- )  cells over + swap mergesort 2drop ;
 
create test 8 , 1 , 5 , 3 , 9 , 0 , 2 , 7 , 6 , 4 ,
 
: .array ( addr len -- ) 0 do dup i cells + @ . loop drop ;
 
test 10 2dup sort .array       \ 0 1 2 3 4 5 6 7 8 9
