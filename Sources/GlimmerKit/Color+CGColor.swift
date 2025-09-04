//
//  File.swift
//  GlimmerKit
//
//  Created by Seohyun Kim on 9/4/25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
extension CGColor {
	static func from(_ color: Color) -> CGColor {
		UIColor(color).cgColor
	}
}
#elseif canImport(AppKit)
import AppKit
extension CGColor {
	static func from(_ color: Color) -> CGColor {
		NSColor(color).cgColor
	}
}
#endif
