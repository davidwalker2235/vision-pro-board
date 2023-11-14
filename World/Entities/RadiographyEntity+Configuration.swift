import SwiftUI

extension RadiographyEntity {
    struct Configuration {

        var scale: Float = 5.0
        var rotation: simd_quatf = .init(angle: 0, axis: [0, 1, 0])
        var speed: Float = 0
        var position: SIMD3<Float> = .zero

        var showSun: Bool = true
        var sunIntensity: Float = 8
        var sunAngle: Angle = .degrees(280)

        var axActions: [LocalizedStringResource] = []

        var currentSunIntensity: Float? {
            showSun ? sunIntensity : nil
        }

        static var boneDefault: Configuration = .init(
            axActions: AccessibilityActions.rotate
        )
    }

    enum AccessibilityActions {
        case zoomIn, zoomOut, rotateCW, rotateCCW

        var name: LocalizedStringResource {
            switch self {
            case .zoomIn: "Zoom in"
            case .zoomOut: "Zoom out"
            case .rotateCW: "Rotate clockwise"
            case .rotateCCW: "Rotate counterclockwise"
            }
        }

        static var zoom: [LocalizedStringResource] {
            [zoomIn.name, zoomOut.name]
        }

        static var rotate: [LocalizedStringResource] {
            [rotateCW.name, rotateCCW.name]
        }
    }
}

