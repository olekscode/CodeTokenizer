Class {
	#name : #JavaTokenizingVisitor,
	#superclass : #JavaProgramNodeVisitor,
	#instVars : [
		'tokens'
	],
	#category : #CodeTokenizer
}

{ #category : #initialization }
JavaTokenizingVisitor >> initialize [
	tokens := OrderedCollection new.
]

{ #category : #accessing }
JavaTokenizingVisitor >> tokens [ 
	^ tokens
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitArrayAccess: anArrayAccess [
	Error signal: anArrayAccess asString.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitAssignment: anAssignment [
	Error signal: anAssignment asString.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitBlock: aBlockNode [
	tokens add: '{'.
	
	aBlockNode statements do: [ :each |
		each acceptVisitor: self.
		tokens add: ';' ].
	
	tokens add: '}'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitBooleanLiteral: aBooleanLiteral [
	tokens add: aBooleanLiteral token value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitDefaultLabel: aDefaultLabel [
	tokens
		add: aDefaultLabel defaultToken value;
		add: aDefaultLabel colon value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitExpressionStatement: anExpressionStatement [
	anExpressionStatement expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitIfElseStatement: anIfElseStatement [
	tokens add: 'if'; add: '('.
	anIfElseStatement expression acceptVisitor: self.
	tokens add: ')'.
	anIfElseStatement trueStatement acceptVisitor: self.
	tokens add: 'else'.
	anIfElseStatement falseStatement acceptVisitor: self.
	
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitMethodInvocation: aMethodInvocation [
	aMethodInvocation receiver acceptVisitor: self.
	tokens
		add: '.';
		add: aMethodInvocation name value;
		add: '('.
		
	1 to: aMethodInvocation expressions size - 1 do: [ :i |
		(aMethodInvocation expressions at: i) acceptVisitor: self.
		tokens add: ',' ].
	
	aMethodInvocation expressions isNotEmpty
		ifTrue: [aMethodInvocation expressions last acceptVisitor: self ].
		
	tokens add: ')'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitName: aName [
	tokens add: aName name value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitReturnStatement: aReturnStatement [
	tokens add: 'return'.
	aReturnStatement expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitSwitchBlock: aSwitchBlock [
	tokens add: '{'.
	
	aSwitchBlock statementGroups do: [ :each |
		each acceptVisitor: self.
		tokens add: ';' ].
	
	tokens add: '}'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitSwitchBlockStatementGroup: aSwitchBlockStatementGroup [
	aSwitchBlockStatementGroup labels do: [ :each |
		each acceptVisitor: self ].
	aSwitchBlockStatementGroup statements do: [ :each |
		each acceptVisitor: self.
		tokens add: ';' ].
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitSwitchLabel: aSwitchLabel [
	tokens add: aSwitchLabel caseToken value.
	aSwitchLabel constant acceptVisitor: self.
	tokens add: aSwitchLabel colon value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitSwitchStatement: aSwitchStatement [
	tokens add: 'switch'; add: '('.
	aSwitchStatement expression acceptVisitor: self.
	tokens add: ')'.
	aSwitchStatement block acceptVisitor: self.
]
