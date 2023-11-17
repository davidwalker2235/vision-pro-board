import SwiftUI
import RealityKit
import WorldAssets

struct Radiography: View {
    var earthConfiguration: RadiographyEntity.Configuration = .init()
    var animateUpdates: Bool = false
    var axCustomActionHandler: ((_: AccessibilityEvents.CustomAction) -> Void)? = nil

    @State private var radiographyEntity: RadiographyEntity?

    var body: some View {
        RealityView { content in
            let radiographyEntity = await RadiographyEntity(
                configuration: earthConfiguration)
            content.add(radiographyEntity)

            if let axCustomActionHandler {
                _ = content.subscribe(
                    to: AccessibilityEvents.CustomAction.self,
                    on: nil,
                    componentType: nil,
                    axCustomActionHandler)
            }

            self.radiographyEntity = radiographyEntity

        } update: { content in
            radiographyEntity?.update(
                configuration: earthConfiguration,
                animateUpdates: animateUpdates)
        }
    }
}

#Preview {
    Radiography()
}
