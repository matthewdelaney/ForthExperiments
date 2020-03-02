\ This is a more factored version of the Merge Sort example from Rosetta Code
\ Since the original was covered by the GNU FDL v1.2, this is as well. See fdl-1.2.txt.
\
\ Rosetta Code version: Copyright (c)  2009  Ian Osgood.
\ My changes:           Copyright (c)  2020  Matthew Delaney.
\ Permission is granted to copy, distribute and/or modify this document
\ under the terms of the GNU Free Documentation License, Version 1.2
\ or any later version published by the Free Software Foundation;
\ with no Invariant Sections, no Front-Cover Texts, and no Back-Cover
\ Texts.  A copy of the license is included in the section entitled "GNU
\ Free Documentation License".

variable temp
variable merge-temp

: 2dup* ( addr addr -- n n )
  over @ over @ ;

: over* ( addr addr -- addr addr n )
  over @ ;

: diff-top-two ( addr addr -- n )
  2dup - ;

: stash-over* ( addr addr -- addr addr ) over* temp ! ;

: set-up-diff-move ( addr1 addr2 -- addr1 addr2 addr2 addr2+ addr1-addr2 ) diff-top-two over dup cell+ rot ;

: move-diff-cells ( addr addr -- addr addr ) set-up-diff-move move ;

: get-stash temp @ ;

: put-stash temp ! ;

: merge-step ( right mid left -- right mid+ left+ )
  2dup* < if					\ Is mid less than left? ( right mid left )
    stash-over*					\ If so, store mid* in temp ( right mid left )
    move-diff-cells				\ Move (mid-left) cells from left to left+ ( right mid left )
    get-stash over !				\ Retrieve mid* and store in left ( right mid left ) 
    put-stash cell+				\ Store left in temp and increment mid ( right mid+ ) 
    2dup = if dup else get-stash then		\ If right == mid+ then dup mid+ else retrieve left ( right mid+ mid+|left )
  then cell+ ~~ ;				\ Increment mid+|left ( right mid+ mid++|left+ )

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
 
create test 8 , 1 , 3 , 5 , 9 , 4 , 6 , 2 , 7 , 0 ,
 
: .array ( addr len -- ) 0 do dup i cells + @ . loop drop ;
 
test 10 2dup sort .array       \ 0 1 2 3 4 5 6 7 8 9
