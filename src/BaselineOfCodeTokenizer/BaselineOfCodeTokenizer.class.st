Class {
	#name : #BaselineOfCodeTokenizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfCodeTokenizer
}

{ #category : #baselines }
BaselineOfCodeTokenizer >> baselineOf: spec [ 
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'IdentifierNameSplitter'
			with: [ spec repository: 'github://olekscode/IdentifierNameSplitter/src' ].
				
		"Packages"
		spec 
			package: 'CodeTokenizer' with: [ spec requires: #(IdentifierNameSplitter) ];
			package: 'CodeTokenizer-Tests' with: [ spec requires: #(CodeTokenizer) ]].
]
