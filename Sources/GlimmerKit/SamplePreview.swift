//
//  SamplePreview.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
#if DEBUG
import SwiftUI

@available(iOS 16, macOS 15, *)
struct SamplePreview: View {
	@State private var paused = false
	@State private var reduceMotion = false
	@State private var lowPower = false

	@State private var speed: Double = 1.1
	@State private var band: Double  = 0.24
	@State private var angle: Double = 18
	@State private var bounce = false
	@State private var desync = true

	private var configuration: GlimmerConfiguration {
		GlimmerConfiguration(
			tint: .gray.opacity(0.22),
			highlight: .white.opacity(0.85),
			angle: .degrees(angle),
			speed: speed,
			bounce: bounce,
			bandWidth: band,
			desyncSeed: desync ? 42 : 0
		)
	}

	var body: some View {
		VStack(spacing: 24) {
			SkeletonBlock(cornerRadius: 12, size: .init(width: 260, height: 14),
						  configuration: configuration)

			HStack(spacing: 12) {
				SkeletonBlock(circleWith: .init(width: 44, height: 44),
							  configuration: configuration)
				VStack(alignment: .leading, spacing: 8) {
					SkeletonBlock(cornerRadius: 12, size: .init(width: 220, height: 12),
								  configuration: configuration)
					SkeletonBlock(cornerRadius: 12, size: .init(width: 160, height: 12),
								  configuration: configuration)
				}
			}

			SkeletonBlock(capsuleWith: .init(width: 160, height: 28),
						  configuration: configuration)

			Divider().padding(.vertical, 8)

			controls
		}
		.padding()
		.glimmerPaused(paused)
		.glimmer(configuration, overrideReduceMotion: reduceMotion, overrideLowPower: lowPower)
	}

	@ViewBuilder
	private var controls: some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack {
				Toggle("Pause", isOn: $paused)
				Toggle("Bounce", isOn: $bounce)
				Toggle("Desync", isOn: $desync)
			}
			HStack {
				Toggle("Reduce Motion", isOn: $reduceMotion)
				Toggle("Low Power", isOn: $lowPower)
			}
			LabeledContent("Speed \(String(format: "%.2f", speed))") {
				Slider(value: $speed, in: 0.6...2.0).frame(width: 220)
			}
			LabeledContent("Band \(String(format: "%.2f", band))") {
				Slider(value: $band, in: 0.10...0.60).frame(width: 220)
			}
			LabeledContent("Angle \(Int(angle))°") {
				Slider(value: $angle, in: -90...90).frame(width: 220)
			}
		}
	}
}

@available(iOS 16, macOS 15, *)
#Preview("Glimmer Playground") { SamplePreview() }
#endif
