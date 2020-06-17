//
//  WelcomeView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/16/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    enum PresentedView {
        case Register
        case Login
    }
        
    @State private var viewToPresent: PresentedView?

    @State private var isShowingTitle : Bool = false
    @State private var isShowingSubtitle : Bool = false
    @State private var isShowingButtons : Bool = false
    
    @State private var subtitleOpacity : Double = 0.0
    @State private var firstButtonOpacity : Double = 0.0
    @State private var secondButtonOpacity : Double = 0.0

    var body: some View {
        NavigationView {
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
                    
                    Text("First, to look at Artifacts, you'll need to create a Sketchfab account")
                        .font(.system(size: 25, weight: .light))
                        .foregroundColor(.white)
                        .frame(width: 250, height: 120, alignment: .top)
                        .offset(y: isShowingSubtitle ? -150 : 0)
                        .opacity(self.subtitleOpacity)
                        .onAppear{
                            withAnimation(Animation.easeIn(duration: 1.5).delay(2)){
                                self.isShowingSubtitle = true
                                self.subtitleOpacity = 1
                            }
                        }

                    NavigationLink(destination: LoginView()){
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(width: 250, height: 55, alignment: .center)
                            Text("Create an account")
                                .foregroundColor(.blue)
                                .font(.system(size: 22, weight: .regular))
                        }
                    }
                    .offset(y: isShowingTitle ? 50 : 100)
                    .opacity(self.firstButtonOpacity)
                    .onAppear{
                        withAnimation(Animation.easeIn(duration: 1.5).delay(4)){
                            self.isShowingSubtitle = true
                            self.firstButtonOpacity = 1
                        }
                    }

                    NavigationLink(destination: LoginView()){
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .frame(width: 250, height: 55, alignment: .center)
                            Text("Already have one")
                                .foregroundColor(.blue)
                                .font(.system(size: 22, weight: .regular))
                        }
                    }
                    .offset(y: isShowingTitle ? 65 : 200)
                    .opacity(self.secondButtonOpacity)
                    .onAppear{
                        withAnimation(Animation.easeIn(duration: 1.5).delay(4.3)){
                            self.isShowingSubtitle = true
                            self.secondButtonOpacity = 1
                        }
                    }
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
