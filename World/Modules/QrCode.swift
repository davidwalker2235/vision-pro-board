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
            Image("QRCode")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    QrCode()
}
