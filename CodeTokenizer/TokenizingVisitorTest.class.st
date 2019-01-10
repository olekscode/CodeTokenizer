Class {
	#name : #TokenizingVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'anInstanceVariable'
	],
	#category : #CodeTokenizer
}

{ #category : #examples }
TokenizingVisitorTest >> exampleArray [
	#(1 'hello' true nil)
]

{ #category : #examples }
TokenizingVisitorTest >> exampleArrayCurly [
	{1 . 'hello' . true . nil}
]

{ #category : #examples }
TokenizingVisitorTest >> exampleAssignment [
	| x |
	x := 2
]

{ #category : #examples }
TokenizingVisitorTest >> exampleBlock [
	[ 1 + 2 ]
]

{ #category : #examples }
TokenizingVisitorTest >> exampleBlockWithArgs [
	[ :x | x + 2 ]
]

{ #category : #examples }
TokenizingVisitorTest >> exampleBlockWithArgsAndTemp [
	[ :x :y | 
	| a b |
	a := x + 1.
	b := y - 1.
	a * b ]
]

{ #category : #examples }
TokenizingVisitorTest >> exampleCharacter [
	$,
]

{ #category : #examples }
TokenizingVisitorTest >> exampleClass [
	Array
]

{ #category : #examples }
TokenizingVisitorTest >> exampleCollect [
	self collect: [ :x | x ]
]

{ #category : #examples }
TokenizingVisitorTest >> exampleEmptyArray [
	#()
]

{ #category : #examples }
TokenizingVisitorTest >> exampleEmptyArrayCurly [
	{}
]

{ #category : #examples }
TokenizingVisitorTest >> exampleInstanceVariable [
	anInstanceVariable := 1
]

{ #category : #examples }
TokenizingVisitorTest >> exampleMessageNoArgs [
	2 asInteger
]

{ #category : #examples }
TokenizingVisitorTest >> exampleMessageOneArg [
	Array new: 2
]

{ #category : #examples }
TokenizingVisitorTest >> exampleMessageOperator [
	1 + 2
]

{ #category : #examples }
TokenizingVisitorTest >> exampleMessageThreeArgs [
	Array with: 3 with: 4 with: 5
]

{ #category : #examples }
TokenizingVisitorTest >> exampleMessageTwoArgs [
	Array with: 3 with: 4
]

{ #category : #examples }
TokenizingVisitorTest >> exampleNestedArrays [
	#((1 2 3) 'hello' (true false))
]

{ #category : #examples }
TokenizingVisitorTest >> exampleNestedArraysCurly [
	{ { 1 . 'hello' } . true . { false } }
]

{ #category : #examples }
TokenizingVisitorTest >> exampleNumber [
	5
]

{ #category : #examples }
TokenizingVisitorTest >> exampleParentheses [
	2 * (3 + 4)
]

{ #category : #examples }
TokenizingVisitorTest >> exampleReturn [
	^ 1
]

{ #category : #examples }
TokenizingVisitorTest >> exampleSelf [
	self
]

{ #category : #examples }
TokenizingVisitorTest >> exampleSequence [
	5.
	#(1 2 true)
]

{ #category : #examples }
TokenizingVisitorTest >> exampleSuper [
	super
]

{ #category : #examples }
TokenizingVisitorTest >> exampleSymbol [
	#hello
]

{ #category : #examples }
TokenizingVisitorTest >> exampleTemporary [
	| x y z |
	
]

{ #category : #examples }
TokenizingVisitorTest >> exampleTemporaryUsed [
	| x y |
	x := 1.
	y := 2.
	x + y
]

{ #category : #examples }
TokenizingVisitorTest >> exampleWithArgs: anArg [
	5
]

{ #category : #examples }
TokenizingVisitorTest >> testArray [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleArray) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleArray'.
	self
		assert: visitor tokens
		equals: #('#(' '<num>' '<str>' 'true' 'nil' ')' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testArrayCurly [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleArrayCurly) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleArrayCurly'.
	self
		assert: visitor tokens
		equals: #('{' '<num>' '.' '<str>' '.' 'true' '.' 'nil' '}' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testAssignment [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleAssignment) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleAssignment'.
	self
		assert: visitor tokens
		equals: #('|' 'x' '|' 'x' ':=' '<num>' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testBlock [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleBlock) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('[' '(' '<num>' '+' '<num>' ')' '.' ']' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testBlockWithArgs [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleBlockWithArgs) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('[' ':x' '|' '(' 'x' '+' '<num>' ')' '.' ']' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testBlockWithArgsAndTemp [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleBlockWithArgsAndTemp) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals:
			#('[' ':x' ':y' '|' '|' 'a' 'b' '|' 'a' ':=' '(' 'x' '+' '<num>' ')' '.' 'b' ':=' '(' 'y' '-' '<num>' ')' '.' '(' 'a' '*' 'b' ')' '.' ']' '.')
				asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testCharacter [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleCharacter) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleCharacter'.
	self
		assert: visitor tokens
		equals: #('<str>' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testClass [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleClass) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('Array' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testCollect [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleCollect) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('(' 'self' 'collect:' '[' ':x' '|' 'x' '.' ']' ')' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testEmptyArray [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleEmptyArray) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleEmptyArray'.
	self assert: visitor tokens equals: #('#(' ')' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testEmptyArrayCurly [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleEmptyArrayCurly) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleEmptyArrayCurly'.
	self assert: visitor tokens equals: #('{' '}' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testInstanceVariable [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleInstanceVariable) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('anInstanceVariable' ':=' '<num>' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testMessageNoArgs [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleMessageNoArgs) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('<num>' 'asInteger' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testMessageOneArg [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleMessageOneArg) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('(' 'Array' 'new:' '<num>' ')' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testMessageOperator [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleMessageOperator) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('(' '<num>' '+' '<num>' ')' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testMessageThreeArgs [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleMessageThreeArgs) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('(' 'Array' 'with:' '<num>' 'with:' '<num>' 'with:' '<num>' ')' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testMessageTwoArgs [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleMessageTwoArgs) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('(' 'Array' 'with:' '<num>' 'with:' '<num>' ')' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testNestedArrays [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleNestedArrays) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals:
			#('#(' '#(' '<num>' '<num>' '<num>' ')' '<str>' '#(' 'true' 'false' ')' ')' '.')
				asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testNestedArraysCurly [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleNestedArraysCurly) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals:
			#('{' '{' '<num>' '.' '<str>' '}' '.' 'true' '.' '{' 'false' '}' '}' '.')
				asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testNumber [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleNumber) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('<num>' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testParentheses [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleParentheses) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleParentheses'.
	self
		assert: visitor tokens
		equals: #('(' '<num>' '*' '(' '<num>' '+' '<num>' ')' ')' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testReturn [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleReturn) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('^' '<num>' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testSelf [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleSelf) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('self' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testSequence [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleSequence) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals: #('<num>' '.' '#(' '<num>' '<num>' 'true' ')' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testSuper [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleSuper) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('super' '.') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testSymbol [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleSymbol) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleSymbol'.
	self
		assert: visitor tokens
		equals: #('<str>' '.') asOrderedCollection.
	self assert: visitor arguments equals: #() asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testTemporary [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleTemporary) ast acceptVisitor: visitor.
	self assert: visitor tokens equals: #('|' 'x' 'y' 'z' '|') asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testTemporaryUsed [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleTemporaryUsed) ast acceptVisitor: visitor.
	self
		assert: visitor tokens
		equals:
			#('|' 'x' 'y' '|' 'x' ':=' '<num>' '.' 'y' ':=' '<num>' '.' '(' 'x' '+' 'y' ')' '.')
				asOrderedCollection
]

{ #category : #examples }
TokenizingVisitorTest >> testWithArgs [
	| visitor |
	visitor := TokenizingVisitor new.
	(self class >> #exampleWithArgs:) ast acceptVisitor: visitor.
	self assert: visitor name equals: 'exampleWithArgs:'.
	self assert: visitor tokens equals: #('<num>' '.') asOrderedCollection.
	self assert: visitor arguments equals: #('anArg') asOrderedCollection
]
