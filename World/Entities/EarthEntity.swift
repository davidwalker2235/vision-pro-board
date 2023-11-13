import RealityKit
import SwiftUI
import WorldAssets

/// An entity that represents the Earth and all its moving parts.
class EarthEntity: Entity {

    private var earth: Entity = Entity()
    private let equatorialPlane = Entity()
    private let rotator = Entity()
    private var pole: Entity = Entity()
    private var currentSunIntensity: Float? = nil

    @MainActor required init() {
        super.init()
    }

    init(
        configuration: Configuration
    ) async {
        super.init()

        // Load the earth and pole models.
        guard let earth = await WorldAssets.entity(named: configuration.isCloudy ? "Bones" : "Bones"),
              let pole = await WorldAssets.entity(named: "Bones") else { return }
        self.earth = earth
        self.pole = pole

        self.addChild(equatorialPlane)
        equatorialPlane.addChild(rotator)
        rotator.addChild(earth)

        earth.addChild(pole)

        update(
            configuration: configuration,
            animateUpdates: false)
    }

    func update(
        configuration: Configuration,
        animateUpdates: Bool
    ) {
        // Indicate the position of the sun for use in turning the ground
        // lights on and off.
        earth.sunPositionComponent = SunPositionComponent(Float(configuration.sunAngle.radians))
        
        // Set a static rotation of the tilted Earth, driven from the configuration.
        rotator.orientation = configuration.rotation

        pole.isEnabled = configuration.showPoles
        pole.scale = [
            configuration.poleThickness,
            configuration.poleLength,
            configuration.poleThickness]

        // Set the sunlight, if corresponding controls have changed.
        if configuration.currentSunIntensity != currentSunIntensity {
            setSunlight(intensity: configuration.currentSunIntensity)
            currentSunIntensity = configuration.currentSunIntensity
        }

        // Tilt the axis according to a date. For this to be meaningful,
        // locate the sun along the positive x-axis. Animate this move for
        // changes that the user makes when the globe appears in the volume.
        var planeTransform = equatorialPlane.transform
        planeTransform.rotation = tilt(date: configuration.date)
        if animateUpdates {
            equatorialPlane.move(to: planeTransform, relativeTo: self, duration: 0.25)
        } else {
            equatorialPlane.move(to: planeTransform, relativeTo: self)
        }

        // Scale and position the entire entity.
        move(
            to: Transform(
                scale: SIMD3(repeating: configuration.scale),
                rotation: orientation,
                translation: configuration.position),
            relativeTo: parent)

        // Set an accessibility component on the entity.
        components.set(makeAxComponent(
            configuration: configuration))
    }

    private func makeAxComponent(
        configuration: Configuration
    ) -> AccessibilityComponent {
        // Create an accessibility component.
        var axComponent = AccessibilityComponent()
        axComponent.isAccessibilityElement = true

        // Add a label.
        axComponent.label = "Earth model"

        // Add a value that describes the model's current state.
        var axValue = configuration.currentSpeed != 0 ? "Rotating, " : "Not rotating, "
        axValue.append(configuration.showSun ? "with the sun shining, " : "with the sun not shining, ")
        if configuration.axDescribeTilt {
            if let dateString = configuration.date?.formatted(.dateTime.day().month(.wide)) {
                axValue.append("and tilted for the date \(dateString)")
            } else {
                axValue.append("and no tilt")
            }
        }
        if configuration.showPoles {
            axValue.append("with the poles indicated, ")
        }

        axComponent.value = LocalizedStringResource(stringLiteral: axValue)

        // Add custom accessibility actions, if applicable.
        if !configuration.axActions.isEmpty {
            axComponent.customActions.append(contentsOf: configuration.axActions)
        }

        return axComponent
    }

    private func tilt(date: Date?) -> simd_quatf {
        // Assume a constant magnitude for the Earth's tilt angle.
        let tiltAngle: Angle = .degrees(date == nil ? 0 : 23.5)

        // Find the day in the year corresponding to the date.
        let calendar = Calendar.autoupdatingCurrent
        let day = calendar.ordinality(of: .day, in: .year, for: date ?? Date()) ?? 1

        // Get an axis angle corresponding to the day of the year, assuming
        // the sun appears in the negative x direction.
        let axisAngle: Float = (Float(day) / 365.0) * 2.0 * .pi

        // Create an axis that points the northern hemisphere toward the
        // sun along the positive x-axis when axisAngle is zero.
        let tiltAxis: SIMD3<Float> = [
            sin(axisAngle),
            0,
            -cos(axisAngle)
        ]

        // Create and return a tilt orientation from the angle and axis.
        return simd_quatf(angle: Float(tiltAngle.radians), axis: tiltAxis)
    }
}

