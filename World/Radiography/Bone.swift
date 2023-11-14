import SwiftUI

struct Bone: View {
    @Environment(ViewModel.self) private var model

    @State var axRotateClockwise: Bool = false
    @State var axRotateCounterClockwise: Bool = false

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .controlPanelGuide, vertical: .bottom)) {
            Radiography(
                earthConfiguration: model.bone,
                animateUpdates: true
            ) { event in
                if event.key.defaultValue == RadiographyEntity.AccessibilityActions.rotateCW.name.defaultValue {
                    axRotateClockwise.toggle()
                } else if event.key.defaultValue == RadiographyEntity.AccessibilityActions.rotateCCW.name.defaultValue {
                    axRotateCounterClockwise.toggle()
                }
            }
            .dragRotation(
                pitchLimit: .degrees(90),
                axRotateClockwise: axRotateClockwise,
                axRotateCounterClockwise: axRotateCounterClockwise)
            .alignmentGuide(.controlPanelGuide) { context in
                context[HorizontalAlignment.center]
            }

            BoneControls()
                .offset(y: -70)
        }
        .onChange(of: model.isBoneRotating) { _, isRotating in
            model.bone.speed = isRotating ? 0.5 : 0
        }
        .onDisappear {
            model.isShowingBone = false
        }
    }
}

extension HorizontalAlignment {
    private struct ControlPanelAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }

    static let controlPanelGuide = HorizontalAlignment(
        ControlPanelAlignment.self
    )
}

#Preview {
    Bone()
        .environment(ViewModel())
}
