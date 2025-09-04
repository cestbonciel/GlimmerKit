# GlimmerKit

SwiftUI & UIKit/AppKit **shimmer / skeleton** loading effects.
**iOS 16+ (includes iPadOS)** · **macOS 15+** · **watchOS 10+ (SwiftUI-only)**
Reduce Motion / Low Power aware · Light/Dark tone adjustment · Multi-framework

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-success.svg)

---

## Features
- **Multi-framework**: SwiftUI + (iOS) **UIKit** / (macOS) **AppKit** via CAGradientLayer
- **watchOS 10+**: Pure SwiftUI overlay implementation
- **Accessibility/Power aware**: Auto tuning for Reduce Motion & Low Power
- **Global pause**: `.glimmerPaused(true)` pauses an entire subtree
- **Accurate masking**: `SkeletonBlock<Shape>` uses `clipShape` to preserve circles/corners
- **Light/Dark tone adjustment**: On by default (can be disabled)
- **Presets**: `.subtle` / `.bold`, plus full custom configuration

---

## Requirements
- Swift 5.10+
- iOS 16+ (**iPadOS included**)
- macOS 15+
- watchOS 10+ (SwiftUI-only)
- (Optional) tvOS 16+, visionOS 1.0 — add to `Package.swift` if needed

---

## Installation (Swift Package Manager)

### Xcode
1. **File → Add Package Dependencies…**
2. URL: `https://github.com/cestbonciel/GlimmerKit`
3. Product: **GlimmerKit**

### `Package.swift`
```swift
// in Package.swift of your app/framework
dependencies: [
	.package(url: "https://github.com/cestbonciel/GlimmerKit", from: "1.0.0")
],
targets: [
	.target(
		name: "YourTarget",
		dependencies: ["GlimmerKit"]
	)
]
