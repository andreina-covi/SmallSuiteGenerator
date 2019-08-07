Class {
	#name : #SCoverageTestWithRoassal,
	#superclass : #TestCase,
	#instVars : [
		'utility'
	],
	#category : #'SmallSuiteGenerator-Tests-Roassal'
}

{ #category : #'public - profiling' }
SCoverageTestWithRoassal >> profile: aBlock onClass: aClass [
	^ SBProfiler new
		profileInstrumented: aBlock onClass: aClass;
		yourself
]

{ #category : #'public - profiling' }
SCoverageTestWithRoassal >> profile: aBlock onPackages: regex [
	^ SBProfiler new
		profileInstrumented: aBlock onPackagesMatching: regex;
		yourself
]

{ #category : #running }
SCoverageTestWithRoassal >> setUp [
	utility := SUtilityRoassal new.
]

{ #category : #running }
SCoverageTestWithRoassal >> tearDown [ 
	S2Lock value: false.
	S2Context value: nil.
	S2Profiler remove
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCase: typeInfo withNumStatements: aNumber [
	^ (SSTestCase with: typeInfo)
		numMaxStatements: aNumber;
		generateStatements
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageClassRTAMItem [
	| testCase fitness |
	fitness := SMethodCoverage new.
	testCase :=self
		testCase: utility typeInfosRTAMItem second
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTAMItem basicNew
						itemName: 'Bonus Card';
						row: 'France';
						column: 'Customer Relationship';
						color: Color lightGreen ]
				onClass: RTAMItem).
	self assert: (fitness run: testCase) > 0.	"28.57 = (4/14) * 100"
	fitness := SStatementCoverage new.
	testCase := self
		testCase: utility typeInfosRTAMItem second
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTAMItem basicNew
						itemName: 'Bonus Card';
						row: 'France';
						column: 'Customer Relationship';
						color: Color lightGreen ]
				onClass: RTAMItem).
	self assert: (fitness run: testCase) >0	"21.05 = (4/19) * 100"
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageClassRTBorderAttachPoint [
	| testCase fitness |
	fitness := SMethodCoverage new.
	testCase := self
		testCase: utility typeInfoRTBorderAttachPoint
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTBorderAttachPoint new offset: 4 ]
				onClass: RTBorderAttachPoint).
	self assert: (fitness run: testCase) <= 25.	"25 = (2/8) * 100 round: 2"
	fitness := SStatementCoverage new.
	testCase := self
		testCase: utility typeInfoRTBorderAttachPoint
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTBorderAttachPoint new offset: 4 ]
				onClass: RTBorderAttachPoint).
	self assert: (fitness run: testCase) <= 9.68	"9.68 = (3/31) * 100 round: 2"
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageClassRTBox [
	| testCase fitness |
	fitness := SMethodCoverage new.
	testCase := self
		testCase: utility typeInfoRTBox
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTBox new
						defaultWidth;
						borderStyle ]
				onClass: RTBox).
	self assert: (fitness run: testCase) <= 20.	"20 = (1/5) * 100 round: 2"
	fitness := SStatementCoverage new.
	testCase := self
		testCase: utility typeInfoRTBox
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTBox new
						defaultWidth;
						borderStyle ]
				onClass: RTBox).
	self assert: (fitness run: testCase) <= 22.22	"(2/9) * 100 round: 2"
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageClassRTDirectedLine [
	| testCase fitness |
	fitness := SMethodCoverage new.
	testCase := self
		testCase: utility typeInfosRTDirectedLine second
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTDirectedLine instance
						pointsFrom: 1 @ 3 To: 3 @ 5;
						offset: 6.5 ]
				onClass: RTDirectedLine).
	self assert: (fitness run: testCase) <= 60.	"60 = (3/5) * 100 round: 2"
	fitness := SStatementCoverage new.
	testCase := self
		testCase: utility typeInfosRTDirectedLine second
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTDirectedLine instance
						pointsFrom: 1 @ 3 To: 3 @ 5;
						offset: 6.5 ]
				onClass: RTDirectedLine).
	self assert: (fitness run: testCase) <= 54.55	"54.55 = (6/11) * 100 round: 2"
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageClassRTLineSegment [
	| testCase fitness |
	fitness := SMethodCoverage new.
	testCase := self
		testCase: utility typeInfosRTLineSegment first
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (RTLineSegment from: 4 @ 9 to: 5 @ 18)
						angleInDeg;
						angleInRad;
						cotan;
						bottom ]
				onClass: RTLineSegment).
	self assert: (fitness run: testCase) <= 23.53.	"23.53 = (8/34) * 100 round: 2"
	fitness := SStatementCoverage new.
	testCase := self
		testCase: utility typeInfosRTLineSegment first
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (RTLineSegment from: 4 @ 9 to: 5 @ 18)
						angleInDeg;
						angleInRad;
						cotan;
						bottom ]
				onClass: RTLineSegment).
	self assert: (fitness run: testCase) <= 13.46	"13.46 = (14/104) * 100 round: 2"
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageOnPackagesRTAMItem [
	| testCase fitness |
	fitness := SStatementCoverage new.
	testCase := self
		testCase:
			(SSGenerator
				profile: [ RTAMItem new
						itemName: 'Bonus Card';
						color: Color lightCyan ]
				onPackagesMatching: 'Roassal2') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTAMItem new
						itemName: 'Bonus Card';
						color: Color lightCyan ]
				onPackages: 'Roassal2').
	self assert: (fitness run: testCase) <= 21.05
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageOnPackagesRTAMItemSimpleInstruction [
	| testCase fitness |
	fitness := SStatementCoverage new.
	testCase := self
		testCase:
			(SSGenerator
				profile: [ RTAMItem basicNew ]
				onPackagesMatching: 'Roassal2') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler: (self profile: [ RTAMItem basicNew ] onPackages: 'Roassal2').
	self assert: (fitness run: testCase) <= 21.05
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageOnPackagesRTBorderAttachPoint [
	| testCase fitness |
	fitness := SStatementCoverage new.
	testCase := self
		testCase:
			(SSGenerator
				profile: [ RTBorderAttachPoint new offset: 4 ]
				onPackagesMatching: 'Roassal2-Cor*') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTBorderAttachPoint new offset: 4 ]
				onPackages: 'Roassal2-Cor*').
	self assert: (fitness run: testCase) <= 9.68
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageOnPackagesRTDirectedLine [
	| testCase fitness |
	fitness := SStatementCoverage new.
	testCase := self
		testCase:
			(SSGenerator
				profile: [ RTDirectedLine instance
						pointsFrom: 1 @ 3 To: 3 @ 5;
						offset: 6.5 ]
				onPackagesMatching: 'Roassal2-Cor*') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ RTDirectedLine instance
						pointsFrom: 1 @ 3 To: 3 @ 5;
						offset: 6.5 ]
				onPackages: 'Roassal2-Cor*').
	self assert: (fitness run: testCase) <= 54.55
]

{ #category : #tests }
SCoverageTestWithRoassal >> testCoverageOnPackagesRTLineSegment [
	| testCase fitness |
	fitness := SStatementCoverage new.
	testCase := self
		testCase:
			(SSGenerator
				profile: [ (RTLineSegment from: 4 @ 9 to: 5 @ 18)
						angleInDeg;
						angleInRad;
						cotan;
						bottom ]
				onPackagesMatching: 'Roassal2-Cor*') asTypeInfo
		withNumStatements: 20.
	fitness
		profiler:
			(self
				profile: [ (RTLineSegment from: 4 @ 9 to: 5 @ 18)
						angleInDeg;
						angleInRad;
						cotan;
						bottom ]
				onPackages: 'Roassal2-Cor*').
	self assert: (fitness run: testCase) <= 13.46
]