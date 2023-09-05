//
//  CharacterLisViewModel.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 21/08/23.
//

import UIKit

protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacter()
    func didSelectCharcater(_ character: RMCharacter)
    
}

final class RMCharacterListViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewModelDelegate?
    
    private var cellViewModels: [RMCharcaterColletionViewCellViewModel] = []

    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewmodel = RMCharcaterColletionViewCellViewModel(characterName: character.name, characterStatus: character.status, charaterImageUrl: URL(string: character.image))
                
                cellViewModels.append(viewmodel)
                
            }
        }
    }
    
    
    public func fetchCharacter() {
        let request = RMRequest(endPoint: .character)
        RMService.shared.execute(request, extpecting: RMGetAllCharcaterResponse.self) { [weak self] res in
            switch res {
            case .success(let resposeModel):
                let result = resposeModel.results
                self?.characters = result
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacter()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}



extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bound = UIScreen.main.bounds
        
        let width = (bound.width - 30) / 2
        
        return CGSize(width: width,
                      height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharcaterColletionViewCell.cellIndentifier, for: indexPath) as? RMCharcaterColletionViewCell else {
            fatalError("unsupporetd cell")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        
        delegate?.didSelectCharcater(character)
        print(character)
    }
    
    
}
