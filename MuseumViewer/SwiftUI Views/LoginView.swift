//
//  LoginView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/16/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        Button(action: {
            self.settings.didAuthenticate = true
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 55, alignment: .center)
                Text("Already have one")
                    .foregroundColor(.blue)
                    .font(.system(size: 22, weight: .regular))
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
