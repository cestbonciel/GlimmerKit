//
//  GlimmerEnvironment.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//

import SwiftUI

private struct GlimmerPausedKey: EnvironmentKey {
	static let defaultValue: Bool = false
}

public extension EnvironmentValues {
	var glimmerPaused: Bool {
		get { self[GlimmerPausedKey.self] }
		set { self[GlimmerPausedKey.self] = newValue }
	}
}

public extension View {
	func glimmerPaused(_ paused: Bool) -> some View {
		environment(\.glimmerPaused, paused)
	}
}
