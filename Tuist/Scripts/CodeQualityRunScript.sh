#!/bin/bash

echo "🔍 Running Code Quality Checks..."

# SwiftLint
if which swiftlint > /dev/null; then
  echo "🚀 SwiftLint is running..."
  swiftlint
else
  echo "⚠️ SwiftLint not installed. Install via: brew install swiftlint"
fi

# Periphery
if which periphery > /dev/null; then
  echo "🧹 Periphery is running..."
  periphery scan --config .periphery.yml
else
  echo "⚠️ Periphery not installed. Install via: brew install peripheryapp/periphery/periphery"
fi

echo "✅ Code Quality Checks Finished!"

