import RealityKit
import SwiftUI
import WorldAssets

/// An entity that represents the Earth and all its moving parts.
class RadiographyEntity: Entity {

    private var bone: Entity = Entity()
    private let rotatorPlane = Entity()
    private let rotator = Entity()
    private var currentSunIntensity: Float? = nil

    @MainActor required init() {
        super.init()
    }

    init(
        configuration: Configuration
    ) async {
        super.init()

        // Load the earth and pole models.
        guard let bone = await WorldAssets.entity(named: "Bones") else { return }
        self.bone = bone

        self.addChild(rotatorPlane)
        rotatorPlane.addChild(rotator)
        rotator.addChild(bone)

        update(
            configuration: configuration,
            animateUpdates: false)
    }

    func update(
        configuration: Configuration,
        animateUpdates: Bool
    ) {
        bone.sunPositionComponent = SunPositionComponent(Float(configuration.sunAngle.radians))
        rotator.orientation = configuration.rotation

        // Set the sunlight, if corresponding controls have changed.
        if configuration.currentSunIntensity != currentSunIntensity {
            setSunlight(intensity: configuration.currentSunIntensity)
            currentSunIntensity = configuration.currentSunIntensity
        }

        // Scale and position the entire entity.
        move(
            to: Transform(
                scale: SIMD3(repeating: configuration.scale),
                rotation: orientation,
                translation: configuration.position),
            relativeTo: parent)
    }
}

