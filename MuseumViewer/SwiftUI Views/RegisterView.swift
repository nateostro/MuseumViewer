//
//  LoginView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/16/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import WebKit

struct RegisterView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var webViewStateModel: WebViewStateModel = WebViewStateModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple, .blue]),
              startPoint: UnitPoint(x: 0.2, y: 0.2),
              endPoint: .bottomTrailing
            ).edgesIgnoringSafeArea(.all)
        
            VStack {
                
                NavigationView {
                       LoadingView(isShowing: .constant(webViewStateModel.loading)) { //loading logic taken from https://stackoverflow.com/a/56496896/9838937
                           //Add onNavigationAction if callback needed
                           WebView(url: URL.init(string: "https://www.sketchfab.com")!, webViewStateModel: self.webViewStateModel)
                       }
                       .navigationBarTitle(Text(webViewStateModel.pageTitle), displayMode: .inline)
                       .navigationBarItems(trailing:
                           Button("Last Page") {
                               self.webViewStateModel.goBack.toggle()
                           }.disabled(!webViewStateModel.canGoBack)
                       )
                   
                }.frame(width: 330, height: 540, alignment: .top)
                    .padding(.top, 1)
                
                Spacer()
                
                Button(action: {
                    self.settings.didAuthenticate = true
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.white)
                            .frame(width: 325, height: 55, alignment: .center)
                        Text("Alright, sign me in")
                            .foregroundColor(.blue)
                            .font(.system(size: 22, weight: .regular))
                    }.padding(.all,15)
                })
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
