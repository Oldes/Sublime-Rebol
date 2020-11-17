REBOL [
	title:  "REBOL 3 image codecs extensions"
	name:   'codec-image-ext
	author: "Oldes"
	version: 0.1.0
	date:    10-Nov-2020
	history: [
		0.1.0 10-Nov-2020 "Oldes" {Extend native PNG codec with `size?` function}
	]
]

true false on off

10:00am

;-- pair!
2x2
0x0.5
0.5x0
2.2x3.4
2e2x1

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
#
#@     ; this is invalid issue, it would throw an error

;-- char!
#"a"
#"cxxx"      ;@@ should be invalid result!
#"^xxx"
#"^()"
#"^@"
#"^L"
#"^(0)"
#"^(del)"
#"aa"


;-- decimal
1.2

;-- pair!
10x10
1.2x3.2

;-- email!
foo@
foo@gmail.com

;-- ref!
@name
@       ; empty ref!

;-- tag!
<tag>
<tag id='a' foo="b">

;-- url!
http://foo:80/
foo:somehing

;-- file!
%foo/boo
%/c/Windows/
%"with spaces"
%"aa^"bb"

;-- string!
"aa^"bb"
"aa;bb"
"aa{bb"
{aa^{aa}
{ab^(01)}
{^;a}
{^(;)} ; this one should not be valid
{{}}
{
multiline
string
}

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

"^[[0;m"


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



1foo:

[true{ss}true,true sss:{}]
[all]
all{}
{}all



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
			to pair! binary/read bin [UI32 UI32]
		]
	]
]

%foo/aaa

comment [
	this should be commented out
	1 + 3
]

;@@ issue in current version:
;-- missing support for set path with dynamic parts
aa/a/b: ;<- this one is ok
aa/(n): ;<- this one is not correct

;-- ++ should be recognized as one word:
++ ;<- now it is not
-- ;<- this one is fine

