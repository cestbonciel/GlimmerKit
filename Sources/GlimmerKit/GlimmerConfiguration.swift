//
//  GlimmerConfiguration.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//

import SwiftUI

public struct GlimmerConfiguration: Sendable, Equatable {
	public var tint: Color
	public var highlight: Color
	public var angle: Angle
	public var speed: Double
	public var bounce: Bool
	public var bandWidth: CGFloat
	public var desyncSeed: UInt64?
	
	public init(
		tint: Color = .gray.opacity(0.18),
		highlight: Color = .white.opacity(0.70),
		angle: Angle = .degrees(16),
		speed: Double = 1.2,
		bounce: Bool = false,
		bandWidth: CGFloat = 0.22,
		desyncSeed: UInt64? = nil
	) {
		self.tint = tint
		self.highlight = highlight
		self.angle = angle
		self.speed = speed
		self.bounce = bounce
		self.bandWidth = bandWidth
		self.desyncSeed = desyncSeed
	}
}
