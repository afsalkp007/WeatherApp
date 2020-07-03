//
//  SearchListCell.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

final class SearchCell: UICollectionViewCell {
  private(set) lazy var containerView: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 5
    view.backgroundColor = .white

    return view
  }()

  private(set) lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = UIFont.preferredFont(forTextStyle: .headline)

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(containerView)
    containerView.addSubview(titleLabel)

    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),

      
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
      titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8)
        
    ])
  }
}

