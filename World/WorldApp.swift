/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main entry point of the Hello World experience.
*/

import SwiftUI
import WorldAssets

/// The main entry point of the Hello World experience.
@main
struct WorldApp: App {
    // The view model.
    @State private var model = ViewModel()

    // The immersion styles for different modules.
    @State private var orbitImmersionStyle: ImmersionStyle = .mixed
    @State private var solarImmersionStyle: ImmersionStyle = .full

    var body: some Scene {
        // The main window that presents the app's modules.
        WindowGroup("Patien", id: "modules") {
            Modules()
                .environment(model)
        }
        .windowStyle(.plain)

        // A volume that displays a globe.
        WindowGroup(id: Module.report.name) {
            Bone()
                .environment(model)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.6, height: 0.6, depth: 0.6, in: .meters)

        .immersionStyle(selection: $orbitImmersionStyle, in: .mixed)
    }
    
    init() {
    }
}
