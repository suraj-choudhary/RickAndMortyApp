//
//  RMCharacterDetailsViewViewModel.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 01/09/23.
//
import UIKit
final class RMCharacterDetailViewModel {
    
    public var charcater: RMCharacter
    init(charcater: RMCharacter) {
        self.charcater = charcater
    }
    
    public var title: String {
        charcater.name.uppercased()
    }
}
