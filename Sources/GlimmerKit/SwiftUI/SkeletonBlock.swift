//
//  SkeletonBlock.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
import SwiftUI
/// A skeleton placeholder block that can be drawn with any SwiftUI Shape.
/// - Note: Generic over `S: Shape & Sendable` to be Swift 6 / strict concurrency friendly.
@available(iOS 16, macOS 15, *)
public struct SkeletonBlock<S: Shape & Sendable>: View {
	private let shape: S
	private let size: CGSize?
	private let config: GlimmerConfiguration

	/// Designated initializer taking any Shape.
	/// - Parameters:
	///   - shape: Any SwiftUI Shape (e.g., RoundedRectangle, Circle, Capsule, custom shapes).
	///   - size: Optional fixed size. If nil, layout drives the size.
	///   - configuration: Glimmer configuration (tint/highlight/speed/bandWidth…).
	public init(
		_ shape: S,
		size: CGSize? = nil,
		configuration: GlimmerConfiguration = .init()
	) {
		self.shape = shape
		self.size = size
		self.config = configuration
	}

	public var body: some View {
		shape
			.fill(Color.gray.opacity(0.25))
			.frame(width: size?.width, height: size?.height)
			.glimmer(config)
			.clipShape(shape)
			.accessibilityHidden(true)
	}
}

// MARK: - Convenience initializers for common shapes
@available(iOS 16, macOS 15, *)
public extension SkeletonBlock where S == RoundedRectangle {
	/// Convenience initializer for a rounded rectangle skeleton.
	init(
		cornerRadius: CGFloat = 12,
		size: CGSize? = nil,
		configuration: GlimmerConfiguration = .init()
	) {
		self.init(
			RoundedRectangle(cornerRadius: cornerRadius, style: .continuous),
			size: size,
			configuration: configuration
		)
	}
}

@available(iOS 16, macOS 15, *)
public extension SkeletonBlock where S == Circle {
	/// Convenience initializer for a circular skeleton.
	init(
		circleWith size: CGSize? = nil,
		configuration: GlimmerConfiguration = .init()
	) {
		self.init(Circle(), size: size, configuration: configuration)
	}
}

@available(iOS 16, macOS 15, *)
public extension SkeletonBlock where S == Capsule {
	/// Convenience initializer for a capsule skeleton.
	init(
		capsuleWith size: CGSize? = nil,
		configuration: GlimmerConfiguration = .init()
	) {
		self.init(Capsule(), size: size, configuration: configuration)
	}
}

// MARK: - Debug previews

#if DEBUG
@available(iOS 16, macOS 15, *)
#Preview("SkeletonBlock Preview") {
	VStack(spacing: 16) {
		SkeletonBlock(cornerRadius: 12, size: .init(width: 220, height: 14))
		HStack(spacing: 12) {
			SkeletonBlock(circleWith: .init(width: 44, height: 44))
			VStack(alignment: .leading, spacing: 8) {
				SkeletonBlock(cornerRadius: 10, size: .init(width: 200, height: 12))
				SkeletonBlock(cornerRadius: 10, size: .init(width: 140, height: 12),
							  configuration: .init(angle: .degrees(24), speed: 0.9))
			}
		}

		SkeletonBlock(
			RoundedRectangle(cornerRadius: 16, style: .continuous),
			size: .init(width: 220, height: 16),
			configuration: .init(bounce: true, bandWidth: 0.34)
		)
	}
	.padding()
}
#endif
