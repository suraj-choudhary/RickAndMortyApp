//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 23/08/23.
//

import Foundation
import UIKit
final class CharacterListView: UIView {
    private let viewModel = CharacterListViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
        
    }()
    
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.isHidden = true
        colletionView.alpha = 0
        colletionView.backgroundColor = .green
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.register(UICollectionViewCell.self,
                               forCellWithReuseIdentifier: "cell")
        return colletionView
    }()
    
    // MARK: Init view
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubView(collectionView, spinner)
        addConstrainst()
        spinner.startAnimating()
        
        viewModel.fetchCharacter()
        
        setupColletionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    /// adding the constraints to the view
    private func addConstrainst() {
        NSLayoutConstraint.activate([
            ///spinner constraints
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            ///colletion view constraints
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func setupColletionView() {
        
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.4) {
                self.collectionView.alpha = 1.0
            }
            
        })
    }
}
