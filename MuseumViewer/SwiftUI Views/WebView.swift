//
//  WebView.swift
//  MuseumViewer
//
//  Created by Nathan Ostrowski on 6/17/20, adapted from a View written by Prafulla Singh
//

import SwiftUI
import WebKit

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}


///// Implementaton
class WebViewStateModel: ObservableObject {
    @Published var pageTitle: String = "Web View"
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
}

struct WebView: View {
     enum NavigationAction {
           case decidePolicy(WKNavigationAction,  (WKNavigationActionPolicy) -> Void) //mendetory
           case didRecieveAuthChallange(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) //mendetory
           case didStartProvisionalNavigation(WKNavigation)
           case didReceiveServerRedirectForProvisionalNavigation(WKNavigation)
           case didCommit(WKNavigation)
           case didFinish(WKNavigation)
           case didFailProvisionalNavigation(WKNavigation,Error)
           case didFail(WKNavigation,Error)
       }
       
    @ObservedObject var webViewStateModel: WebViewStateModel
    
    private var actionDelegate: ((_ navigationAction: WebView.NavigationAction) -> Void)?
    
    
    let uRLRequest: URLRequest
    
    
    var body: some View {
        
        WebViewWrapper(webViewStateModel: webViewStateModel,
                       action: actionDelegate,
                       request: uRLRequest)
    }
    /*
     if passed onNavigationAction it is mendetory to complete URLAuthenticationChallenge and decidePolicyFor callbacks
    */
    init(uRLRequest: URLRequest, webViewStateModel: WebViewStateModel, onNavigationAction: ((_ navigationAction: WebView.NavigationAction) -> Void)?) {
        self.uRLRequest = uRLRequest
        self.webViewStateModel = webViewStateModel
        self.actionDelegate = onNavigationAction
    }
    
    init(url: URL, webViewStateModel: WebViewStateModel, onNavigationAction: ((_ navigationAction: WebView.NavigationAction) -> Void)? = nil) {
        self.init(uRLRequest: URLRequest(url: url),
                  webViewStateModel: webViewStateModel,
                  onNavigationAction: onNavigationAction)
    }
}

/*
  A weird case: if you change WebViewWrapper to struct cahnge in WebViewStateModel will never call updateUIView
 */

final class WebViewWrapper : UIViewRepresentable {
    @ObservedObject var webViewStateModel: WebViewStateModel
    let action: ((_ navigationAction: WebView.NavigationAction) -> Void)?
    
    let request: URLRequest
      
    init(webViewStateModel: WebViewStateModel,
    action: ((_ navigationAction: WebView.NavigationAction) -> Void)?,
    request: URLRequest) {
        self.action = action
        self.request = request
        self.webViewStateModel = webViewStateModel
    }
    
    
    func makeUIView(context: Context) -> WKWebView  {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(request)
        return view
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.canGoBack, webViewStateModel.goBack {
            uiView.goBack()
            webViewStateModel.goBack = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(action: action, webViewStateModel: webViewStateModel)
    }
    
    final class Coordinator: NSObject {
        @ObservedObject var webViewStateModel: WebViewStateModel
        let action: ((_ navigationAction: WebView.NavigationAction) -> Void)?
        
        init(action: ((_ navigationAction: WebView.NavigationAction) -> Void)?,
             webViewStateModel: WebViewStateModel) {
            self.action = action
            self.webViewStateModel = webViewStateModel
        }
        
    }
}

extension WebViewWrapper.Coordinator: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if action == nil {
            decisionHandler(.allow)
        } else {
            action?(.decidePolicy(navigationAction, decisionHandler))
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webViewStateModel.loading = true
        action?(.didStartProvisionalNavigation(navigation))
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        action?(.didReceiveServerRedirectForProvisionalNavigation(navigation))

    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        action?(.didFailProvisionalNavigation(navigation, error))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        action?(.didCommit(navigation))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        if let title = webView.title {
            webViewStateModel.pageTitle = title
        }
        action?(.didFinish(navigation))
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        action?(.didFail(navigation, error))
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if action == nil  {
            completionHandler(.performDefaultHandling, nil)
        } else {
            action?(.didRecieveAuthChallange(challenge, completionHandler))
        }
        
    }
}
