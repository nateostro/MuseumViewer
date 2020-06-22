//
//  ContentView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 5/9/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import NavigationStack

struct ListView: View {
    
    @EnvironmentObject var settings: UserSettings

    @State private var isWelcoming : Bool = false
    
    var didWelcome : Bool = true
    var screenRect = UIScreen.main.bounds
    
    var categories:[String:[Artifact]] {
        .init(
            grouping: artifactData,
            by: {$0.category.rawValue}
        )
    }
    
    var body: some View {
        NavigationStackView(transitionType: .custom(.slide), easing: .easeInOut){
            Screen {
                VStack {
                    Text("MUSEUM")
                        .font(Font.custom("Verdana-Bold", size: 16))
                        .frame(width: self.screenRect.width-35, height: 15, alignment: .leading)
                        .foregroundColor(Color.init(#colorLiteral(red: 0.9256190658, green: 0.3188654184, blue: 0.2843726277, alpha: 1)))
                        .padding(.top, 17)
                    Text("Artifacts")
                        .font(Font.custom("Verdana-Bold", size: 40))
                        .foregroundColor(.black)
                        .frame(width: self.screenRect.width-35, height: 30, alignment: .topLeading)
                        .padding(.top, 7)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: self.screenRect.width-30, height: 3, alignment: .center)
                        .foregroundColor(Color.black)
                    // Note to self: to customize order, remove sorted
                    List(self.categories.keys.sorted(by: >), id: \.self){ key in
                        ArtifactRow(categoryName: "\(key)", artifacts: self.categories[key]!)
                            .frame(height: 290)
                            .padding(.top, 8)
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
