import SwiftUI

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
                        switch module {
                        case .report:
                            Text(Patiens[0].name)
                                .font(.system(size: 50, weight: .bold))
                                .padding(.bottom, 15)
                                .accessibilitySortPriority(4)
                            ScrollView(.vertical) {
                                Text(module.overview).padding(50)
                            }
                        case .radiography:
                            Text(module.heading)
                                .font(.system(size: 50, weight: .bold))
                                .padding(.bottom, 15)
                                .accessibilitySortPriority(4)

                            ScrollView {
                                Text(module.overview)
                                    .padding(.bottom, 30)
                                    .accessibilitySortPriority(3)
                            }.padding(20)
                            RadiographyToggle()
                                .accessibilitySortPriority(2)
                        case .drugs:
                            Text(module.heading)
                                .font(.system(size: 50, weight: .bold))
                                .padding(.bottom, 15)
                                .accessibilitySortPriority(4)

                            DrugsList().frame(width: 490, height: 400)
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
   }
}

extension Module {
    @ViewBuilder
    fileprivate var detailView: some View {
        switch self {
        case .report: ReportModule()
        case .radiography: RadiographyModule()
        case .drugs: DrugsModule()
        }
    }
}

#Preview("Report") {
    NavigationStack {
        ModuleDetail(module: .report)
            .environment(ViewModel())
    }
}

#Preview("Radiography") {
    NavigationStack {
        ModuleDetail(module: .radiography)
            .environment(ViewModel())
    }
}

#Preview("Drugs") {
    NavigationStack {
        ModuleDetail(module: .drugs)
            .environment(ViewModel())
    }
}
