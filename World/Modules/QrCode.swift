//
//  QrCode.swift
//  World
//
//  Created by David Carmona Maroto on 17/11/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct QrCode: View {
    @State var isStarted = false
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Button(action: {
            openWindow(id: "modules")
        }) {
            // Contenido del botón (en este caso, una imagen)
            Image(systemName: "square.grid.2x2")
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}

#Preview {
    QrCode()
}
