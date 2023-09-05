//
//  RMCharaterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 01/09/23.
//

import UIKit
//controller to show single character
final class RMCharacterDetailViewController: UIViewController {
    
    init(viewModel: RMCharacterDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
