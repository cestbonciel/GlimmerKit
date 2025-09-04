//
//  GlimmerTuning.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
import SwiftUI
import CoreGraphics

struct GlimmerTuning {
	var effectiveSpeed: Double
	var effectiveBand: CGFloat
	var effectiveAngle: CGFloat
}

@MainActor
func tunedParameters(from configuration: GlimmerConfiguration,
					 reduceMotion: Bool,
					 isLowPower: Bool,
					 contentSizeCat: ContentSizeCategory) -> GlimmerTuning {
	var speed = configuration.speed
	var band = configuration.bandWidth
	let angle = CGFloat(configuration.angle.degrees)

	if reduceMotion || isLowPower {
		speed = max(speed, 1.5)
		band = min(band + 0.05, 0.40)
	}

	if contentSizeCat.isAccessibilityCategory {
		band = min(band + 0.06, 0.40)
	}

	band = min(max(band, 0.10), 0.40)

	return .init(effectiveSpeed: speed, effectiveBand: band, effectiveAngle: angle)
}

func phaseOffset(seed: UInt64?) -> CGFloat {
	var g = SystemRandomNumberGenerator()
	if var s = seed {
		s &+= 0x9E3779B97F4A7C15
		s = (s ^ (s >> 30)) &* 0xBF58476D1CE4E5B9
		s = (s ^ (s >> 27)) &* 0x94D049BB133111EB
		s =  s ^ (s >> 31)
		let v = Double(s % UInt64.max) / Double(UInt64.max)
		return CGFloat(v)
	} else {
		let v = Double.random(in: 0..<1, using: &g)
		return CGFloat(v)
	}
}
