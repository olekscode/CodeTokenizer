Class {
	#name : #BaselineOfCodeTokenizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfCodeTokenizer
}

{ #category : #baselines }
BaselineOfCodeTokenizer >> baselineOf: spec [ 
	<baseline>
	spec for: #common do: [	
				
		"Packages"
		spec 
			package: 'CodeTokenizer';
			package: 'CodeTokenizer-Tests' with: [ spec requires: #('CodeTokenizer') ]].
]
