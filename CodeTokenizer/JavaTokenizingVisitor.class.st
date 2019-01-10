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
JavaTokenizingVisitor >> visitBinaryExpression: aBinaryExpression [
	aBinaryExpression leftExpression acceptVisitor: self.
	tokens add: aBinaryExpression op value.
	aBinaryExpression rightExpression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitBlock: aBlockNode [
	tokens add: '{'.
	
	aBlockNode statements do: [ :each |
		each acceptVisitor: self ].
	
	tokens add: '}'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitBooleanLiteral: aBooleanLiteral [
	tokens add: aBooleanLiteral token value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitCastExpression: aCastExpression [
	tokens add: '('.
	aCastExpression type acceptVisitor: self.
	tokens add: ')'.
	aCastExpression expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitClassType: aClassType [
	aClassType name acceptVisitor: self.
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
	tokens add: ';'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitFieldAccess: aFieldAccess [
	aFieldAccess receiver acceptVisitor: self.
	tokens add: '.'; add: aFieldAccess name value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitFloatLiteral: aFloatLiteral [
	tokens add: '<num>'
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitForStatement: aForStatement [
	tokens add: 'for'; add: '('.
	aForStatement initial acceptVisitor: self.
	tokens add: ';'.
	aForStatement test acceptVisitor: self.
	tokens add: ';'.
	aForStatement _update acceptVisitor: self.
	tokens add: ')'.
	aForStatement statement acceptVisitor: self.
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
JavaTokenizingVisitor >> visitIfStatement: anIfStatement [
	tokens add: 'if'; add: '('.
	anIfStatement expression acceptVisitor: self.
	tokens add: ')'.
	anIfStatement trueStatement acceptVisitor: self.
	
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitInitializedVariableDeclaration: anInitializedVariableDeclaration [
	anInitializedVariableDeclaration variable acceptVisitor: self.
	tokens add: '='.
	anInitializedVariableDeclaration initializer acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitIntegerLiteral: anIntegerLiteral [
	tokens add: '<num>'
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitLocalVariableDeclaration: aLocalVariableDeclaration [
	aLocalVariableDeclaration type acceptVisitor: self.
	
	1 to: aLocalVariableDeclaration variableDeclarations size - 1 do: [ :i |
		(aLocalVariableDeclaration variableDeclarations at: i) acceptVisitor: self.
		tokens add: ',' ]. 
	
	aLocalVariableDeclaration variableDeclarations last acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitLocalVariableDeclarationStatement: aLocalVariableDeclarationStatement [
	aLocalVariableDeclarationStatement declaration acceptVisitor: self.
	tokens add: ';'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitMethodInvocation: aMethodInvocation [
	aMethodInvocation receiver ifNotNil: [ 
		aMethodInvocation receiver acceptVisitor: self.
		tokens add: '.' ].
	
	tokens
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
JavaTokenizingVisitor >> visitNew: aNew [
	tokens add: 'new'.
	aNew type acceptVisitor: self.
	tokens add: '('.
	
	aNew expressions isNotEmpty ifTrue: [ 
		1 to: aNew expressions size - 1 do: [ :i |
			(aNew expressions at: i) acceptVisitor: self.
			tokens add: ',' ].
		
		aNew expressions last acceptVisitor: self ].
	
	tokens add: ')'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitPostDecrementExpression: aPostDecrementExpression [
	aPostDecrementExpression expression acceptVisitor: self.
	tokens add: '--'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitPostIncrementExpression: aPostIncrementExpression [
	aPostIncrementExpression expression acceptVisitor: self.
	tokens add: '++'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitPreDecrementExpression: aPreDecrementExpression [
	tokens add: '--'.
	aPreDecrementExpression expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitPreIncrementExpression: aPreIncrementExpression [
	tokens add: '++'.
	aPreIncrementExpression expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitPrimitiveType: aPrimitiveType [
	tokens add: aPrimitiveType token value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitQualifiedName: aQualifiedName [
	tokens add: aQualifiedName nspace name value; add: '.'; add: aQualifiedName name value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitReturnStatement: aReturnStatement [
	tokens add: 'return'.
	aReturnStatement expression ifNotNil: [
		aReturnStatement expression acceptVisitor: self ].
	tokens add: ';'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitStringLiteral: aStringLiteral [
	tokens add: '<str>'
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitSwitchBlock: aSwitchBlock [
	tokens add: '{'.
	
	aSwitchBlock statementGroups do: [ :each |
		each acceptVisitor: self ].
	
	tokens add: '}'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitSwitchBlockStatementGroup: aSwitchBlockStatementGroup [
	aSwitchBlockStatementGroup labels do: [ :each |
		each acceptVisitor: self ].
	aSwitchBlockStatementGroup statements do: [ :each |
		each acceptVisitor: self ].
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

{ #category : #accessing }
JavaTokenizingVisitor >> visitThrowStatement: aThrowStatement [
	tokens add: 'throw'.
	aThrowStatement expression acceptVisitor: self.
	tokens add: ';'.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitTypeName: aTypeName [
	tokens add: aTypeName name value.
	
	aTypeName arguments ifNotEmpty: [ 
		tokens add: '<'.
		
		1 to: aTypeName arguments size - 1 do: [ :i |
			(aTypeName arguments at: i) acceptVisitor: self.
			tokens add: ',' ].
		
		aTypeName arguments last acceptVisitor: self.
		tokens add: '>' ].
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitUnaryAddition: anUnaryAddition [
	tokens add: '+'.
	anUnaryAddition expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitUnaryBitInvert: anUnaryBitInvert [
	tokens add: '~'.
	anUnaryBitInvert expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitUnaryNot: anUnaryNot [
	tokens add: '!'.
	anUnaryNot expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitUnarySubtraction: anUnarySubtraction [
	tokens add: '-'.
	anUnarySubtraction expression acceptVisitor: self.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitVariableName: aVariableName [
	tokens add: aVariableName name value.
]

{ #category : #accessing }
JavaTokenizingVisitor >> visitWhileStatement: aWhileStatement [
	tokens add: 'while'; add: '('.
	aWhileStatement expression acceptVisitor: self.
	tokens add: ')'.
	aWhileStatement statement acceptVisitor: self.
]
