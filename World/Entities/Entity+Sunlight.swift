import SwiftUI
import RealityKit

extension Entity {
    func setSunlight(intensity: Float?) {
        if let intensity {
            Task {
                guard let resource = try? await EnvironmentResource(named: "Sunlight") else { return }
                var iblComponent = ImageBasedLightComponent(
                    source: .single(resource),
                    intensityExponent: intensity)

                iblComponent.inheritsRotation = true

                components.set(iblComponent)
                components.set(ImageBasedLightReceiverComponent(imageBasedLight: self))
            }
        } else {
            components.remove(ImageBasedLightComponent.self)
            components.remove(ImageBasedLightReceiverComponent.self)
        }
    }
}
