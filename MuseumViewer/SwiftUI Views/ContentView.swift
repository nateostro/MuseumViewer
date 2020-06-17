//
//  ContentView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/16/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var settings: UserSettings

    var body: some View {
        if settings.didAuthenticate {
            return AnyView(ListView())
        } else {
            return AnyView(WelcomeView())
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
