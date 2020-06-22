//
//  ArtifactRow.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import NavigationStack

struct ArtifactRow: View {
    
    @State private var isActive = false
    var categoryName: String
    var artifacts:[Artifact]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(self.categoryName)
            .font(Font.custom("Verdana-Bold", size: 26))
            
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
