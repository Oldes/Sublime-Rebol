; SYNTAX TEST "Packages/Rebol/Rebol.sublime-syntax"

 LEX_DELIMIT: charset [
    #"^(00)" ; null
    #"^(0A)" ; LF
    #"^(0D)" ; CR
    #"^(20)" ; SPACE
    #"^(22)" ; QUOTE `"`
    "()/;[]{}"
] ; ==> '\x00\x0A\x0D\x20\x22\(\)/;\[\]{}'

;----
;^^^^ comment.docline.rebol punctuation.definition.comment.begin.rebol

;@@ foo
;^^ comment.todo.rebol punctuation.definition.comment.todo.rebol
;   ^^^ comment.todo.rebol
;  aaa
;  ^^^ comment.line.rebol

#!/usr/bin/rebol
;^^^^^^^^^^^^^^^^ comment.line.shebang.rebol

;----------------------------------------------------------------
;-- integer! decimal!                                            
  111
; ^^^ constant.numeric.rebol
;     ^ keyword.operator.arithmetic.rebol
  1' ;@@ valid in Rebol but not in Red!
; ^^ constant.numeric.rebol
;  ^ constant.numeric.rebol punctuation.separator.quote.rebol
  1'000'000
; ^^^^^^^^^
;  ^ constant.numeric.rebol punctuation.separator.quote.rebol
  1.0
; ^^^ constant.numeric.rebol
;  ^ constant.numeric.rebol punctuation.separator.decimal.rebol
  1'000.0
; ^^^^^^^ constant.numeric.rebol
  2e1
; ^^^ constant.numeric.rebol
;  ^ constant.numeric.rebol constant.numeric.exponent.rebol punctuation.separator.exponent.rebol
  2.0e2
; ^^^^^ constant.numeric.rebol
;  ^ constant.numeric.rebol punctuation.separator.decimal.rebol
;    ^ constant.numeric.rebol constant.numeric.exponent.rebol punctuation.separator.exponent.rebol
  -2 + 2
; ^^ constant.numeric.rebol
; ^ constant.numeric.rebol punctuation.definition.numeric.sign.rebol
  2e+1
; ^^^^ constant.numeric.rebol
;  ^ constant.numeric.rebol constant.numeric.exponent.rebol punctuation.separator.exponent.rebol
;   ^ constant.numeric.rebol constant.numeric.exponent.rebol punctuation.definition.numeric.sign.rebol
;    ^ constant.numeric.rebol constant.numeric.exponent.rebol

  1.#inf
; ^^^^^^ constant.numeric.rebol
  +1.#inf
  -1.#INF
  1.#nan
  +1.#NaN
; ^^^^^^^ constant.numeric.rebol
; ^ constant.numeric.rebol punctuation.definition.numeric.sign.rebol

;----------------------------------------------------------------
;-- logic! none!                                                 
  true false none
; ^^^^ constant.language.rebol
;      ^^^^^ constant.language.rebol
;            ^^^^ constant.language.rebol

;----------------------------------------------------------------
;-- time!                                                        
  1:00
; ^^^^ constant.numeric.time.rebol
;  ^ constant.numeric.time.rebol punctuation.separator.time.rebol
;   ^^ constant.numeric.time.rebol
  1:00am
; ^^^^^^ constant.numeric.time.rebol
;     ^^ constant.numeric.time.rebol storage.type.ampm.rebol

 1:00:00
 1:00:00.01
 1:00:00,02
+1:00
+1:00:00
+1:00:00.01
+1:00:00,02
 1:00am
 1:00:00am
 1:00:00.01am
 1:00:00,02am
+1:00am
+1:00:00am
+1:00:00.01am
+1:00:00,02am
 10:0
 10:0
 10:0:00
 10:0:00.01
 10:0:00,02
+10:0
+10:0:00
+10:0:00.01
+10:0:00,02
 10:0am
 10:0:00am
 10:0:00.01am
 10:0:00,02am
+10:0am
+10:0:00am
+10:0:00.01am
+10:0:00,02am
 10:00
 10:00
 10:00:00
 10:00:00.01
 10:00:00,02
