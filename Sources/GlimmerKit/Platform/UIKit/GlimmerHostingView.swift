//
//  GlimmerHostingView.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
#if canImport(UIKit)
import UIKit
import SwiftUI

public final class GlimmerHostingView: UIView {
	public override class var layerClass: AnyClass { GlimmerCoreLayer.self }
	private var core: GlimmerCoreLayer { layer as! GlimmerCoreLayer }

	public var paused: Bool = false {
		didSet { paused ? core.stop() : core.start() }
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	public required init?(coder: NSCoder) { super.init(coder: coder) }
	
	private func commonInit() {
		isUserInteractionEnabled = false
		layer.masksToBounds = true
	}
	
	// MARK: - Public Configuration API
	
	/// Simple way to use in UIKit: call once after adding/laying out the view.
	/// The view starts shimmering automatically when visible.
	///
	/// - Parameters:
	///   - configuration: Visual parameters (tint, highlight, angle, speed, bandWidth, bounce, desyncSeed).
	///   - overrideReduceMotion: Force simulate Reduce Motion (nil = use system).
	///   - overrideLowPower: Force simulate Low Power Mode (nil = use system).
	public func configure(
		_ configuration: GlimmerConfiguration = .init(),
		overrideReduceMotion: Bool? = nil,
		overrideLowPower: Bool? = nil
	) {
		let reduce = overrideReduceMotion ?? UIAccessibility.isReduceMotionEnabled
		let low = overrideLowPower ?? ProcessInfo.processInfo.isLowPowerModeEnabled
		
		let uiSizeCat = UIApplication.shared.preferredContentSizeCategory
		let sizeCat = mapContentSizeCategory(uiSizeCat)
		
		let tuned = tunedParameters(
			from: configuration,
			reduceMotion: reduce,
			isLowPower: low,
			contentSizeCat: sizeCat
		)
		
		apply(configuration: configuration, tuning: tuned)
	}
	
	func apply(configuration: GlimmerConfiguration, tuning: GlimmerTuning) {
		core.cycleDuration = tuning.effectiveSpeed
		core.bounce        = configuration.bounce
		core.bandWidth     = tuning.effectiveBand
		core.phaseOffset   = phaseOffset(seed: configuration.desyncSeed)
		
		core.configureGradient(
			tint: CGColor.from(configuration.tint),
			highlight: CGColor.from(configuration.highlight),
			angleDegrees: tuning.effectiveAngle
		)
		
		if window != nil, !paused { core.start() }
	}
	
	// MARK: - UIView
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		core.frame = bounds
	}
	
	public override func didMoveToWindow() {
		super.didMoveToWindow()
		if window != nil, !paused { core.start() } else { core.stop() }
	}
	
	// MARK: - Helpers
	
	/// Stable phase offset from a seed to desync multiple shimmers.
	private func phaseOffset(seed: UInt64?) -> CGFloat {
		guard let s = seed else { return 0 }
		// 0...1 로 매핑
		let mixed = s ^ 0x9E3779B97F4A7C15 // 간단 해시
		return CGFloat(mixed % 10_000) / 10_000.0
	}

	private func mapContentSizeCategory(_ ui: UIContentSizeCategory) -> ContentSizeCategory {
		switch ui {
		case .extraSmall:
			return .extraSmall
		case .small:
			return .small
		case .medium:
			return .medium
		case .large, .unspecified:
			return .large
		case .extraLarge:
			return .extraLarge
		case .extraExtraLarge:
			return .extraExtraLarge
		case .extraExtraExtraLarge:
			return .extraExtraExtraLarge
		case .accessibilityMedium:
			return .accessibilityMedium
		case .accessibilityLarge:
			return .accessibilityLarge
		case .accessibilityExtraLarge:
			return .accessibilityExtraLarge
		case .accessibilityExtraExtraLarge:
			return .accessibilityExtraExtraLarge
		case .accessibilityExtraExtraExtraLarge:
			return .accessibilityExtraExtraExtraLarge
		default:
			return .large
		}
	}
}
#endif
