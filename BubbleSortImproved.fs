variable changed

: sorted? ( b -- b )
    false =
;

: pair ( addr1 n1 b n2 -- addr1 n1 b n2 addr1 addr2 )
    >r rot dup >r -rot r> r>
    2dup
    cells + >r
    1+ cells + r>
    swap
;

: switch? ( addr1 addr2 -- b )
    @ >r @ r> >
;

: switch ( addr1 addr2 -- b )
    dup @ \ addr1 addr2 n2
    rot   \ addr2 n2 addr1
    dup @ \ addr2 n2 addr1 n1
    -rot ! swap !
    drop true
;

: no-change
    false
;

: for-pairs
    over 0
;

: bubble ( addr n -- )
    1-
    begin
	false
	for-pairs do
	    i pair
	    2dup
	    switch?
	    if switch else 2drop then
	loop
	sorted?
    until
    2drop
;

variable testarr 9 cells allot

: gen-test-data
    10 0 do 10 i - testarr i cells + ! loop
;

: display-test-data
    10 0 do testarr i cells + ? cr loop
;

: run-test
    gen-test-data
    display-test-data cr
    testarr 10 bubble
    display-test-data
;
