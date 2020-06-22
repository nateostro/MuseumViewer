//
//  Screen.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/21/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct Screen<Content>: View where Content: View {
    let content: () -> Content

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            content()
        }
    }
}
