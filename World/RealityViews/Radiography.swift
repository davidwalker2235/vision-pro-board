/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The model of the Earth.
*/

import SwiftUI
import RealityKit
import WorldAssets

/// The model of the Earth.
struct Radiography: View {
    var earthConfiguration: EarthEntity.Configuration = .init()
    var moonConfiguration: SatelliteEntity.Configuration? = nil
    var animateUpdates: Bool = false
    var axCustomActionHandler: ((_: AccessibilityEvents.CustomAction) -> Void)? = nil

    /// The Earth entity that the view creates and stores for later updates.
    @State private var earthEntity: EarthEntity?

    var body: some View {
        RealityView { content in
            // Create an earth entity with tilt, rotation, a moon, and so on.
            let earthEntity = await EarthEntity(
                configuration: earthConfiguration)
            content.add(earthEntity)

            // Handle custom accessibility events.
            if let axCustomActionHandler {
                _ = content.subscribe(
                    to: AccessibilityEvents.CustomAction.self,
                    on: nil,
                    componentType: nil,
                    axCustomActionHandler)
            }

            // Store for later updates.
            self.earthEntity = earthEntity

        } update: { content in
            // Reconfigure everything when any configuration changes.
            earthEntity?.update(
                configuration: earthConfiguration,
                animateUpdates: animateUpdates)
        }
    }
}

#Preview {
    Radiography(
        earthConfiguration: EarthEntity.Configuration.orbitEarthDefault
    )
}
