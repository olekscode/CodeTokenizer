Class {
	#name : #IdentifierNameTokenizer,
	#superclass : #Object,
	#category : #CodeTokenizer
}

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> encodeNumbers: anArrayOfTokens [

	^ anArrayOfTokens collect: [ :token |
		(token matchesRegex: '\d+')
			ifTrue: '<num>'
			ifFalse: token ].
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateAbbreviations: anArrayOfTokens [
	^ anArrayOfTokens flatCollect: [ :token |
		self separateAbbreviationsFromString: token ]
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateAbbreviationsFromString: aString [
   | str regex suffix tokens |

	str := aString.

	regex := '[A-Z][A-Z]+\>' asRegex.
   suffix := regex matchesIn: str collect: #value.
	suffix := suffix isEmpty ifTrue: [''] ifFalse: [suffix anyOne].
	str := str copyFrom: 1 to: (str size - suffix size).

	regex := '[A-Z][A-Z]+' asRegex.
	str := regex copy: str translatingMatchesUsing: [ :s | '_', (s copyWithoutIndex: s size), '_', s last asString. ].

	regex := '_|[^_]+' asRegex.
	tokens := regex matchesIn: str collect: #value.

	tokens := tokens copyWithout: '_'.
	suffix isEmpty ifFalse: [ tokens := tokens, { suffix } ].
	^ tokens
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateCamelCase: anArrayOfTokens [
	^ anArrayOfTokens flatCollect: [ :token |
		token detect: #isLowercase
			ifFound: [ self separateCamelCaseFromString: token ]
			ifNone: [ { token } ] ]
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateCamelCaseFromString: aString [
	| regex |
	
	regex := '[A-Z][a-z]+|\<[a-z]+' asRegex.
	^ regex matchesIn: aString collect: #value.
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateDots: anArrayOfTokens [
	^ anArrayOfTokens flatCollect: [ :token |
		self separateDotsFromString: token ]
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateDotsFromString: aString [
   | regex |
	regex := '[^:]+|\:' asRegex.
   ^ regex matchesIn: aString collect: #value.
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateNonAlphanum: anArrayOfTokens [
	^ anArrayOfTokens flatCollect: [ :token |
		self separateNonAlphanumFromString: token ]
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateNonAlphanumFromString: aString [
   | regex |
	regex := '[A-Za-z0-9]+|[\W_]+' asRegex.
   ^ regex matchesIn: aString collect: #value.
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateNumbers: anArrayOfTokens [
	^ anArrayOfTokens flatCollect: [ :token |
		self separateNumbersFromString: token ]
]

{ #category : #'as yet unclassified' }
IdentifierNameTokenizer >> separateNumbersFromString: aString [
	| regex |
	
	regex := '\d+|\D+' asRegex.
	^ regex matchesIn: aString collect: #value.
]

{ #category : #parsing }
IdentifierNameTokenizer >> tokenize: aString [
	"Splits identifier name such as RTObject123 or example3drawCircle into an array of lowercase tokens: #(rt object <num>) and #(example <num> draw circle)"
	
	| tokens |
	tokens := OrderedCollection with: aString.
	tokens := self separateDots: tokens.
	tokens := self separateNonAlphanum: tokens.
	tokens := self separateNumbers: tokens.
	tokens := self separateAbbreviations: tokens.
	tokens := self separateCamelCase: tokens.
	tokens := self encodeNumbers: tokens.
	tokens := tokens collect: #asLowercase.
	^ tokens

	
]
