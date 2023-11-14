/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The top level navigation stack for the app.
*/

import SwiftUI

/// The top level navigation stack for the app.
struct Modules: View {
    @Environment(ViewModel.self) private var model

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        @Bindable var model = model

        ZStack {
            // The main navigation element for the app.
            NavigationStack(path: $model.navigationPath) {
                TableOfContents()
                    .navigationDestination(for: Module.self) { module in
                        ModuleDetail(module: module)
                            .navigationTitle(module.eyebrow)
                    }
            }
        }

        // Close any open detail view when returning to the table of contents.
        .onChange(of: model.navigationPath) { _, path in
            if path.isEmpty {
                if model.isShowingBone {
                    dismissWindow(id: Module.report.name)
                }
            }
        }
    }
}

#Preview {
    Modules()
        .environment(ViewModel())
}
