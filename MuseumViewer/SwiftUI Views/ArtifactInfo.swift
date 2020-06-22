//
//  ArtifactInfo.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/20/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct ArtifactInfo: View {
    var artifact : Artifact
    
    var screenRect = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            VStack {
                
                Text(artifact.civilization.uppercased())
                    .font(Font.custom("Verdana-Bold", size: 16))
                    .padding(.init(top: 80, leading: 30, bottom: 30, trailing: 40))
                    .frame(width: screenRect.width, height: 10, alignment: .leading)
                    .lineLimit(2)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.9256190658, green: 0.3188654184, blue: 0.2843726277, alpha: 1)))
                HStack {
                    Text(artifact.name)
                        .font(Font.custom("Verdana-Bold", size: 35))
                        .padding(.init(top: 15, leading: 27, bottom: 2, trailing: 0))
                        .frame(width: screenRect.width-70, height: (artifact.name.count > 13 ? 140 : 80), alignment: .leading)
                        .lineLimit(2)
                    Image(systemName: (artifact.isStarred ? "star.circle.fill" : "star.circle"))
                        .frame(width: 30, height: 30, alignment: .trailing)
                        .font(.system(size: 45))
                        .padding(.init(top: (artifact.name.count > 13 ? 20 : 0), leading: 0, bottom: 0, trailing: 30))
                        .foregroundColor(Color.init(#colorLiteral(red: 0.9256190658, green: 0.3188654184, blue: 0.2843726277, alpha: 1)))
                }.frame(width: screenRect.width)
                ScrollView {
                    Text(artifact.description).font(Font.custom("Verdana", size: 18))
                }.padding(.init(top: 0, leading: 30, bottom: 0, trailing: 30))
                    .frame(width: screenRect.width, height: 380)
                
                Spacer()
                                
                Text("Provided by the \(artifact.category.rawValue)")
                    .font(Font.custom("Verdana-Bold", size: 20))
                    .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .frame(width: screenRect.width, height: 70, alignment: .leading)
                    .lineLimit(2)
                    .foregroundColor(Color.init(#colorLiteral(red: 0.9256190658, green: 0.3188654184, blue: 0.2843726277, alpha: 1)))
                
                Spacer()
            }
        }
    }
}

struct ArtifactInfo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ZStack {
                RoundedRectangle(cornerRadius: 1).fill(Color.purple).edgesIgnoringSafeArea(.all)
                BottomSheetView(isOpen: .constant(false), maxHeight: 700, minHeight: 405) {
                    ArtifactInfo(artifact: artifactData[1])
                }.edgesIgnoringSafeArea(.all)
            }
            
        }
    }
}
