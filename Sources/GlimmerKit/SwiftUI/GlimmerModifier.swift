//
//  GlimmerModifier.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
import SwiftUI

@available(iOS 16, macOS 15, *)
public struct Glimmer: ViewModifier {
	@Environment(\.glimmerPaused) private var paused
	@Environment(\.sizeCategory) private var sizeCat
	@Environment(\.accessibilityReduceMotion) private var envReduceMotion
	@Environment(\.colorScheme) private var colorScheme

	private let config: GlimmerConfiguration
	private let defaultLowPowerMode: Bool
	private let overrideReduceMotion: Bool?
	private let overrideLowPowerMode: Bool?
	private let adjustForColorScheme: Bool

	public init(
		_ config: GlimmerConfiguration = .init(),
		lowPowerMode: Bool = ProcessInfo.processInfo.isLowPowerModeEnabled,
		overrideReduceMotion: Bool? = nil,
		overrideLowPowerMode: Bool? = nil,
		adjustForColorScheme: Bool = true
	) {
		self.config = config
		self.defaultLowPowerMode = lowPowerMode
		self.overrideReduceMotion = overrideReduceMotion
		self.overrideLowPowerMode = overrideLowPowerMode
		self.adjustForColorScheme = adjustForColorScheme
	}

	public func body(content: Content) -> some View {
		content
			.overlay(overlayView.clipped())
			.accessibilityHidden(true)
	}

	private var schemeAdjustedConfig: GlimmerConfiguration {
		guard adjustForColorScheme else { return config }
		var c = config
		if colorScheme == .dark {
			c.tint = .gray.opacity(0.24)
			c.highlight = .white.opacity(0.65)
		} else {
			c.tint = .gray.opacity(0.18)
			c.highlight = .white.opacity(0.70)
		}
		return c
	}

	@ViewBuilder
	private var overlayView: some View {
		let effectiveReduceMotion = overrideReduceMotion ?? envReduceMotion
		#if os(watchOS)
		if #available(watchOS 10, *) {
			GlimmerWatchOverlay(
				config: schemeAdjustedConfig,
				paused: paused,
				reduceMotion: effectiveReduceMotion,
				sizeCat: sizeCat
			)
			.allowsHitTesting(false)
		} else {
			EmptyView()
		}
		#else
		let effectiveLowPower = overrideLowPowerMode ?? defaultLowPowerMode
		#if canImport(UIKit)
		GlimmerWrapperView(
			config: schemeAdjustedConfig,
			paused: paused,
			reduceMotion: effectiveReduceMotion,
			isLowPower: effectiveLowPower,
			sizeCat: sizeCat
		)
		.allowsHitTesting(false)
		#elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
		GlimmerWrapperNSView(
			config: schemeAdjustedConfig,
			paused: paused,
			reduceMotion: effectiveReduceMotion,
			isLowPower: effectiveLowPower,
			sizeCat: sizeCat
		)
		.allowsHitTesting(false)
		#else
		EmptyView()
		#endif
		#endif
	}
}

@available(iOS 16, macOS 15, *)
public extension View {
	func glimmer(
		_ configuration: GlimmerConfiguration = .init(),
		overrideReduceMotion: Bool? = nil,
		overrideLowPower: Bool? = nil,
		adjustForColorScheme: Bool = true
	) -> some View {
		modifier(Glimmer(configuration,
						 lowPowerMode: ProcessInfo.processInfo.isLowPowerModeEnabled,
						 overrideReduceMotion: overrideReduceMotion,
						 overrideLowPowerMode: overrideLowPower,
						 adjustForColorScheme: adjustForColorScheme))
	}
}
