//
//  ARQuickLook.swift
//  MuseumViewer
//
//  Adapted by Nathan Ostrowski on 5/9/20 from a file written by Daniel Jones (@danieljones)
//

import SwiftUI
import QuickLook
import ARKit
  
struct ARQuickLookView: UIViewControllerRepresentable {
    // Properties: the file fileName (without extension), and whether we'll let
    // the user scale the preview content.
    var fileName: String
    var allowScaling: Bool = true
      
    func makeCoordinator() -> ARQuickLookView.Coordinator {
        // The coordinator object implements the mechanics of dealing with
        // the live UIKit view controller.
        Coordinator(self)
    }
      
    func makeUIViewController(context: Context) -> QLPreviewController {
        // Create the preview controller, and assign our Coordinator class
        // as its data source.
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }
      
    func updateUIViewController(_ controller: QLPreviewController,
                                context: Context) {
        // nothing to do here
    }
      
    // TODO: Make this generic so that rcproject files can be used
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let parent: ARQuickLookView
        private lazy var fileURL: URL = Bundle.main.url(forResource: parent.fileName,
                                                        withExtension: "usdz")!
          
        init(_ parent: ARQuickLookView) {
            self.parent = parent
            super.init()
        }
          
        // The QLPreviewController asks its delegate how many items it has:
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
          
        // For each item (see method above), the QLPreviewController asks for
        // a QLPreviewItem instance describing that item:
        func previewController(
            _ controller: QLPreviewController,
            previewItemAt index: Int
        ) -> QLPreviewItem {
            guard let fileURL = Bundle.main.url(forResource: parent.fileName, withExtension: "usdz") else {
                fatalError("Unable to load \(parent.fileName).usdz")
            }
              
            let item = ARQuickLookPreviewItem(fileAt: fileURL)
            item.allowsContentScaling = parent.allowScaling
            return item
        }
    }
}
  
struct ARQuickLookView_Previews: PreviewProvider {
    static var previews: some View {
        ARQuickLookView(fileName: "Artifact")
    }
}
