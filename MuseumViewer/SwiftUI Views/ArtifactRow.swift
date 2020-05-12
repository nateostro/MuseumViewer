//
//  ArtifactRow.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct ArtifactRow: View {
    
    var categoryName: String
    var artifacts:[Artifact]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(self.categoryName)
            .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top){
                    ForEach(self.artifacts, id: \.name) { artifact in
                        
                        NavigationLink(destination: ArtifactDetail(artifact: artifact)){
                        
                            ArtifactItem(artifact: artifact)
                                .frame(width: 170)
                                .padding(EdgeInsets(top:17, leading:17, bottom:17, trailing: 30))
                        
                        }
                    }
                }
            }
        }
        
    }
}


struct ArtifactRow_Previews: PreviewProvider {
    static var previews: some View {
        ArtifactRow(categoryName: "Nasher Artifacts", artifacts: artifactData)
    }
}
