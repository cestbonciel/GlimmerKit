//
//  GlimmerHostingView.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
#if canImport(UIKit)
import UIKit
import SwiftUI

final class GlimmerHostingView: UIView {
	override class var layerClass: AnyClass { GlimmerCoreLayer.self }
	private var core: GlimmerCoreLayer { layer as! GlimmerCoreLayer }

	var paused: Bool = false {
		didSet { paused ? core.stop() : core.start() }
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		isUserInteractionEnabled = false
		layer.masksToBounds = true
	}
	required init?(coder: NSCoder) { super.init(coder: coder) }

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

	override func layoutSubviews() {
		super.layoutSubviews()
		core.frame = bounds
	}

	override func didMoveToWindow() {
		super.didMoveToWindow()
		if window != nil, !paused { core.start() } else { core.stop() }
	}
}
#endif
