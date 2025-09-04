//
//  GlimmerWatchOverlay.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/5/25.
//
#if os(watchOS)
import SwiftUI

@available(watchOS 10, *)
struct GlimmerWatchOverlay: View {
	let config: GlimmerConfiguration
	let paused: Bool
	let reduceMotion: Bool
	let sizeCat: ContentSizeCategory

	@Environment(\.colorScheme) private var colorScheme

	var body: some View {
		let tuned = tunedParameters(
			from: schemeAdjusted(config),
			reduceMotion: reduceMotion,
			isLowPower: false, // watchOS에선 별도 감지 대신 보수적으로 false
			contentSizeCat: sizeCat
		)

		TimelineView(.animation(minimumInterval: paused ? .infinity : 1.0 / 60.0)) { context in
			let t = context.date.timeIntervalSinceReferenceDate
			let progress = paused ? 0.0 : fmod(t / max(tuned.effectiveSpeed, 0.001), 1.0)

			let band = CGFloat(tuned.effectiveBand)
			let phase = CGFloat(progress)

			let mid = phase
			let left  = mid - band
			let right = mid + band

			let tint = config.tint
			let hi = config.highlight

			let gradient = Gradient(stops: [
				.init(color: tint, location: max(0, left)),
				.init(color: hi,   location: min(1, mid)),
				.init(color: tint, location: min(1, right))
			])

			LinearGradient(
				gradient: gradient,
				startPoint: gradientStart(angleDegrees: tuned.effectiveAngle),
				endPoint: gradientEnd(angleDegrees: tuned.effectiveAngle)
			)
		}
	}

	private func schemeAdjusted(_ base: GlimmerConfiguration) -> GlimmerConfiguration {
		var c = base
		if colorScheme == .dark {
			c.tint = Color.gray.opacity(0.24)
			c.highlight = Color.white.opacity(0.65)
		} else {
			c.tint = Color.gray.opacity(0.18)
			c.highlight = Color.white.opacity(0.70)
		}
		return c
	}

	private func gradientStart(angleDegrees: CGFloat) -> UnitPoint {
		let rad = angleDegrees * .pi / 180
		let dx = cos(rad) * 0.5
		let dy = sin(rad) * 0.5
		return UnitPoint(x: 0.5 - dx, y: 0.5 - dy)
	}
	private func gradientEnd(angleDegrees: CGFloat) -> UnitPoint {
		let rad = angleDegrees * .pi / 180
		let dx = cos(rad) * 0.5
		let dy = sin(rad) * 0.5
		return UnitPoint(x: 0.5 + dx, y: 0.5 + dy)
	}
}

#if DEBUG
@available(watchOS 10, *)
#Preview("Glimmer watchOS overlay") {
	ZStack {
		RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.22))
			.frame(width: 140, height: 24)

		GlimmerWatchOverlay(
			config: .init(),
			paused: false,
			reduceMotion: false,
			sizeCat: .medium
		)
		.clipped()
	}
	.padding()
}
#endif
#endif