+10:00
+10:00:00
+10:00:00.01
+10:00:00,02
 10:00am
 10:00:00am
 10:00:00.01am
 10:00:00,02am
+10:00am
+10:00:00am
+10:00:00.01am
+10:00:00,02am

;----------------------------------------------------------------
;-- pair!                                                        
    2x2
;   ^^^ constant.numeric.pair.rebol
;    ^ constant.numeric.pair.rebol storage.type.numeric.pair.rebol
    0x0.5
;     ^^^ constant.numeric.pair.rebol
  0.5x0
; ^^^^^ constant.numeric.pair.rebol
;    ^ constant.numeric.pair.rebol storage.type.numeric.pair.rebol
;     ^ constant.numeric.pair.rebol
  2.2x3.4
;     ^^^ constant.numeric.pair.rebol
  2e2x1
; ^^^^^ constant.numeric.pair.rebol
  1.#InFx1.#NaN
; ^^^^^^ constant.numeric.pair.rebol constant.numeric.pair.special.rebol
  -1.0x+2.0

;----------------------------------------------------------------
;-- string                                                       
  "a;b"
;  ^^^^^ string.quoted.double.rebol
;  ^ string.quoted.double.rebol punctuation.definition.string.begin.rebol
;      ^ string.quoted.double.rebol punctuation.definition.string.end.rebol
  "a{b"
  {a;b}
;  ^^^^^ string.quoted.double.rebol
;  ^ string.quoted.double.rebol punctuation.definition.string.begin.rebol
;      ^ string.quoted.double.rebol punctuation.definition.string.end.rebol


;----------------------------------------------------------------
;-- char!                                                        
  #"a"
; ^^^^ constant.character.literal.rebol
; ^ constant.character.literal.rebol storage.modifier.rebol
;  ^ constant.character.literal.rebol punctuation.definition.character.begin.rebol
;    ^ constant.character.literal.rebol punctuation.definition.character.end.rebol
  #";"
; ^^^^ constant.character.literal.rebol
;  ^ constant.character.literal.rebol punctuation.definition.character.begin.rebol
  #"^/"
;   ^^ constant.character.literal.rebol constant.character.escape.rebol
  #"^(00)"
  #"^(tab)"
; ^^^^^^^^^ constant.character.literal.rebol
;   ^^^^^^ constant.character.literal.rebol constant.character.escape.rebol
  #"" ; valid, same like #"^@"
; ^^^ constant.character.literal.rebol

; invalid chars:
  #"foo"  #"^ab"  #"^(tab)x" #"^(00000)"


;----------------------------------------------------------------
;-- hex number (Red only)                                        
  FFh
  0Ah
  01AAh
  AAAAAAh
  AAAAAAAAh
; ^^^^^^^^^ constant.numeric.hex.rebol
;         ^ constant.numeric.hex.rebol storage.type.numeric.hex.rebol
;these should not be recognized as valid numbers:
0h Ah AAAAAAAAAAh aah

  " ^(0) ^(00) ^(000) invalid:^(0000a)"
; ^ string.quoted.double.rebol punctuation.definition.string.begin.rebol
;  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string.quoted.double.rebol  
;                              ^ string.quoted.double.rebol invalid.rebol invalid.illegal.rebol
;-- map!
  #(a: 1 b: 2)
; ^^ meta.mapping.rebol punctuation.section.mapping.begin.rebol
; ^ meta.mapping.rebol punctuation.section.mapping.begin.rebol storage.modifier.rebol
;   ^ meta.mapping.rebol entity.name.word.set.rebol
;            ^ meta.mapping.rebol punctuation.section.mapping.end.rebol

;-- Construction syntax
#[true]
#[false]
#[none]
#[unset!]
#[logic! 0]
#[string! "abc" 2]
#[f32![1 2 3 4]]
my-image: #[image! 2x2 #{FFFFFFFFFFFFFFFFFFFFFFFF}]
my-block:  [image! 2x2 #{FFFFFFFFFFFFFFFFFFFFFFFF}]
;with comments inside:
#[
  binary! ; type
  #{f00d} ; series
  2       ; index
]
  #[logic! 0]
