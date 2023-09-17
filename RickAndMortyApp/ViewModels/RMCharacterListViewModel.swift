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
    
    private var isLoadingMoreCharacter = false
    
    private var cellViewModels: [RMCharcaterColletionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharcaterResponse.Info? = nil

    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewmodel = RMCharcaterColletionViewCellViewModel(characterName: character.name, characterStatus: character.status, charaterImageUrl: URL(string: character.image))
                
                cellViewModels.append(viewmodel)
                
            }
        }
    }

    /// Fetch inital set of charcter
    public func fetchCharacter() {
        let request = RMRequest(endPoint: .character)
        RMService.shared.execute(request, extpecting: RMGetAllCharcaterResponse.self) { [weak self] res in
            switch res {
            case .success(let resposeModel):
                let result = resposeModel.results
                let info = resposeModel.info
                self?.characters = result
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacter()
                    
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    //Paginate if additional character needed
    public func fectAdditionalCharacter() {
        isLoadingMoreCharacter = true

    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}


// MARK: Colletionview

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
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, shouldShowLoadMoreIndicator else {
            fatalError("Un suported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooteLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooteLoadingCollectionReusableView else {
            fatalError("Un suported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        
        delegate?.didSelectCharcater(character)
        print(character)
    }
    
}

// MARK: Scrollview

extension RMCharacterListViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacter else {
            return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
                
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            print("should strat fecthing more")
            fectAdditionalCharacter()
        }
    }
}
