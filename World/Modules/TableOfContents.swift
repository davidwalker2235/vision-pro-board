/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The launching point for the app's modules.
*/

import SwiftUI

/// The launching point for the app's modules.
struct TableOfContents: View {
    @Environment(ViewModel.self) private var model

    var body: some View {
        @Bindable var model = model
        
        VStack {
            Spacer(minLength: 20)
            HStack {
                Patiens[0].avatar
                    .accessibility(hidden: true)
                PatientHeartBeat()
            }
            VStack {
                Text(Patiens[0].name)
                    .monospaced()
                    .font(.system(size: 50, weight: .bold))
                Text("Age: \(Patiens[0].age)")
                    .font(.title)
            }
            .padding(.bottom, 20)
            .padding(.top, 20)

            HStack(alignment: .top, spacing: 30) {
                ForEach(Module.allCases) {
                    ModuleCard(module: $0)
                }
            }
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 50)
        .animation(.default.speed(0.25), value: true)
    }
}

/// The text that displays the app's title.
private struct TitleText: View {
    var title: String
    var body: some View {
        Text(title)
            .monospaced()
            .font(.system(size: 50, weight: .bold))
    }
}

extension VerticalAlignment {
    /// A custom alignment that pins the background image to the title.
    private struct EarthAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.top]
        }
    }

    /// A custom alignment guide that pins the background image to the title.
    fileprivate static let earthGuide = VerticalAlignment(
        EarthAlignment.self
    )
}

#Preview {
    NavigationStack {
        TableOfContents()
            .environment(ViewModel())
    }
}
