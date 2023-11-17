import SwiftUI
import WorldAssets

@main
struct WorldApp: App {
    @State private var model = ViewModel()
    @State private var orbitImmersionStyle: ImmersionStyle = .mixed
    @State private var solarImmersionStyle: ImmersionStyle = .full

    var body: some Scene {
        WindowGroup(id: "QrCode") {
            QrCode()
        }
        .windowStyle(.plain)
        WindowGroup(id: "modules") {
            Modules()
                .environment(model)
        }
        .windowStyle(.plain)

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
