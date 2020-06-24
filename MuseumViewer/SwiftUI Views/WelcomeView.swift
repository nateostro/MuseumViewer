//
//  WelcomeView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/16/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    // This is left over from past authentication with Sketchfab, and it is
    //   kept in because restricted access will be necessary for Nasher Artifacts
    //   if this project grows in size.
    enum PresentedView {
        case Register
        case Login
    }
        
    @State private var viewToPresent: PresentedView?

    // Animation States:
    @State private var isShowingTitle : Bool = false
    @State private var isShowingSubtitle : Bool = false
    @State private var isShowingButtons : Bool = false
    
    // Opacity States:
    @State private var subtitleOpacity : Double = 0.0
    @State private var firstButtonOpacity : Double = 0.0
    @State private var secondButtonOpacity : Double = 0.0
    
    // User Settings is kept for eventual use of Duke authentication
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationView {
            // Background Linear Gradient for the Welcome View.
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue]),
                  startPoint: UnitPoint(x: 0.2, y: 0.2),
                  endPoint: .bottomTrailing
                ).edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Welcome")
                        .font(.system(size: 60, weight: .light))
                        .frame(width: 250, height: 120, alignment: .top)
                        .foregroundColor(.white)
                        .offset(y: isShowingTitle ? -150 : -50)
                        .opacity((isShowingTitle ? 1 : 0))
                        .onAppear{
                            withAnimation(Animation.easeIn(duration: 1.5)){
                                self.isShowingTitle = true
                            }
                        }
                    
                    Text("The following is a collection of artifacts offered with restricted access from the Nasher Museum and with a CC0 license from Museums around the world")
                        .font(.system(size: 25, weight: .light))
                        .foregroundColor(.white)
                        .frame(width: 250, height: 240, alignment: .top)
                        .offset(y: isShowingSubtitle ? -150 : 0)
                        .opacity(self.subtitleOpacity)
                        .onAppear{
                            withAnimation(Animation.easeIn(duration: 1.5).delay(2)){
                                self.isShowingSubtitle = true
                                self.subtitleOpacity = 1
                            }
                        }

                    // Toggling didAuthenticate changes the UserSettings EnvironmentObject and tells the root ContentView to switch to ListView.
                    Button(action: {
                        self.settings.didAuthenticate = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(width: 250, height: 55, alignment: .center)
                            Text("Go to the artifacts")
                                .foregroundColor(.blue)
                                .font(.system(size: 22, weight: .regular))
                        }
                    })
                    .offset(y: isShowingTitle ? 50 : 100)
                    .opacity(self.firstButtonOpacity)
                    .onAppear{
                        withAnimation(Animation.easeIn(duration: 1.5).delay(4)){
                            self.isShowingSubtitle = true
                            self.firstButtonOpacity = 1
                        }
                    }.accentColor(.white)
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
