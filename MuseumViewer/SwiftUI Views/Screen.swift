//
//  Screen.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/21/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

// This Screen struct helps immensely with the custom NavigationStackView. It gets rid of pesky SwiftUI bugs where active pushed views may not take up the whole screen.

struct Screen<Content>: View where Content: View {
    let content: () -> Content

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            content()
        }
    }
}