; ^^^^^^^^^^^ meta.construct.rebol
; ^^ meta.construct.rebol punctuation.section.construct.begin.rebol
; ^ meta.construct.rebol punctuation.section.construct.begin.rebol storage.modifier.rebol
;   ^^^^^^ meta.construct.rebol storage.type.datatype.rebol
;          ^ meta.construct.rebol constant.numeric.rebol
;           ^ meta.construct.rebol punctuation.section.construct.end.rebol

  #[true]

;----------------------------------------------------------------
;-- binary!                                                      

  #{F00D}
; ^^ binary.base16.rebol string.binary.prefix
;   ^^^^ binary.base16.rebol string.binary.base16.rebol
;       ^ binary.base16.rebol string.binary.prefix

  16#{F00D}
; ^^^^ binary.base16.rebol string.binary.prefix

  64#{8A0=}
; ^^^^ binary.base64.rebol string.binary.prefix
;     ^^^^ binary.base64.rebol string.binary.base64.rebol

  2#{0000 1100}
; ^^^ binary.base2.rebol string.binary.prefix
;    ^^^^^^^^^ binary.base2.rebol string.binary.base2.rebol

;----------------------------------------------------------------
;-- tag!                                                         
  <tag>
; ^^^^ entity.tag.rebol entity.other.namespace.xml
  <tag name="foo" id='id'/>
;  ^^^^^^^^ entity.tag.rebol entity.other.namespace.xml
;           ^^^^^ entity.tag.rebol string.quoted.double.xml
;                 ^^ entity.tag.rebol entity.other.namespace.xml
;                    ^^^^ entity.tag.rebol string.quoted.single.xml

<---> ;<-- this is word! in Red, not a tag!

;----------------------------------------------------------------
;-- url!                                                         


  http://user:pass@host:80/path?query#tag
; ^^^^ string.url.rebol string.url.scheme.rebol
;     ^^^ string.url.rebol storage.type.url.rebol
;                          ^^^^^^^^^^^^^^^ string.url.rebol
  scheme:/
; ^^^^^^ string.url.rebol string.url.scheme.rebol
;       ^^ string.url.rebol storage.type.url.rebol
  scheme://
  scheme:host
  mailto:user@foo.com

  path/:a ;<-- not url!


;----------------------------------------------------------------
;-- set-word! get-word!                                          

  value: 111
; ^^^^^ entity.name.word.set.rebol
;      ^ keyword.operator.assignment.rebol

  :value
; ^ keyword.operator.assignment.rebol
;  ^^^^^ entity.name.word.get.rebol

  word's:
  >>:

; true, false and none are not colorized as set-words
; to warn that it's not recommended
true: false: none:

;----------------------------------------------------------------
;-- lit-word!                                                    

  'value
; ^ keyword.operator.quote.rebol
;  ^^^^^ entity.name.word.lit.rebol
; these are valid lit-words:
  'value''''
  '_'
  '_'_
  '>>>>

; these are invalid lit-words:
  '2nd ''foo ':foo '@ref

;----------------------------------------------------------------
;-- refinement!                                                  

  /refinement
; ^ keyword.operator.refinement.rebol
;  ^^^^^^^^^^ entity.name.word.refinement.rebol

  /2nd /<< />>

  path/foo/3

;----------------------------------------------------------------
;-- datatype!                                                    

  integer!
; ^^^^^^^^ storage.type.datatype.rebol
;        ^ storage.type.datatype.rebol storage.type.punctuation.rebol

;----------------------------------------------------------------
;-- function!                                                    

 foo: function [
;^^^ entity.name.function.rebol
    "Some description"
    argument [any-value!] "description"
    /refinement
     value [string!] "description"
     ;comment
 ][
    ;function body
    if refinement [return value]
    argument
 ]

 ctx: context [
;^^^ entity.name.class.rebol
  foo: 1
 ]

 my-module: module [][]
;^^^^^^^^^ entity.name.function.rebol
