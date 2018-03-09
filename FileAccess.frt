: create-name ( -- fileid )
s" name.txt" 4 create-file drop ;

: get-name ( -- u )
." Name: " pad 40 accept ;

: write-name ( fileid u -- ior )
pad rot rot swap write-line ;

: rec-name ( -- ior )
create-name dup get-name write-name drop close-file ;