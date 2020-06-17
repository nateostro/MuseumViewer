//
//  ContentView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var settings: UserSettings

    @State private var isWelcoming : Bool = false
    var didWelcome : Bool = true
    
    var categories:[String:[Artifact]] {
        .init(
            grouping: artifactData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        NavigationView {
            // to customize order, remove sorted
            List(categories.keys.sorted(by: >), id: \.self){ key in
                // add .uppercased() modifier to key in header of ArtifactRow to make uppercased.
                ArtifactRow(categoryName: "\(key)", artifacts: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
        .navigationBarTitle(Text("Museum Artifacts"))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
