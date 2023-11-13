/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The module detail content that's specific to the solar system module.
*/

import SwiftUI

/// The module detail content that's specific to the solar system module.
struct DrugsModule: View {
    var body: some View {
        Image("drugs")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    DrugsModule()
        .padding()
}
