//
//  GlimmerWrapperView.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//
#if canImport(UIKit)
import UIKit
import SwiftUI

@available(iOS 16, *)
struct GlimmerWrapperView: UIViewRepresentable {
	let config: GlimmerConfiguration
	let paused: Bool
	let reduceMotion: Bool
	let isLowPower: Bool
	let sizeCat: ContentSizeCategory

	func makeUIView(context: Context) -> GlimmerHostingView {
		let v = GlimmerHostingView()
		updateUIView(v, context: context)
		return v
	}

	func updateUIView(_ uiView: GlimmerHostingView, context: Context) {
		let tuning = tunedParameters(
			from: config,
			reduceMotion: reduceMotion,
			isLowPower: isLowPower,
			contentSizeCat: sizeCat
		)
		uiView.paused = paused
		uiView.apply(configuration: config, tuning: tuning)
	}
}
#endif
