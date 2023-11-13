import SwiftUI

let showDebugSettings = false

extension View {
    /// Adds a button in an ornament that opens a settings panel.
    func settingsButton(
        module: Module
    ) -> some View {
        self.modifier(
            SettingsButtonModifier(module: module)
        )
    }
}

private struct SettingsButtonModifier: ViewModifier {
    var module: Module

    @State private var showSettings = false

    func body(content: Content) -> some View {
        content
            .ornament(
                visibility: showDebugSettings ? .visible : .hidden,
                attachmentAnchor: .scene(.bottom)
            ) {
                Button {
                    showSettings = true
                } label: {
                    Label("Settings", systemImage: "gear")
                        .labelStyle(.iconOnly)
                }
                .popover(isPresented: $showSettings) {
                    module.settingsView
                        .padding(.vertical)
                        .frame(width: 500, height: 400)
                }
            }
    }
}

extension Module {
    @ViewBuilder
    fileprivate var settingsView: some View {
        switch self {
        case .report: GlobeSettings()
        case .radiography: OrbitSettings()
        case .drugs: SolarSystemSettings()
        }
    }
}
