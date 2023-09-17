//
//  RMFooteLoadingCollectionReusableView.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 13/09/23.
//

import UIKit

final class RMFooteLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooteLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubView(spinner)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("un supported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
