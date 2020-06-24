//
//  Artifact.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct Artifact: Hashable, Codable, Identifiable {
    
    /*
    These are the different data points for a given artifact,
        corresponding to the artifacts.json file.
     
     Note that all data fields in the JSON must be addressed in this Artifact struct in order for the generic decoder in Data.swift to remain functional.
     */
    
    var id: Int
    var name: String
    var imageName: String
    var description: String
    var category: Category
    var urlString : String
    var civilization: String
    var isStarred : Bool
    var cameraPosXYZ : [Float]
        
    enum Category: String, CaseIterable, Codable, Hashable {
        case Nasher = "Nasher Museum"
        case Cleveland = "Cleveland Museum of Art"
        case Minneapolis = "Minneapolis Institute of Art"
    }
}

struct Artifact_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
