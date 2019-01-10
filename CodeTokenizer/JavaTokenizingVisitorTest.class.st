Class {
	#name : #JavaTokenizingVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitor'
	],
	#category : #CodeTokenizer
}

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> createMethodNode: methodBody [

	| sourceCode |
	sourceCode := self wrapMethodInClass: methodBody.
	^ (self getMethods: sourceCode) anyOne.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> getMethods: sourceCode [

	| fileNode declarationNodes flatDeclarations |
	
	fileNode := JavaParser parse: sourceCode.
	
	declarationNodes := fileNode typeDeclarations flatCollect: #declarations.

	flatDeclarations := declarationNodes flatCollect: [ :node |
		node class = JavaClassDeclarationNode
			ifTrue: [ node declarations ]
			ifFalse: [ { node } ] ].
	
	^ flatDeclarations select: [ :node |
		node class = JavaMethodDeclarationNode ].
]

{ #category : #running }
JavaTokenizingVisitorTest >> setUp [ 
	visitor := JavaTokenizingVisitor new.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testAdd [
	| source tokens expectedTokens |
	
	source := 'return -1 + 2.5;'.
	expectedTokens := #({ return - '<num>' + '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testArray [
	| source tokens expectedTokens |
	
	source := '
		double grades[ ] = new double[4];
		double scores[ ] = {80,90};
		double grades[ ];
		grades[7] = 85; '.
	expectedTokens := #({ double grades '[' ']' = new double '[' '<num>' ']' ; double scores '[' ']' = { '<num>' , '<num>' } ; double grades '[' ']' ; grades '[' 7 ']' = '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testBigSwitch [
	| source tokens expectedTokens |
	
	source := 'switch (((CollectionType) receiver.type).kind)
                {
                    case LIST:
                        return new Lists.Marker(bindIndex, receiver);
                    case SET:
                        return new Sets.Marker(bindIndex, receiver);
                    case MAP:
                        return new Maps.Marker(bindIndex, receiver);
                    default:
                        throw new AssertionError();
                }'.
	expectedTokens := #({ switch '(' '(' ' (' CollectionType ')' receiver . type ')' . kind ')' { case LIST : return new Lists . Marker '(' bindIndex , receiver ')' ; case SET : return new Sets . Marker '(' bindIndex , receiver ')' ; case MAP : return new Maps . Marker '(' bindIndex , receiver ')' ; default : throw new AssertionError '(' ')' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testBlockComments [
	| source tokens expectedTokens |
	
	source := '/* Some comment
	Still that same comment */
	return 1;'.
	expectedTokens := #({ return '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testClassName [
	| source tokens expectedTokens |
	
	source := 'A a;'.
	expectedTokens := #({ A a ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testEmptyReturn [
	| source tokens expectedTokens |
	
	source := 'return;'.
	expectedTokens := #({ return ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testField [
	| source tokens expectedTokens |
	
	source := 'return a.b;'.
	expectedTokens := #({ return a . b ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testFloat [
	| source tokens expectedTokens |
	
	source := 'return 0.5;'.
	expectedTokens := #({ return '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testFor [
	| source tokens expectedTokens |
	
	source := 'for (int i = 0; i < 10; ++i) { return 0; }'.
	expectedTokens := #({ for '(' int i = '<num>' ; i < '<num>' ; ++ i ')' { return '<num>' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testIf [
	| source tokens expectedTokens |
	
	source := 'if (true) { return false; }'.
	expectedTokens := #({ if '(' 'true' ')' { return 'false' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testIfElse [
	| source tokens expectedTokens |
	
	source := 'if (true) { return false; } else { return true; }'.
	expectedTokens := #({ if '(' 'true' ')' { return 'false' ; } else { return 'true' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testInteger [
	| source tokens expectedTokens |
	
	source := 'return 1;'.
	expectedTokens := #({ return '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testLineComments [
	| source tokens expectedTokens |
	
	source := '// Some comment
	// Another comment
	return 1;'.
	expectedTokens := #({ return '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testLocalVariableDeclaration [
	| source tokens expectedTokens |
	
	source := 'int a = 2;'.
	expectedTokens := #({ int a = '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testLocalVariableListDeclaration [
	| source tokens expectedTokens |
	
	source := 'int a = 2, b = 3, c = 4;'.
	expectedTokens := #({ int a = '<num>' , b = '<num>' , c = '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testNegativeFloat [
	| source tokens expectedTokens |
	
	source := 'return -0.5;'.
	expectedTokens := #({ return - '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testNegativeInteger [
	| source tokens expectedTokens |
	
	source := 'return -1;'.
	expectedTokens := #({ return - '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testNew [
	| source tokens expectedTokens |
	
	source := 'A a = new A();'.
	expectedTokens := #({ A a = new A '(' ')' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testNewMultipleArgs [
	| source tokens expectedTokens |
	
	source := 'A a = new A(2, 3, true);'.
	expectedTokens := #({ A a = new A '(' '<num>' , '<num>' , 'true' ')' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testNewMultipleExpressions [
	| source tokens expectedTokens |
	
	source := 'A a = new A(1 + 2, 4 / 5 * 6);'.
	expectedTokens := #({ A a = new A '(' '<num>' + '<num>' , '<num>' / '<num>' * '<num>' ')' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testNewOneArg [
	| source tokens expectedTokens |
	
	source := 'A a = new A(2);'.
	expectedTokens := #({ A a = new A '(' '<num>' ')' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testPostDecrement [
	| source tokens expectedTokens |
	
	source := 'return 1--;'.
	expectedTokens := #({ return '<num>' -- ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testPostIncrement [
	| source tokens expectedTokens |
	
	source := 'return 1++;'.
	expectedTokens := #({ return '<num>' ++ ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testPreDecrement [
	| source tokens expectedTokens |
	
	source := 'return --1;'.
	expectedTokens := #({ return -- '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testPreIncrement [
	| source tokens expectedTokens |
	
	source := 'return ++1;'.
	expectedTokens := #({ return ++ '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testPrimitiveTypes [
	| source tokens expectedTokens |
	
	source := 'int a; float b; double c; boolean d; byte e; char f; long g; short h;'.
	expectedTokens := #({ int a ; float b ; double c ; boolean d ; byte e ; char f ; long g ; short h ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testString [
	| source tokens expectedTokens |
	
	source := 'return "Hello, world!";'.
	expectedTokens := #({ return '<str>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testSwitch [
	| source tokens expectedTokens |
	
	source := 'switch (a) { case A: return 1; case B: return 2; default: return 3; }'.
	expectedTokens := #({ switch '(' a ')' { case A : return '<num>' ; case B : return '<num>' ; default : return '<num>' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testSwitchMultipleOptions [
	| source tokens expectedTokens |
	
	source := 'switch (a) { case A: return 1; case B: case C: return 2; default: return 3; }'.
	expectedTokens := #({ switch '(' a ')' { case A : return '<num>' ; case B : case C : return '<num>' ; default : return '<num>' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testThrow [
	| source tokens expectedTokens |
	
	source := 'throw AssertionError(1);'.
	expectedTokens := #({ throw AssertionError '(' '<num>' ')' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testTryCatch [
	| source tokens expectedTokens |
	
	source := 'try { throw AssertError(); } catch(AssertError e) { System.out.println(e); }'.
	expectedTokens := #({ try { throw AssertError '(' ')' ; } catch '(' AssertError e ')' { System . out . println '(' e ')' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testTypeCast [
	| source tokens expectedTokens |
	
	source := 'return (A) a;'.
	expectedTokens := #({ return '(' A ')' a ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testTypeCastAndField [
	| source tokens expectedTokens |
	
	source := 'return ((A) a.b).c;'.
	expectedTokens := #({ return '(' '(' A ')' a . b ')' . c ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testTypeSet [
	| source tokens expectedTokens |
	
	source := 'A<T> a;'.
	expectedTokens := #({ A < T > a ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testUnaryAddition [
	| source tokens expectedTokens |
	
	source := 'return +1;'.
	expectedTokens := #({ return + '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testUnaryBitInvert [
	| source tokens expectedTokens |
	
	source := 'return ~1;'.
	expectedTokens := #({ return ~ '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testUnaryNot [
	| source tokens expectedTokens |
	
	source := 'return !1;'.
	expectedTokens := #({ return ! '<num>' ; }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> testWhile [
	| source tokens expectedTokens |
	
	source := 'while (true) { return 0; }'.
	expectedTokens := #({ while '(' 'true' ')' { return '<num>' ; } }).
	
	tokens := self tokenize: source.
	self assert: tokens equals: expectedTokens.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> tokenize: sourceCode [
	| method |
	method := self createMethodNode: sourceCode.
	"method body statements first inspect."
	method acceptVisitor: visitor.
	^ visitor tokens asArray.
]

{ #category : #'as yet unclassified' }
JavaTokenizingVisitorTest >> wrapMethodInClass: methodBody [

	^ 'public class ClassName {
	public static void MethodName() {
	', methodBody, '
	}
	}'.
]
