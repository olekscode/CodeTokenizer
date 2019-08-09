Class {
	#name : #PharoCodeTokenizer,
	#superclass : #Object,
	#category : #CodeTokenizer
}

{ #category : #parsing }
PharoCodeTokenizer >> tokenize: aMethod [

	| visitor nameTokenizer |
	visitor := PharoTokenizingVisitor new.
	aMethod ast acceptVisitor: visitor.
	
	"^ visitor tokens."
	
	nameTokenizer := IdentifierNameTokenizer new.
	
	^ visitor tokens flatCollect: [ :token |
		(token matchesRegex: '(\w|\:)+')
			ifTrue: (nameTokenizer tokenize: token)
			ifFalse: { token } ].
]
