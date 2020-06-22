//
//  ModelView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/20/20.
//  Copyright © 2020 Nathan Ostrowski. All rights reserved.
//

import SwiftUI
import SceneKit

struct ModelView : UIViewRepresentable {
    let artifact : Artifact
    let scene : SCNScene
    
    init(artifact: Artifact){
        self.artifact = artifact
        guard let url = Bundle.main.url(forResource: artifact.imageName, withExtension: "usdz") else { fatalError() }
        print("DEBUG: made scene with \(artifact.name) from file \(artifact.imageName).usdz")
        self.scene = try! SCNScene(url: url)
        addAnimation(node: self.scene.rootNode)
    }
    
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 15.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }

    func makeUIView(context: Context) -> SCNView {
        
        // 2: Add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        // 3: Place camera
        cameraNode.position = SCNVector3(
            x: artifact.cameraPosXYZ[0],
            y: artifact.cameraPosXYZ[1],
            z: artifact.cameraPosXYZ[2]
        )
        // 4: Set camera on scene
        scene.rootNode.addChildNode(cameraNode)
                
        // 5: Adding light to scene
        let spotLight = SCNNode()
        spotLight.light = SCNLight()
        spotLight.light?.type = .directional
        scene.rootNode.addChildNode(spotLight)
                
        // 6: Creating and adding ambient light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.white
        scene.rootNode.addChildNode(ambientLightNode)
                
        // retrieve the SCNView
        let scnView = SCNView()
        scnView.scene = scene
        return scnView
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        scnView.scene = scene
        
        scnView.cameraControlConfiguration.allowsTranslation = false

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information
        scnView.showsStatistics = false

        // configure the view
        scnView.backgroundColor = UIColor.black
    }
}

struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView(artifact: artifactData[8])
    }
}
