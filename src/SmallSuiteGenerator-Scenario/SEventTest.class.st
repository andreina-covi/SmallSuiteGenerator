Class {
	#name : #SEventTest,
	#superclass : #TestCase,
	#category : #'SmallSuiteGenerator-Scenario'
}

{ #category : #tests }
SEventTest >> testDiscount [
	| event |
	event := SEvent new.
	event price: 80.
	event discount: 20.
	self assert: event discount equals: 20.
	self assert: event price equals: 64
]

{ #category : #tests }
SEventTest >> testDiscountWithZeroPrice [
	| event |
	event := SEvent new.
	event discount: 20.
	self assert: event discount equals: 0.
	self assert: event price equals: 0.
	
]

{ #category : #tests }
SEventTest >> testPrice [
	| event |
	event := SEvent new.
	event price: 80.
	self assert: event price equals: 80
]
