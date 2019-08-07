Class {
	#name : #SMethodCoverageTest,
	#superclass : #SCoverageTest,
	#instVars : [
		'fitness'
	],
	#category : #'SmallSuiteGenerator-Tests-Fitness'
}

{ #category : #running }
SMethodCoverageTest >> setUp [
	super setUp.
	fitness := SMethodCoverage new

	
]

{ #category : #running }
SMethodCoverageTest >> tearDown [ 
	super tearDown 
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageClassSEvent [
	| testCase |
	testCase := self
		testCase: utility typeInfosSEvent second
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (SEvent price: 15)
						price;
						discount ]
				onClass: SEvent).
	self assert: (fitness run: testCase) <= 83.33	"83.33 = (5/6) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageClassSFoo [
	| testCase |
	testCase := self
		testCase: utility typeInfosSFoo fourth
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (SFoo score: 15)
						returnCollection;
						returnFloat;
						score;
						return: #(1 5 6) ]
				onClass: SFoo).
	self assert: (fitness run: testCase) <= 77.78	"77.78 = (7/9) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnClassSSTeacher [
	| testCase |
	testCase := self
		testCase: utility typeInfosSSTeacher third
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ SSTeacher new
				nickname;
				yearsWorkExperience ]
				onClass: SSTeacher).
	self assert: (fitness run: testCase) <= 60.0	"60.0 = (3/5) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnClassSStack [
	| testCase |
	testCase := self
		testCase: utility typeInfosSStack third
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (SStack newStackWith: #(2 4 6 1))
						push: 8;
						pop;
						top ]
				onClass: SStack).
	self assert: (fitness run: testCase) <= 57.14	"57.14 = (4/7) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnClassSStudent [
	| testCase |
	testCase := self
		testCase: utility typeInfosSStudent first
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ SStudent new
						idStudent;
						scoreStudent: 10;
						scoreStudent ]
				onClass: SStudent).
	self assert: (fitness run: testCase) <= 80.0	"80.0 = (4/5) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnPackagesSEvent [
	| testCase |
	testCase := self
		testCase:
			(SSGenerator
				profile: [ (SEvent price: 15)
						price;
						discount ]
				onPackagesMatching: 'SmallSuiteGenerator-Examples') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (SEvent price: 15)
						price;
						discount ]
				onPackages: 'SmallSuiteGenerator-Examples').
	self assert: (fitness run: testCase) <= 83.33
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnPackagesSFoo [
	| testCase |
	testCase := self
		testCase:
			(SSGenerator
				profile: [ (SFoo score: 15)
						returnCollection;
						returnFloat;
						score;
						return: #(1 5 6) ]
				onPackagesMatching: 'SmallSuiteGenerator-Examples') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (SFoo score: 15)
						returnCollection;
						returnFloat;
						score;
						return: #(1 5 6) ]
				onPackages: 'SmallSuiteGenerator-Examples').
	self assert: (fitness run: testCase) <= 77.78	"77.78 = (7/9) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnPackagesSSTeacher [
	| testCase |
	testCase := self
		testCase:
			(SSGenerator
				profile: [ SSTeacher new
						nickname;
						yearsWorkExperience ]
				onPackagesMatching: 'SmallSuiteGenerator-Examples') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ SSTeacher new
						nickname;
						yearsWorkExperience ]
				onPackages: 'SmallSuiteGenerator-Examples').
	self assert: (fitness run: testCase) <= 60.0	"77.78 = (7/9) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnPackagesSStack [
	| testCase |
	testCase := self
		testCase:
			(SSGenerator
				profile: [ (SStack newStackWith: #(2 4 6 1))
						push: 8;
						pop;
						top ]
				onPackagesMatching: 'SmallSuiteGenerator-Examples') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (SStack newStackWith: #(2 4 6 1))
						push: 8;
						pop;
						top ]
				onPackages: 'SmallSuiteGenerator-Examples').
	
	self assert: (fitness run: testCase) <= 57.14	"57.14 = (4/7) * 100 round: 2"
]

{ #category : #tests }
SMethodCoverageTest >> testCoverageOnPackagesSStudent [
	| testCase |
	testCase := self
		testCase:
			(SSGenerator
				profile: [ SStudent new
						idStudent;
						scoreStudent: 10;
						scoreStudent ]
				onPackagesMatching: 'SmallSuiteGenerator-Examples') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ SStudent new
						idStudent;
						scoreStudent: 10;
						scoreStudent ]
				onPackages: 'SmallSuiteGenerator-Examples').
	self assert: (fitness run: testCase) <= 80.0	
]