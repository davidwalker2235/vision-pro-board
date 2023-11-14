import SwiftUI
import RealityKit
import WorldAssets

struct Radiography: View {
    var earthConfiguration: RadiographyEntity.Configuration = .init()
    var animateUpdates: Bool = false
    var axCustomActionHandler: ((_: AccessibilityEvents.CustomAction) -> Void)? = nil

    @State private var earthEntity: RadiographyEntity?

    var body: some View {
        RealityView { content in
            let earthEntity = await RadiographyEntity(
                configuration: earthConfiguration)
            content.add(earthEntity)

            if let axCustomActionHandler {
                _ = content.subscribe(
                    to: AccessibilityEvents.CustomAction.self,
                    on: nil,
                    componentType: nil,
                    axCustomActionHandler)
            }

            self.earthEntity = earthEntity

        } update: { content in
            earthEntity?.update(
                configuration: earthConfiguration,
                animateUpdates: animateUpdates)
        }
    }
}

#Preview {
    Radiography()
}
