//
//  Artifact.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI

struct Artifact: Hashable, Codable, Identifiable {
    
    /* These are the different data points for a given artifact,
        corresponding to the artifacts.json file.
     */
    
    var id: Int
    var name: String
    var imageName: String
    var description: String
    var category: Category
    
    /* The following is an enumeration for the different museums
        housing each artifact. Each time an artifact is added, its
        corresponding museum should also be added to this enumeration.
     */
    
    //TODO: FOR STAFF: Add additional museums where necessary
        
    enum Category: String, CaseIterable, Codable, Hashable {
        case Nasher = "Nasher Museum"
        case Cleveland = "Cleveland Museum"
        case Minneapolis = "Minneapolis Museum"
        case Spanish = "Spanish Museum"
    }
}

struct Artifact_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
