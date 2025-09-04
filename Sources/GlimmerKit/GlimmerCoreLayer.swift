//
//  GlimmerCoreLayer.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//

import QuartzCore
import SwiftUI

final class GlimmerCoreLayer: CAGradientLayer {
	var cycleDuration: Double = 1.1
	var bounce: Bool = false
	var bandWidth: CGFloat = 0.28
	var phaseOffset: CGFloat = 0

	override init() {
		super.init()
		masksToBounds = true
		needsDisplayOnBoundsChange = true
	}
	override init(layer: Any) { super.init(layer: layer) }
	required init?(coder: NSCoder) { super.init(coder: coder) }

	func configureGradient(tint: CGColor, highlight: CGColor, angleDegrees: CGFloat) {
		colors = [tint, highlight, tint]
		let rad = angleDegrees * .pi / 180
		let dx = cos(rad) * 0.5 + 0.5
		let dy = sin(rad) * 0.5 + 0.5
		startPoint = CGPoint(x: 1 - dx, y: 1 - dy)
		endPoint   = CGPoint(x: dx, y: dy)
	}

	func start() {
		removeAnimation(forKey: "glimmer")
		
		let left:  [NSNumber] = [
			NSNumber(value: -Float(bandWidth) + Float(phaseOffset)),
			NSNumber(value:  0 + Float(phaseOffset)),
			NSNumber(value:  Float(bandWidth) + Float(phaseOffset))
		]
		let right: [NSNumber] = [
			NSNumber(value: 1 - Float(bandWidth) + Float(phaseOffset)),
			NSNumber(value: 1 + Float(phaseOffset)),
			NSNumber(value: 1 + Float(bandWidth) + Float(phaseOffset))
		]
		
		locations = left
		
		let animation = CABasicAnimation(keyPath: "locations")
		animation.fromValue = left
		animation.toValue = right
		animation.duration = cycleDuration
		animation.repeatCount = .infinity
		animation.autoreverses = bounce
		animation.timingFunction = .init(name: .linear)
		
		add(animation, forKey: "glimmer")
	}

	func stop() {
		removeAnimation(forKey: "glimmer")
	}
}
