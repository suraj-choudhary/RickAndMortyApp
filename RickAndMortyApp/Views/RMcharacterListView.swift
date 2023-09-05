//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 23/08/23.
//

import Foundation
import UIKit

protocol RMcharacterListViewDelegate: AnyObject {
    
    func rmCharacterListView(_ characterLisView: RMcharacterListView,
                             didselectCharacter character: RMCharacter
    )
}
final class RMcharacterListView: UIView {
    private let viewModel = RMCharacterListViewModel()
    
    public weak var delegate: RMcharacterListViewDelegate?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
        
    }()
    
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.isHidden = true
        colletionView.alpha = 0
        colletionView.backgroundColor = .systemBackground
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.register(RMCharcaterColletionViewCell.self,
                               forCellWithReuseIdentifier: RMCharcaterColletionViewCell.cellIndentifier)
        return colletionView
    }()
    
    // MARK: Init view
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubView(collectionView, spinner)
        addConstrainst()
        spinner.startAnimating()
        viewModel.delegate = self
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
    }
}


extension RMcharacterListView: RMCharacterListViewModelDelegate {
    
    func didSelectCharcater(_ character: RMCharacter) {
        
        delegate?.rmCharacterListView(self, didselectCharacter: character)
    }
    
    
    func didLoadInitialCharacter() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1.0
        }
        
    }
}
