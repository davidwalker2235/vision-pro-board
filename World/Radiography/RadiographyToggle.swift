/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A toggle that activates or deactivates the globe volume.
*/

import SwiftUI

/// A toggle that activates or deactivates the globe volume.
struct RadiographyToggle: View {
    @Environment(ViewModel.self) private var model
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        @Bindable var model = model

        Toggle(Module.report.callToAction, isOn: $model.isShowingBone)
            .onChange(of: model.isShowingBone) { _, isShowing in
                if isShowing {
                    openWindow(id: Module.report.name)
                } else {
                    dismissWindow(id: Module.report.name)
                }
            }
            .toggleStyle(.button)
    }
}

#Preview {
    RadiographyToggle()
        .environment(ViewModel())
}
