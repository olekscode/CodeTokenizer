Class {
	#name : #JavaMethodExtractor,
	#superclass : #Object,
	#category : #CodeTokenizer
}

{ #category : #'as yet unclassified' }
JavaMethodExtractor class >> example [
	<example>
	| project baseDir filesDir dfDir files file parsedFiles tokenizer nameTokenizer methods names sourceTokenized className methodData stream neoCSVWriter |
	project := 'xerces2-j'.

	baseDir := '/Users/oleks/Desktop/JavaProjects' asFileReference.
	filesDir := baseDir / 'files' / project.
	dfDir := baseDir / 'df' / project.
	files := filesDir children.

	parsedFiles := dfDir children collect: #base.
	files := files reject: [ :f | parsedFiles includes: f base ].

	tokenizer := JavaCodeTokenizer new.
	nameTokenizer := IdentifierNameTokenizer new.

	(1 to: files size) do: [ :k |
		file := files at: k.
		methods := JavaMethodExtractor extractFromFile: file.
		names := JavaMethodExtractor getNames: methods.
		names := names collect: [ :aName | ' ' join: (nameTokenizer tokenize: aName) ].

		sourceTokenized := methods collect: [ :method |
			| tokens |
			tokens := tokenizer tokenize: method.
			tokens := tokens flatCollect: [ :token | nameTokenizer tokenize: token ].
			' ' join: tokens ].

		className := file base.

		methodData := (1 to: names size) collect: [ :i |
			{ project . className . names at: i . sourceTokenized at: i } ].

		stream := (File named: (dfDir / (file base, '.csv')) fullName) writeStream.

		neoCSVWriter := NeoCSVWriter on: stream.
		neoCSVWriter separator: Character tab.

		neoCSVWriter fieldWriter: #raw.
		neoCSVWriter nextPut: #(project class method source).
		neoCSVWriter nextPutAll: methodData
	] displayingProgress:  [ :each | 'Parsing file ' , each asString ].
]

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
