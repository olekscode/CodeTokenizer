Class {
	#name : #SourceCodeTokenizer,
	#superclass : #Object,
	#category : #CodeTokenizer
}

{ #category : #parsing }
SourceCodeTokenizer >> tokenize: aMethod [

	| visitor nameTokenizer |
	visitor := TokenizingVisitor new.
	aMethod ast acceptVisitor: visitor.
	
	"^ visitor tokens."
	
	nameTokenizer := IdentifierNameTokenizer new.
	
	^ visitor tokens flatCollect: [ :token |
		(token matchesRegex: '(\w|\:)+')
			ifTrue: (nameTokenizer tokenize: token)
			ifFalse: { token } ].
]
