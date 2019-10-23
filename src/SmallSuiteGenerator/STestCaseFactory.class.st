Class {
	#name : #STestCaseFactory,
	#superclass : #Object,
	#instVars : [
		'engine',
		'typeInfo',
		'targetClassName',
		'targetPackageRegex',
		'outputPackageName',
		'fitness',
		'profiler'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'SmallSuiteGenerator-Core'
}

{ #category : #actions }
STestCaseFactory >> checkInvariants [
	self assert: typeInfo isNotNil description: 'Please provide type information of the target project'.
	self assert: targetPackageRegex isNotNil description: 'Please provide a regex that match the packages under analysis'
]

{ #category : #accessing }
STestCaseFactory >> classesForRegex: regexExpressions [
	^ ((regexExpressions
		flatCollect: [ :regex | 
			RPackage organizer packages
				select: [ :p | regex match: p name asString ] ]) asSet)
		flatCollect: #definedClasses
]

{ #category : #actions }
STestCaseFactory >> createTestCases [
	self checkInvariants.
	self setUp.
	self run.
	self tearDown.
]

{ #category : #accessing }
STestCaseFactory >> engine [
	^ SGAEngine new
		populationSize: 30;
		numberOfStatements: 30;
		endForMaxNumberOfGeneration: 15;
		yourself.
]

{ #category : #accessing }
STestCaseFactory >> engineDefault [
	^ SGAEngine new
		populationSize: 30;
		fitness: fitness;
		numberOfStatements: 30;
		numberOfIterations: 100;
		yourself.
]

{ #category : #actions }
STestCaseFactory >> export: aTestCase with: aSelector [
	|className class|
	className := ('GA',self targetClassName, 'Test') asSymbol.
	class := Smalltalk at: className ifAbsent:[nil].
	class ifNil:[ 
		class := TestCase subclass: className
			instanceVariableNames: ''
			classVariableNames: ''
			package: self outputPackageName ].
	class compile: (aSelector,'
	', aTestCase parseTreeWithAssertions formattedCode).
]

{ #category : #actions }
STestCaseFactory >> exportTests [
	|index|
	index := 1. 
	engine population do:[ :test|
		self export: test with:('test',index asString).
		index := index + 1. ].
	
]

{ #category : #configuration }
STestCaseFactory >> fitness: aFitness [
	fitness := aFitness
]

{ #category : #visualization }
STestCaseFactory >> fitnessValues [
	| nameFunctions |
	self
		assert: (engine isNotNil and: [ engine logs isNotEmpty ])
		description: 'Run the generation before'.
	nameFunctions := engine fitness allFitnessFunction
		collect: #name.
	^ nameFunctions asSet
		collect: [ :nameFunction | 
			nameFunction
				->
					(engine logs
						withIndexCollect: [ :log :index | log fittestTestCase fitness at: nameFunction ]) ]
]

{ #category : #initialization }
STestCaseFactory >> initialize [
	super initialize.
	targetClassName := nil.
	targetPackageRegex := nil.
	fitness := SMethodCoverage new.
	engine := self engineDefault.
	outputPackageName := 'SmallSuiteGenerator-Tests-Generated'.
]

{ #category : #configuration }
STestCaseFactory >> numberOfGenerations: aInt [
	engine endForMaxNumberOfGeneration: aInt
]

{ #category : #configuration }
STestCaseFactory >> numberOfStatements: aInt [
	engine numberOfStatements: aInt
]

{ #category : #accessing }
STestCaseFactory >> outputPackageName [
	^ outputPackageName
]

{ #category : #accessing }
STestCaseFactory >> outputPackageName: anObject [
	outputPackageName := anObject
]

{ #category : #configuration }
STestCaseFactory >> populationSize: aInt [
	engine populationSize: aInt
]

{ #category : #initialization }
STestCaseFactory >> randomlyGeneratedPopulation [ 
	^ engine randomlyGeneratedPopulation 
]

{ #category : #actions }
STestCaseFactory >> run [
	engine run.
	
]

{ #category : #actions }
STestCaseFactory >> setUp [
	profiler := SBProfiler new.
	(S2CInstrumentator onPackagesMatching: self targetPackageRegex) applyOn: profiler.
	profiler injectCodeToMethods.
	fitness profiler: profiler.
	engine fitness: fitness. 
	engine typeInfo: self typeInfo.
	engine targetClassName: self targetClassName.
	
]

{ #category : #accessing }
STestCaseFactory >> targetClassName [
	^ targetClassName 
]

{ #category : #accessing }
STestCaseFactory >> targetClassName: aSymbol [
	targetClassName := aSymbol.

]

{ #category : #accessing }
STestCaseFactory >> targetPackageRegex [
	^ targetPackageRegex
]

{ #category : #accessing }
STestCaseFactory >> targetPackageRegex: anObject [
	targetPackageRegex := anObject
]

{ #category : #accessing }
STestCaseFactory >> targetPackagesRegex: anObject [
	targetPackageRegex := anObject
]

{ #category : #actions }
STestCaseFactory >> tearDown [
	profiler cleanInstrumentation.
	self exportTests.
]

{ #category : #accessing }
STestCaseFactory >> typeInfo [ 
	^ typeInfo
]

{ #category : #accessing }
STestCaseFactory >> typeInfo: aTypeInfo [
	typeInfo := aTypeInfo
]

{ #category : #visualization }
STestCaseFactory >> visualize [
	| p g d |
	p := RTPalette c3.
	g := RTGrapher new.
	self fitnessValues
		doWithIndex: [ :assocation :index | 
			d := RTData new.
			d connectColor: (p at: index).
			d noDot.
			d points: assocation value.
			d label: assocation key asString.
			d y: #yourself.
			g add: d ].
	g legend addText: 'Fitness evolution'.
	^ g
]