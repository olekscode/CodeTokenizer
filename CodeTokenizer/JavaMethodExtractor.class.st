Class {
	#name : #JavaMethodExtractor,
	#superclass : #Object,
	#category : #CodeTokenizer
}

{ #category : #'as yet unclassified' }
JavaMethodExtractor class >> extractFromFile: aFileReference [
	| source |
	source := aFileReference contents.
	
	[ ^ self getMethods: source ]
	on: SmaCCParserError do: [ ^ OrderedCollection new ].
]

{ #category : #'as yet unclassified' }
JavaMethodExtractor class >> getMethods: sourceCode [

	| fileNode declarationNodes flatDeclarations |
	
	fileNode := JavaParser parse: sourceCode.
	
	declarationNodes := fileNode typeDeclarations flatCollect: [ :decl | (decl class = JavaEmptyDeclarationNode) ifTrue: [ OrderedCollection new ] ifFalse: [ decl declarations ] ].

	flatDeclarations := declarationNodes flatCollect: [ :node |
		node class = JavaClassDeclarationNode
			ifTrue: [ node declarations ]
			ifFalse: [ { node } ] ].
	
	^ flatDeclarations select: [ :node |
		node class = JavaMethodDeclarationNode ].
]

{ #category : #'as yet unclassified' }
JavaMethodExtractor class >> getNames: anArrayOfMethods [
	^ anArrayOfMethods collect: [ :method | method declarator name value ]
]
