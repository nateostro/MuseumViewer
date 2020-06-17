//
//  ArtifactDetail.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import QuickLook

struct ArtifactDetail: View {
    
    var artifact: Artifact
    
    var body: some View {
        List{
            VStack{
                Image(artifact.imageName)
                .resizable()
                    .aspectRatio(contentMode: .fit)
            }
                
            VStack(alignment: .leading) {
                
                Text("Artifact Name:")
                    .font(.body)
                    .bold()
                    .padding(.bottom, 15)
                
                Text(artifact.name)
                    .font(.body)
                    .padding(.bottom, 15)
                    .padding(.leading, 15)
                
                Text("Museum:")
                    .font(.body)
                    .bold()
                    .padding(.bottom, 15)
                
                Text(artifact.category.rawValue)
                    .font(.body)
                    .padding(.bottom, 15)
                    .padding(.leading, 15)
                
                Text("Description:")
                    .font(.body)
                    .bold()
                    .padding(.bottom, 15)
                
                Text(artifact.description)
                    .font(.body)
                    .lineLimit(nil)
                    .lineSpacing(12)
                    .padding(.bottom, 30)
                    .padding(.leading, 15)

                HStack {
                    Spacer()
                    ARButton(artifact: artifact)
                    Spacer()
                }.padding(.top, 20)
                .padding(.bottom, 50)
                
                Text("Artifact and Model used with CC0 License from the \(artifact.category.rawValue)")
                
            }
            .padding(.top)
            .padding(.bottom)
            }
        .navigationBarTitle(artifact.name)
    }
}

// This AR button will launch a modal view and change the modal state.

struct ARButton : View {
    
    var artifact: Artifact
    
    // Quick Look State variable, used for modal view activated by AR Button
    @State var showingPreview = false
    
    @State var allowsScaling = true
    
    var body: some View {
        Button("View Model/AR"){
            self.showingPreview.toggle()
        }
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
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)

    }
}

#if DEBUG
struct ArtifactDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactDetail(artifact: artifactData[3])
    }
}
#endif
