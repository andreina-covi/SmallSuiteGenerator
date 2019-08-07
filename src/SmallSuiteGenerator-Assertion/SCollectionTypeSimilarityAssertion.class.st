Class {
	#name : #SCollectionTypeSimilarityAssertion,
	#superclass : #SSAssertion,
	#category : #'SmallSuiteGenerator-Assertion-Assertion'
}

{ #category : #'as yet unclassified' }
SCollectionTypeSimilarityAssertion class >> applyOn: aName with: aCollection of: testCase [
	| instance |
	(self preconditionChecking: aCollection)
		ifFalse: [ ^ #() ].
	instance := self new
		nameValue: aName;
		valueAssert: aCollection;
		comparableValue: aCollection first className.
	^ Array with: instance
]

{ #category : #preconditions }
SCollectionTypeSimilarityAssertion class >> preconditionChecking: aObject [
	^ aObject isCollection and: [ [
		| classFirstElement |
		classFirstElement := aObject first class. 
		aObject allButFirst allSatisfy: [ :element | element class = classFirstElement ]
		] on: Error do: [ false ]
	]
]

{ #category : #converting }
SCollectionTypeSimilarityAssertion >> printString [ 
	^ 'self assert: ( ', nameValue asString, ' allSatisfy: [:element | element className = ', comparableValue storeString, '])'
]