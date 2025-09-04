//
//  GlimmerHostingNSView.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwiftUI

final class GlimmerHostingNSView: NSView {
	private let core = GlimmerCoreLayer()
	var paused: Bool = false { didSet { paused ? core.stop() : core.start() } }

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		wantsLayer = true
		layer?.masksToBounds = true
		layer?.addSublayer(core)
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		wantsLayer = true
		layer?.masksToBounds = true
		layer?.addSublayer(core)
	}

	func apply(configuration: GlimmerConfiguration, tuning: GlimmerTuning) {
		core.cycleDuration = tuning.effectiveSpeed
		core.bounce = configuration.bounce
		core.bandWidth = tuning.effectiveBand
		core.phaseOffset = phaseOffset(seed: configuration.desyncSeed)
		core.configureGradient(
			tint: CGColor.from(configuration.tint),
			highlight: CGColor.from(configuration.highlight),
			angleDegrees: tuning.effectiveAngle
		)
		if window != nil, !paused { core.start() }
	}

	override func layout() {
		super.layout()
		core.frame = bounds
	}

	override func viewDidMoveToWindow() {
		super.viewDidMoveToWindow()
		if window != nil, !paused { core.start() } else { core.stop() }
	}
}
#endif
