//
//  ARQuickLook.swift
//  MuseumViewer
//

import SwiftUI
import QuickLook
import ARKit
  
struct ARQuickLookView: UIViewControllerRepresentable {

    var fileName: String
    var allowScaling: Bool = true
      
    func makeCoordinator() -> ARQuickLookView.Coordinator {
        // The coordinator object will help with the mechanics of implementing a live UIKit View Controller.
        Coordinator(self)
    }
      
    func makeUIViewController(context: Context) -> QLPreviewController {
        // Further wrapping the UIKit View, I've created a controller and passed in the coordinator as its data source.
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }
      
    func updateUIViewController(_ controller: QLPreviewController,
                                context: Context) {
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
