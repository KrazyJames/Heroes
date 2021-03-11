//
//  HeroListViewModel.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import Foundation

final class HeroListViewModel {
    private let service = HeroServiceCaller()
    private var heroes: [Hero] = []
    private var page = 1
    
    var selectedHero: Hero?
    
    var numberOfRows: Int {
        heroes.count
    }
    
    // MARK:- Binding
    enum RequestStatus {
        case loading
        case didLoad
        case error(_ error: NetworkError)
    }
    
    var requestStatus: Box<RequestStatus> = Box(.loading)
    private var isLoading = false
    
    // MARK: - Functions
    func getHeroes(from ids: [Int] = [1,2,3,4,5,6,7,8,9,10]) {
        requestStatus.value = .loading
        isLoading.toggle()
        service.getHeroesFrom(ids: ids) { result in
            switch result {
                case .success(let heroes):
                    self.heroes.append(contentsOf: heroes)
                    self.page += 1
                    self.requestStatus.value = .didLoad
                case .failure(let error):
                    self.requestStatus.value = .error(error)
            }
            self.isLoading.toggle()
        }
    }
    
    func getHeroAt(_ index: Int) -> Hero? {
        heroes[safe: index]
    }
    
    func reload() {
        guard !isLoading else { return }
        heroes.removeAll()
        page = 1
        getHeroes()
    }
    
    func loadMoreHeroes() {
        if !isLoading {
            let next = getTenNumbers(page: page)
            getHeroes(from: next)
        }
    }
    
    private func getTenNumbers(page: Int) -> [Int] {
        var numbers: [Int] = []
        for i in heroes.count + 1...page*10 {
            numbers.append(i)
        }
        return numbers
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
