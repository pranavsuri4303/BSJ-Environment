//
//  WorldViewController.swift
//
//  Created by Pranav  Suri on 16/4/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WorldViewController: UIViewController, WKNavigationDelegate {

	let webView = WKWebView()


	override func viewDidLoad() {
		webView.navigationDelegate = self
        super.viewDidLoad()
		navigationController?.setNavigationBarHidden(true, animated: false)
		if let url = URL(string: "https://www.iqair.com/world-air-quality-ranking") {
			let request = URLRequest(url: url)
			webView.load(request)
		}
		let config = WKSnapshotConfiguration()
		config.rect = CGRect(x: 0, y: 0, width: 150, height: 150)

		webView.takeSnapshot(with: config) { image, error in
			if let image = image {
				print(image.size)
			}
		}
    }
//	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//		 if let host = navigationAction.request.url?.host {
//			 if host == "https://www.iqair.com/world-air-quality-ranking" {
//				 decisionHandler(.allow)
//				 return
//			 }
//		 }
//
//		 decisionHandler(.cancel)
//	}

	override func loadView() {
		self.view = webView
	}
}
