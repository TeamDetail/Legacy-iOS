# Makefile

# 프로젝트 설정 및 생성
generate:
	mise exec -- tuist install
	Make generate
	mise exec -- tuist generate
	mise exec -- tuist edit

# Xcode 관련 파일 정리
clean:
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

# tuist 클린 + Xcode 파일 정리
reset:
	mise exec -- tuist clean
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

# Swift Package Manager 캐시 삭제
clean-spm:
	rm -rf ~/Library/Caches/org.swift.swiftpm
	rm -rf ~/Library/org.swift.swiftpm

