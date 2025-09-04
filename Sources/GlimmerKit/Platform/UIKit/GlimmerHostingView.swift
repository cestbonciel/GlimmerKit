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
		isUserInteractionEnabled = false
		layer.masksToBounds = true
	}
	
	public required init?(coder: NSCoder) { super.init(coder: coder) }

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

	public override func layoutSubviews() {
		super.layoutSubviews()
		core.frame = bounds
	}

	public override func didMoveToWindow() {
		super.didMoveToWindow()
		if window != nil, !paused { core.start() } else { core.stop() }
	}
}
#endif
