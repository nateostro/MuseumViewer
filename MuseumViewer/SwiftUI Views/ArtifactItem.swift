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
            
            VStack(alignment: .leading, spacing: 5) {
                Text(artifact.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(artifact.description)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height:40)
            }
        }
        
        
    }
}

#if DEBUG
struct ArtifactItem_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactItem(artifact: artifactData[0])
    }
}
#endif
