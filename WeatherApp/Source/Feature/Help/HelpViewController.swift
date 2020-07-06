//
//  HelpViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 06/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TitleManager.about.localized
        
        let image = UIImage(named: Constants.Image.name.kVerticalCloseButton)?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(Self.dismissButtonTapped))
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        webView.delegate = self
        webView.loadHTMLString(Constants.html.text.htmlText, baseURL: nil)
    }
    
    @objc private func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    private func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension HelpViewController:  UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        showActivityIndicator(show: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        showActivityIndicator(show: false)
    }
}
