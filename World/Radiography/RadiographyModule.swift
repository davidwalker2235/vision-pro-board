import SwiftUI
import RealityKit
import WorldAssets

private let modelDepth: Double = 200

private enum Item: String, CaseIterable, Identifiable {
    case Bones
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

struct RadiographyModule: View {
    @Environment(ViewModel.self) private var model
    @State private var selection: Item = .Bones

    var body: some View {
        VStack(spacing: 100) {
            Color.clear
                .overlay {
                    ItemView(item: .Bones, orientation: [0.15, 0, 0.15])
                        .opacity(selection == .Bones ? 1 : 0)
                }
                .dragRotation(yawLimit: .degrees(20), pitchLimit: .degrees(20))
                .offset(z: modelDepth)

            Picker("Bones", selection: $selection) {
                ForEach(Item.allCases) { item in
                    Text(item.name)
                }
            }
            .pickerStyle(.segmented)
            .accessibilitySortPriority(0)
            .frame(width: 350)
        }
    }
}

private struct ItemView: View {
    var item: Item
    var orientation: SIMD3<Double> = .zero

    var body: some View {
        Model3D(named: item.name, bundle: worldAssetsBundle) { model in
            model.resizable()
                .scaledToFit()
                .rotation3DEffect(
                    Rotation3D(
                        eulerAngles: .init(angles: orientation, order: .xyz)
                    )
                )
                .frame(depth: modelDepth)
                .offset(z: -modelDepth / 2)
                .accessibilitySortPriority(1)
        } placeholder: {
            ProgressView()
                .offset(z: -modelDepth * 0.75)
        }
    }
}

#Preview {
    RadiographyModule()
        .padding()
        .environment(ViewModel())
}
