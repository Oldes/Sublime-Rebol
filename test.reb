REBOL [
	title:   "Code pieces"
	purpose: "Just some code pieces to test Sublime syntax"
	note: [
		https://www.sublimetext.com/docs/scope_naming.html
	]
]

;-- const
;@@ todo:
true false none on off
none! length?

comment []
comment [[3463#456a]]
comment #[true]

c1: comment{aa bb}
c2: comment{aa{}bb}
c3: comment{aa^}bb}
c4: comment quote (3 4 #())
c5: comment quote (3 (4)[])
	[comment 1]
	(comment?)
	(comment {})
comment #{}
comment 1

value

my-ctx: context [
	f1: does []
	o1: construct [a: 1]
	o2: construct/with [b: now] o1
]

myfunc: does [
	foo: 1
	noo: 2
]
my-func: does []
my-func: has []

my-module: module [name: 'colors][]

;-- date!

1-Jan-2000
1-jan-2000
1-jAN-2000
1-janu-200
1-janua-2000
1-januar-2000

;-- time!
 1:00
 1:00
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

;-- decimal
1.2
1.#inf
+1.#inf
-1.#INF
1.#nan
+1.#NaN
0.#inf ; invalid decimal

;-- pair!
2x2
0x0.5
0.5x0
2.2x3.4
2e2x1
1.#infx1.#inf

0x ;not valid pair!

;-- hex number
FFh
0Ah
01AAh
AAAAAAh
AAAAAAAAh
;these should not be recognized as valid numbers:
0h Ah AAAAAAAAAAh aah

;-- money!
$1111
EUR$222

"a;a"


;-- issue!
#foo
#a##
#123
#      ; there cannot be empty issue
#@     ; this is also invalid issue (in Red so far)
#()    ; this is empty map!

;-- char!
#"a"
#"cxxx"      ;@@ should be invalid result!
#"^xxx"      ;@@ also invalid char!
#"^()"
#"^@"
#"^L"
#"^(0)"
#"^(del)"

;-- datatype!
 integer!
[integer! string! any-word!]
[]integer!
integer![]
to integer!

;-- email!
foo@
foo@gmail.com

;-- ref!
@name
@       ; empty ref! is valid

;-- tag!
<tag></tag><tag/>
<tag id='a' foo="b">
<---> ;<-- this is word! in Red, not a tag!

;-- url!
http://user:pass@host:80/path?query#tag
scheme:/
scheme://
scheme:host
mailto:user@foo.com

; this is not url:
set:
path/:val
path/:val:

--
~~~end-file~~~
===end-group===
--test--
--assert

;-- file!
%foo/boo
%/c/Windows/
%"with spaces"
%"aa^"bb"
%aa%20bb   ;@@TODO: same like %"aa bb"

;-- string!
"aa^"bb"
"aa;bb"
"aa{bb"
{aa^{aa}
{ab^(01)}
{^;a}
{^(;)} ; this is not valid string
{{}}
{^§}   ; invalid escape inside string
{
multiline
string
&amp;
}
"^() ^(0) ^(00) ^(000) ^(0000)"
"^(00000)" ; invalid, because too many zeros

"^[[1;32mHello^[[0;m" ;@@ TODO: ansi escape sequences
"^[c" 

;-- binary!
#{}
#{f00d}
64#{89504E47}
64#{89504E470 ;aaa
 D0A1A0A}
16#{89504E47
 0D0A1A0A}
#{
 89504E47 ;something
 0D0A1A0A}

2#{11 
 00 00 11
}
return halt

;-- Construction syntax
#[true]
#[false]
#[none]
#[unset!]
#[logic! 0]
#[string! "abc" 2]
#[f32![1 2 3 4]]
#[image! 2x2 #{FFFFFFFFFFFFFFFFFFFFFFFF}]
;with comments inside:
#[
	binary! ; type
	#{f00d} ; series
	2       ; index
]

;-- map!
#(  ; key/value container
	a: 1
	b: 2
	c: "foo"
)

;-- comments
comment "something"
comment {}
comment {
	{}
}
comment [ ]
comment [
	[]
]
comment
[
]

[comment]

/


fu: function ["aa"][
	return 1
]
true: ; does not colorize `true` to warn us, that it should not be done
none: ; --//--
:true
non:  ; this is ok
:non
:a/b/a

;-- docline comment
;@@ todo comment   

'aaa'

a/:a:


1foo:

[true{ss}true,true sss:{}]
[all]
all{}
{}all

prin now
print now
printf now

0e-0 0E-0 0.0e-0 0.0E-0 123.456e-789

if find codecs 'png [
	extend codecs/png 'size2? func ["Return PNG image size or none" bin [binary!]][
		if all [
			parse bin [
				64#{89504E470 D0A1A0A} ;- PNG magic number
				thru #{49484452}    ;- IHDR chunk
				bin: to end
			]
			8 <= length? bin
		][
			to pair! binary/read bin [UI32! UI32!]
		]
	]
]

%foo/aaa

comment [
	this should be commented out
	1 + 3
]

