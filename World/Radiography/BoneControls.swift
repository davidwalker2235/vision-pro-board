/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Controls that people can use to manipulate the globe in a volume.
*/

import SwiftUI

/// Controls that people can use to manipulate the globe in a volume.
struct BoneControls: View {
    @Environment(ViewModel.self) private var model
    @State private var isTiltPickerVisible: Bool = false

    var body: some View {
        @Bindable var model = model

        VStack(alignment: .tiltButtonGuide) {
            HStack(spacing: 17) {
                Toggle(isOn: $model.bone.showSun) {
                    Label("Sun", systemImage: "sun.max")
                }

                Toggle(isOn: $model.isBoneRotating) {
                    Label("Rotate", systemImage: "arrow.triangle.2.circlepath")
                }
            }
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
            .padding(12)
            .glassBackgroundEffect(in: .rect(cornerRadius: 50))
            .alignmentGuide(.controlPanelGuide) { context in
                context[HorizontalAlignment.center]
            }
            .accessibilitySortPriority(2)
        }
    }
}

extension HorizontalAlignment {
    /// A custom alignment to center the tilt menu over its button.
    private struct TiltButtonAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }

    /// A custom alignment guide to center the tilt menu over its button.
    fileprivate static let tiltButtonGuide = HorizontalAlignment(
        TiltButtonAlignment.self
    )
}

#Preview {
    BoneControls()
        .environment(ViewModel())
}
