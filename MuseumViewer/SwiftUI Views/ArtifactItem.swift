//
//  ArtifactItem.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct ArtifactItem: View {
    
    var artifact: Artifact
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(artifact.imageName)
                    .resizable()
                    // not sure yet why the following element is necessary,
                    // but app broke without it.
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            ZStack {
                Blur(style: .light).cornerRadius(20).shadow(radius: 2)
                if artifact.isStarred {
                    Image(systemName: "star.circle.fill")
                        .foregroundColor(Color.init(#colorLiteral(red: 0.9256190658, green: 0.3188654184, blue: 0.2843726277, alpha: 1)))
                        .frame(width: 40, height: 40)
                        .font(.system(size: 40))
                        .background(Circle().fill(Color.white))
                        .offset(x: 75, y: -173)
                }
                VStack {
                    Text(artifact.civilization.uppercased())
                        .font(Font.custom("Verdana-Bold", size: 12))
                        .frame(width: 110, height: 15, alignment: .leading)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.9256190658, green: 0.3188654184, blue: 0.2843726277, alpha: 1)))
                    Text(artifact.name)
                        .font(Font.custom("Verdana-Bold", size: 17))
                        .foregroundColor(.black)
                        .frame(width: 110, height: (artifact.name.count > 12 ? 44 : 30), alignment: .topLeading)
                        .padding(.top, 6)
                }.padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            }.padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .frame(width: 140, height: 100)
            .offset(x: 0, y: 100)
        }
        
        
    }
}

#if DEBUG
struct ArtifactItem_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactItem(artifact: artifactData[5])
    }
}
#endif
