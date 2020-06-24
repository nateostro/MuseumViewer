//
//  ArtifactRow.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import NavigationStack

struct ArtifactRow: View {
    
    // Necessary for custom NavigationStack, toggles when the user taps on an ArtifactItem and launches a DetailView.
    @State private var isActive = false
    
    // This will be the same category/Museum for all items in the ArtifactRow. It is passed in from ListView.
    var categoryName: String
    
    // All the artifacts in question, also passed in from ListView.
    var artifacts:[Artifact]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Category/Museum Header
            Text(self.categoryName)
            .font(Font.custom("Verdana-Bold", size: 24))
            
            // Row of ArtifactItems
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top){
                    ForEach(self.artifacts, id: \.name) { artifact in
                        VStack {
                            PushView(destination: ArtifactDetail(artifact: artifact), isActive: self.$isActive) {
                                ArtifactItem(artifact: artifact)
                                .frame(width: 170, height: 220, alignment: .top)
                                .padding(EdgeInsets(top:17, leading:17, bottom:17, trailing: 30))
                            }
                        }
                    }
                }
            }
        }
    }
}


struct ArtifactRow_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactRow(categoryName: "Nasher Museum", artifacts: artifactData)
    }
}
