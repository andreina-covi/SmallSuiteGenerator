Class {
	#name : #SGAEngineTest,
	#superclass : #TestCase,
	#instVars : [
		'engine'
	],
	#category : #'SmallSuiteGenerator-Tests-GeneticAlgorithm'
}

{ #category : #actions }
SGAEngineTest >> runOnClass: aClass withBlock: aBlock andFitness: aClassFitness [
	"	SSGeneratorInvariant resetNumTest."

	engine
		populationSize: 10;
		numberOfStatements: 10;
		blockToExecute: aBlock.
	engine
		typeInfo:
			(SSGenerator profile: engine blockToExecute onClass: aClass)
				asTypeInfo;
		fitness: (aClassFitness coverageOf: aBlock onClass: aClass);
		endForMaxNumberOfGeneration: 10;
		run
]

{ #category : #running }
SGAEngineTest >> setUp [ 
	engine := SGAEngine new
]

{ #category : #running }
SGAEngineTest >> tearDown [
	S2Lock value: false.
	S2Context value: nil.
	S2Profiler remove
]

{ #category : #tests }
SGAEngineTest >> testRunOnClassSSTeacherUsingSMethodCoverage [
	| first last |
	self
		runOnClass: SSTeacher
		withBlock: [ (SSTeacher name: 'Ann' with: 34)
				name;
				nickname;
				yearsWorkExperience;
				idTeacher;
				id ]
		andFitness: SMethodCoverage.
	first := engine logs first fittestTestCase fitness first.
	last := engine logs last fittestTestCase fitness first.
	self assert: first <= last.
	self assert: first >= 20.	"20 = (1/5) * 100"
	self assert: last equals: 80	"80 = (4/5) * 100"
]

{ #category : #tests }
SGAEngineTest >> testRunOnClassSSTeacherUsingSStatementCoverage [
	| first last |
	self
		runOnClass: SSTeacher
		withBlock: [ (SSTeacher name: 'Ann' with: 34)
				name;
				nickname;
				yearsWorkExperience;
				idTeacher;
				id ]
		andFitness: SStatementCoverage.
	first := engine logs first fittestTestCase fitness first.
	last := engine logs last fittestTestCase fitness first.
	self assert: first <= last.
	self assert: first >= 37.5.	"37.5 = (3/8) * 100"
	self assert: last >= 87.5	"87.5 = (7/8) * 100"
]