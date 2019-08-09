Class {
	#name : #JavaCodeTokenizer,
	#superclass : #Object,
	#category : #CodeTokenizer
}

{ #category : #parsing }
JavaCodeTokenizer >> tokenize: aMethod [
	| visitor tokens |

	visitor := JavaTokenizingVisitor new.
	aMethod acceptVisitor: visitor.
	tokens := visitor tokens.
	^ tokens
]
