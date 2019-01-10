Class {
	#name : #IdentifierNameTokenizerTest,
	#superclass : #TestCase,
	#instVars : [
		'nameTokenizer'
	],
	#category : #CodeTokenizer
}

{ #category : #running }
IdentifierNameTokenizerTest >> setUp [ 
	
	nameTokenizer := IdentifierNameTokenizer new.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testClassNameOneWord [

	| name expectedTokens actualTokens |
	
	name := 'Example'.
	expectedTokens := #(example) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testClassNameTwoWords [

	| name expectedTokens actualTokens |
	
	name := 'ExampleDraw'.
	expectedTokens := #(example draw) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testClassNameTwoWordsPrefix [

	| name expectedTokens actualTokens |
	
	name := 'RTExampleDraw'.
	expectedTokens := #(rt example draw) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testClassNameTwoWordsPrefixDigits [

	| name expectedTokens actualTokens |
	
	name := 'RTExampleDraw123'.
	expectedTokens := #(rt example draw '<num>') asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testClassNameTwoWordsPrefixDigitsLowercase [

	| name expectedTokens actualTokens |
	
	name := 'RTExampleDraw123hello'.
	expectedTokens := #(rt example draw '<num>' hello) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testEncodeNumbers [

	| tokens expectedTokens actualTokens |
	
	tokens := #(helloWorld '12' hello '12' world '12' helloWorld '12' '1' '12' hello '34' World '567') asOrderedCollection.
	expectedTokens := #(helloWorld '<num>' hello '<num>' world '<num>' helloWorld '<num>' '<num>' '<num>' hello '<num>' World '<num>') asOrderedCollection.
	actualTokens := nameTokenizer encodeNumbers: tokens.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameOneWordNoArgs [

	| name expectedTokens actualTokens |
	
	name := 'example'.
	expectedTokens := #(example) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameOneWordOneArg [

	| name expectedTokens actualTokens |
	
	name := 'example:'.
	expectedTokens := #(example :) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameOneWordOneDigitNoArgs [

	| name expectedTokens actualTokens |
	
	name := 'example1'.
	expectedTokens := #(example '<num>') asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameOneWordOneDigitOneArg [

	| name expectedTokens actualTokens |
	
	name := 'example1:'.
	expectedTokens := #(example '<num>' :) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameOneWordTwoDigitsNoArgs [

	| name expectedTokens actualTokens |
	
	name := 'example12'.
	expectedTokens := #(example '<num>') asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameOneWordTwoDigitsOneArg [

	| name expectedTokens actualTokens |
	
	name := 'example12:'.
	expectedTokens := #(example '<num>' :) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameTwoWordsNoArgs [

	| name expectedTokens actualTokens |
	
	name := 'exampleDraw'.
	expectedTokens := #(example draw) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameTwoWordsOneArg [

	| name expectedTokens actualTokens |
	
	name := 'exampleDraw:'.
	expectedTokens := #(example draw :) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameTwoWordsTwoArgs [

	| name expectedTokens actualTokens |
	
	name := 'example:draw:'.
	expectedTokens := #(example : draw :) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testMethodNameTwoWordsTwoDigitsLowercaseNoArgs [

	| name expectedTokens actualTokens |
	
	name := 'exampleDraw123hello'.
	expectedTokens := #(example draw '<num>' hello) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testOperator [

	| name expectedTokens actualTokens |
	
	name := '+'.
	expectedTokens := #(+) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testOperatorInTheMiddle [

	| name expectedTokens actualTokens |
	
	name := 'Hello>>world'.
	expectedTokens := #(hello >> world) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testOperatorTwoSymbols [

	| name expectedTokens actualTokens |
	
	name := '>>'.
	expectedTokens := #(>>) asOrderedCollection.
	actualTokens := nameTokenizer tokenize: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateAbbreviations [

	| tokens expectedTokens actualTokens |
	
	tokens := #(HHHelloWorldFF RTHello HelloCSV HelloHTMLWorld) asOrderedCollection.
	expectedTokens := #(HH HelloWorld FF RT Hello Hello CSV Hello HTML World) asOrderedCollection.
	actualTokens := nameTokenizer separateAbbreviations: tokens.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateAbbreviationsFromString [

	| name expectedTokens actualTokens |
	
	name := 'HHHelloWorldFF'.
	expectedTokens := #(HH HelloWorld FF) asOrderedCollection.
	actualTokens := nameTokenizer separateAbbreviationsFromString: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateCamelCase [

	| tokens expectedTokens actualTokens |
	
	tokens := #(helloWorld HelloWorld hello) asOrderedCollection.
	expectedTokens := #(hello World Hello World hello) asOrderedCollection.
	actualTokens := nameTokenizer separateCamelCase: tokens.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateCamelCaseFromString [

	| name expectedTokens actualTokens |
	
	name := 'helloWorld'.
	expectedTokens := #(hello World) asOrderedCollection.
	actualTokens := nameTokenizer separateCamelCaseFromString: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateDots [

	| tokens expectedTokens actualTokens |
	
	tokens := #(helloWorld: hello:world: hello:: : :x) asOrderedCollection.
	expectedTokens := #(helloWorld : hello : world : hello : : : : x) asOrderedCollection.
	actualTokens := nameTokenizer separateDots: tokens.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateDotsFromString [

	| name expectedTokens actualTokens |
	
	name := 'hello:world:'.
	expectedTokens := #(hello : world :) asOrderedCollection.
	actualTokens := nameTokenizer separateDotsFromString: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateNonAlphanum [

	| tokens expectedTokens actualTokens |
	
	tokens := #(hello+ hello++ he++llo ++hello ++hel+lo++) asOrderedCollection.
	expectedTokens := #(hello + hello ++ he ++ llo ++ hello ++ hel + lo ++) asOrderedCollection.
	actualTokens := nameTokenizer separateNonAlphanum: tokens.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateNonAlphanumFromString [

	| name expectedTokens actualTokens |
	
	name := '_RTExample>>methodName#++'.
	expectedTokens := #(_ RTExample >> methodName '#++') asOrderedCollection.
	actualTokens := nameTokenizer separateNonAlphanumFromString: name.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateNumbers [

	| tokens expectedTokens actualTokens |
	
	tokens := #(helloWorld12 hello12world '12helloWorld' '12' '1' '12hello34World567') asOrderedCollection.
	expectedTokens := #(helloWorld '12' hello '12' world '12' helloWorld '12' '1' '12' hello '34' World '567') asOrderedCollection.
	actualTokens := nameTokenizer separateNumbers: tokens.
	
	self assert: actualTokens equals: expectedTokens.
]

{ #category : #tests }
IdentifierNameTokenizerTest >> testSeparateNumbersFromString [

	| name expectedTokens actualTokens |
	
	name := 'hello12world345'.
	expectedTokens := #(hello '12' world '345') asOrderedCollection.
	actualTokens := nameTokenizer separateNumbersFromString: name.
	
	self assert: actualTokens equals: expectedTokens.
]
