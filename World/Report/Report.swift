import SwiftUI

struct Report: View {
    var module: Module
    
    var body: some View {

        ScrollView(.vertical) {
            Text(module.overview).padding(50)
        }
    }
}
