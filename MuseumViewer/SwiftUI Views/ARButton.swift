//
//  ARButton.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/17/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct ARButton : View {
    
    var artifact: Artifact
    
    // Quick Look State variable, used for modal view activated by AR Button.
    @State var showingPreview = false
    
    // Quick Look State variable, whether or not AR scene allows the artifact to change size.
    @State var allowsScaling = true
    
    var body: some View {
        
            Button(action: {
                self.showingPreview.toggle()
            }, label: {
                ZStack {
                    Blur(style: .light).background(
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .black]),
                          startPoint: UnitPoint(x: 0.2, y: 0.2),
                          endPoint: .bottomTrailing
                        )
                    )
                    Text("AR").frame(width: 42, height: 42, alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Avenir-Heavy", size: 22))
                        .shadow(radius: 4)
                }
            })
            .frame(width: 52, height: 52)
            .sheet(isPresented: $showingPreview) {
                VStack {
                    HStack {
                        Button("Close") {
                            self.showingPreview.toggle()
                        }
                        Spacer()
                    }
                    .padding()
                      
                    ARQuickLookView(fileName: self.artifact.imageName, allowScaling: self.allowsScaling)
                }
            }
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(20)
    }
}

struct Blur: UIViewRepresentable {
    // This achieves a similar effect to the Blur effect from UIKit, and matches the style of the item behind it.
    
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct ARButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            ARButton(artifact: artifactData[3])
        }
    }
}
