Class {
	#name : #SExtensionsTest,
	#superclass : #TestCase,
	#category : #'SmallSuiteGenerator-Tests-Core'
}

{ #category : #tests }
SExtensionsTest >> createStudent [
	^ (SStudent new
				name: 'Pedro';
				id: 5)
]

{ #category : #tests }
SExtensionsTest >> testMutateToChange [
	self assert: true mutateToChange equals: false.
	self assert: false mutateToChange equals: true.
	self deny: 1234 mutateToChange equals: 1234.
	self deny: 23.34 mutateToChange equals: 23.34.
	self deny: $e mutateToChange equals: $e.
	self deny: '$character' mutateToChange equals: '$character'.
	self deny: 'hello' mutateToChange equals: 'hello'.
	self assert: #(1 2 5 6) mutateToChange equals: #(1 2 5 6).
	self deny: '#(1 2 5 6' mutateToChange equals: '#(1 2 5 6'.
	self
		assert: (SStack newStackWith: #(1 6 2 4)) mutateToChange
		equals: (SStack newStackWith: #(1 6 2 4)).
	self
		assert: self createStudent mutateToChange storeString
		equals: self createStudent storeString
]

{ #category : #tests }
SExtensionsTest >> testStoreString [
	self assert: 1 storeString equals: '1'.
	self assert: 4.6 storeString equals: '4.6'.
	self assert: true storeString equals: 'true'.
	self assert: false storeString equals: 'false'.
	self assert: 'hello' storeString equals: '''hello'''.
	self assert: $d storeString equals: '$d'.
	self assert: (SSTeacher new name: 'Mary') storeString isNotEmpty.
	self assert: (SStudent new name: 'Alan') storeString isNotEmpty
]
