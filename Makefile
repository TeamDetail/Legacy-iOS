.PHONY: go clean lint periphery codequality fresh

# tuist generate
go:
	tuist generate

# tuist clean
clean:
	tuist clean

# SwiftLint
lint:
	swiftlint

# Periphery
periphery:
	periphery scan --strict

# 통합 코드 퀄리티
codequality:
	Tuist/Scripts/CodeQualityRunScript.sh

# 완전 클린 후 새로 시작
fresh:
	rm -rf \
		DerivedData \
		.build \
		Tuist/Dependencies \
		*.xcworkspace \
		*.xcodeproj \
		.graph \
		.swiftpm \
		.xcconfig \
		.project.yml \
		.project.swift
	tuist clean
	tuist generate


