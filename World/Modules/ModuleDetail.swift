/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A detail view that presents information about different module types.
*/

import SwiftUI

/// A detail view that presents information about different module types.
struct ModuleDetail: View {
    @Environment(ViewModel.self) private var model

    var module: Module

    var body: some View {
        @Bindable var model = model

        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            let imageWidth = min(max(proxy.size.width - textWidth, 300), 700)
            ZStack {
                HStack(spacing: 60) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(module.heading)
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, 15)
                            .accessibilitySortPriority(4)

                        Text(module.overview)
                            .padding(.bottom, 30)
                            .accessibilitySortPriority(3)

                        switch module {
                        case .report:
                            SolarSystemToggle()
                        case .radiography:
                            GlobeToggle()
                                .accessibilitySortPriority(2)
                        case .drugs:
                            OrbitToggle()
                        }
                    }
                    .frame(width: textWidth, alignment: .leading)

                    module.detailView
                        .frame(width: imageWidth, alignment: .center)
                }
                .offset(y: -30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(70)
        .background {
            if module == .drugs {
                Image("SolarBackground")
                    .resizable()
                    .scaledToFill()
                    .accessibility(hidden: true)
            }
        }

        // A settings button in an ornament,
        // visible only when `showDebugSettings` is true.
        .settingsButton(module: module)
   }
}

extension Module {
    @ViewBuilder
    fileprivate var detailView: some View {
        switch self {
        case .report: GlobeModule()
        case .radiography: OrbitModule()
        case .drugs: SolarSystemModule()
        }
    }
}

#Preview("Globe") {
    NavigationStack {
        ModuleDetail(module: .report)
            .environment(ViewModel())
    }
}

#Preview("Orbit") {
    NavigationStack {
        ModuleDetail(module: .radiography)
            .environment(ViewModel())
    }
}

#Preview("Solar System") {
    NavigationStack {
        ModuleDetail(module: .drugs)
            .environment(ViewModel())
    }
}
