//
//  ArtifactDetail.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import QuickLook
import NavigationStack

struct ArtifactDetail: View {
        
    @State private var bottomSheetShown = true
    @State private var isViewingInfo = false
    @State private var isViewingWeb = false
    
    @State var artifact: Artifact
    var screenRect = UIScreen.main.bounds
    
    var body: some View {
        Screen {
            ZStack {
                VStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    Color.white
                        .frame(width: self.screenRect.width, height: 200, alignment: .bottom)
                }
                ZStack {
                    // Artifact Model / Image
                    if self.artifact.imageName != "" {
                        VStack {
                            ModelView(artifact: self.artifact)
                                .frame(width: self.screenRect.size.width, height: 680, alignment: .bottom)
                            Spacer()
                        }
                    } else {
                        VStack{
                            Image(self.artifact.imageName)
                            .resizable()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                        }
                    }
                    
                    // Buttons
                    HStack(alignment: .top) {
                        
                        // Pop NavigationStackView
                        PopView(destination: .root) {
                            ZStack {
                                Blur(style: .light).background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.red, .black]),
                                      startPoint: UnitPoint(x: 0.2, y: 0.2),
                                      endPoint: .bottomTrailing
                                    )
                                )
                                
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                    .font(.system(size: 26))
                                    .shadow(radius: 4)
                            }
                        }.frame(width: 52, height: 52)
                        .cornerRadius(20)
                        .padding(.leading, 30)
                        
                        Spacer()
                        
                        // Launch AR Scene
                        ARButton(artifact: self.artifact).padding(.trailing, 30)
                        
                        // Pull up info modal
                        /*
                        Button(action: {
                            self.isViewingInfo.toggle()
                        }, label: {
                            ZStack {
                                Blur(style: .light).opacity(0.7).background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.red, .black]),
                                      startPoint: UnitPoint(x: 0.2, y: 0.2),
                                      endPoint: .bottomTrailing
                                    )
                                )
                                Image(systemName: "info.circle.fill").frame(width: 50, height: 50, alignment: .center)
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .shadow(radius: 4)
                            }
                        })
                        .frame(width: 50, height: 50)
                        .cornerRadius(20)
                        .padding(.trailing, 30)
                        */
                    }.padding(.bottom, 600)
                }
                
                // Artifact Info
                if self.bottomSheetShown == true {
                    BottomSheetView(isOpen: self.$isViewingInfo, maxHeight: 700, minHeight: 178) {
                        ArtifactInfo(artifact: self.artifact)
                    }.edgesIgnoringSafeArea(.all)
                }
                
            }.frame(width: self.screenRect.size.width, height: self.screenRect.size.height)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#if DEBUG
struct ArtifactDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactDetail(artifact: artifactData[1])
    }
}
#endif
