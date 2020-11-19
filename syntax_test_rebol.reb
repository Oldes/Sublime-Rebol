// SYNTAX TEST "Packages/Rebol3/Rebol.sublime-syntax"

 LEX_DELIMIT: charset [
    #"^(00)" ; null
    #"^(0A)" ; LF
    #"^(0D)" ; CR
    #"^(20)" ; SPACE
    #"^(22)" ; QUOTE `"`
    "()/;[]{}"
] ; ==> '\x00\x0A\x0D\x20\x22\(\)/;\[\]{}'

;----
//^ comment.docline.rebol punctuation.definition.comment.begin.rebol
;@@ foo
//^ comment.todo.rebol punctuation.definition.comment.begin.rebol
//  ^^^ comment.todo.rebol
;  aaa
// ^^^ entity.tag.rebol comment.line.rebol

;----------------------------------------------------------------
;-- integer! decimal!                                            
  111
//^^^ constant.numeric.rebol
  1.0
//^^^ constant.numeric.rebol
// ^ constant.numeric.rebol punctuation.separator.decimal.rebol
  2e1
//^^^ constant.numeric.rebol
// ^ constant.numeric.rebol punctuation.separator.exponent.rebol
  2.0e2
//^^^^^ constant.numeric.rebol
// ^ constant.numeric.rebol punctuation.separator.decimal.rebol
//   ^ constant.numeric.rebol punctuation.separator.exponent.rebol
  -2
//^^ constant.numeric.rebol
  2e+1
//^^^^ constant.numeric.rebol
// ^ constant.numeric.rebol constant.numeric.exponent.rebol punctuation.separator.exponent.rebol
//  ^^ constant.numeric.rebol constant.numeric.exponent.rebol

  1.#inf
//^^^^^^ constant.numeric.rebol
  +1.#inf
  -1.#INF
  1.#nan
  +1.#NaN
//^^^^^^^ constant.numeric.rebol

;----------------------------------------------------------------
;-- logic! none!                                                 
  true false none
//^^^^ constant.language.rebol
//     ^^^^^ constant.language.rebol
//           ^^^^ constant.language.rebol

;----------------------------------------------------------------
;-- time!                                                        
  1:00
//^^^^ constant.numeric.time.rebol
// ^ constant.numeric.time.rebol punctuation.separator.time.rebol
//  ^^ constant.numeric.time.rebol
  1:00am
//^^^^^^ constant.numeric.time.rebol
//    ^^ constant.numeric.time.rebol storage.type.ampm.rebol

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
//  ^^^ constant.numeric.pair.rebol
//   ^ constant.numeric.pair.rebol storage.type.numeric.pair.rebol
    0x0.5
//    ^^^ constant.numeric.pair.rebol
  0.5x0
//^^^^^ constant.numeric.pair.rebol
//   ^ constant.numeric.pair.rebol storage.type.numeric.pair.rebol
//    ^ constant.numeric.pair.rebol
  2.2x3.4
//    ^^^ constant.numeric.pair.rebol
  2e2x1
//^^^^^ constant.numeric.pair.rebol
  1.#InFx1.#NaN
//^^^^^^^^^^^^^ constant.numeric.pair.rebol
//^^^^^^ constant.numeric.pair.rebol constant.numeric.pair.special.rebol


;----------------------------------------------------------------
;-- hex number (Red only)                                        
  FFh
  0Ah
  01AAh
  AAAAAAh
  AAAAAAAAh
//^^^^^^^^^ constant.numeric.hex.rebol
//        ^ constant.numeric.hex.rebol storage.type.numeric.hex.rebol
;these should not be recognized as valid numbers:
0h Ah AAAAAAAAAAh aah

;----------------------------------------------------------------
;-- tag!                                                         
  <tag>
//^^^^ entity.tag.rebol entity.other.namespace.xml
  <tag name="foo" id='id'/>
//^^^^^^^^^ entity.tag.rebol entity.other.namespace.xml
//    ^^^^^ entity.tag.rebol entity.other.namespace.xml
//         ^^^^^^^^^^^^^^^^ entity.tag.rebol
//          ^^^^^ entity.tag.rebol string.quoted.double.xml
//                   ^^^^ entity.tag.rebol string.quoted.single.xml

<---> ;<-- this is word! in Red, not a tag!

;----------------------------------------------------------------
;-- set-word! get-word!                                          

  value: 111
//^^^^^ entity.name.word.set.rebol
//     ^ keyword.operator.assignment.rebol

  :value
//^ keyword.operator.assignment.rebol
// ^^^^^ entity.name.word.get.rebol

  word's:
  >>:

; true, false and none are not colorized as set-words
; to warn that it's not recommended
true: false: none:

;----------------------------------------------------------------
;-- lit-word!                                                    

  'value
//^ keyword.operator.quote.rebol
// ^^^^^ entity.name.lit.rebol
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
//^ keyword.operator.refinement.rebol
// ^^^^^^^^^^ entity.name.word.refinement.rebol

  /2nd /<< />>

  path/foo/3

;----------------------------------------------------------------
;-- datatype!                                                    

  integer!
//^^^^^^^^ storage.type.rebol
//       ^ storage.type.rebol storage.type.punctuation.rebol

;----------------------------------------------------------------
;-- function!                                                    

 
 foo: function [
    "Some description"
    argument [any-value!] "description"
    /refinement
     value [string!] "description" ;comment
 ][
    ;function body
    if refinement [return value]
    argument
 ]