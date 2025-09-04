//
//  GlimmerConfiguration+Presets.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/5/25.
//

import SwiftUI

public extension GlimmerConfiguration {
	static let subtle = GlimmerConfiguration(
		tint: .gray.opacity(0.18),
		highlight: .white.opacity(0.70),
		angle: .degrees(16),
		speed: 1.2,
		bandWidth: 0.22
	)

	static let bold = GlimmerConfiguration(
		tint: .gray.opacity(0.28),
		highlight: .white.opacity(0.90),
		angle: .degrees(20),
		speed: 0.9,
		bandWidth: 0.28
	)
}

