import SwiftUI

struct Modules: View {
    @Environment(ViewModel.self) private var model

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        @Bindable var model = model

        ZStack {
            NavigationStack(path: $model.navigationPath) {
                TableOfContents()
                    .navigationDestination(for: Module.self) { module in
                        ModuleDetail(module: module)
                            .navigationTitle(module.eyebrow)
                    }
            }
        }

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
