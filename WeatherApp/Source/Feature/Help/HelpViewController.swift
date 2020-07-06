//
//  HelpViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 06/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TitleManager.about.localized
        
        let image = UIImage(named: Constants.Image.name.kVerticalCloseButton)?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(Self.dismissButtonTapped))
        
        webView.loadHTMLString(Constants.html.text.htmlText, baseURL: nil)
    }
    
    @objc private func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
