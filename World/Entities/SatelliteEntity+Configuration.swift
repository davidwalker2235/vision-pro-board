/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Configuration information for satellite entities.
*/

import SwiftUI

extension SatelliteEntity {
    /// Configuration information for satellite entities.
    struct Configuration {
        var name: String
        var isVisible: Bool = true
        var inclination: Angle = .zero
        var speedRatio: Float = 1
        var scale: Float = 1
        var altitude: Float = 0
        var traceWidth: Float = 400
        var isTraceVisible: Bool = false
        var initialRotation: Angle = .zero
        
        static var solarTelescopeDefault: Configuration {
            .init(
                name: "Telescope",
                inclination: .degrees(60),
                speedRatio: 24.0 / 1.5,
                scale: 0.2,
                altitude: 0.55)
        }

        static var disabledMoon: Configuration {
            .init(
                name: "Moon",
                isVisible: false)
        }
    }
}
