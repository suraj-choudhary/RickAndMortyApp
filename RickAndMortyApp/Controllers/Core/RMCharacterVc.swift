//
//  RMCharacterVc.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 09/08/23.
//

import UIKit
/// controller to show and search for character
final class RMCharacterVc: UIViewController {
    
    private let characterLisView = CharacterListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        view.addSubview(characterLisView)
        
        NSLayoutConstraint.activate([
            characterLisView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterLisView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterLisView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterLisView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
}
