//
//  SwiftUIView.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
import SwiftUI

@available(macOS 15, *)
struct GlimmerWrapperNSView: NSViewRepresentable {
	let config: GlimmerConfiguration
	let paused: Bool
	let reduceMotion: Bool
	let isLowPower: Bool
	let sizeCat: ContentSizeCategory

	func makeNSView(context: Context) -> GlimmerHostingNSView {
		let v = GlimmerHostingNSView()
		updateNSView(v, context: context)
		return v
	}

	func updateNSView(_ nsView: GlimmerHostingNSView, context: Context) {
		let tuning = tunedParameters(
			from: config,
			reduceMotion: reduceMotion,
			isLowPower: isLowPower,
			contentSizeCat: sizeCat
		)
		nsView.paused = paused
		nsView.apply(configuration: config, tuning: tuning)
	}
}
#endif
