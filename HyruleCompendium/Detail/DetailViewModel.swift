//
//  DetailViewModel.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 24/01/23.
//

import Foundation

protocol DetailPresentable {
    var category: String { get }
    var name: String { get }
    var description: String { get }
    var image: String { get }
    var commonLocations: [String]? { get }
    var horizontalItemsList: [DetailHorizontalItemsList] { get }
    var detailUIValues: DetailUIConfiguration { get }
}

struct DetailUIConfiguration {
    var mainImageSize: CGFloat
    var cornerRadius: CGFloat
    var spacing: CGFloat
}

struct DetailHorizontalItemsList: Hashable {
    let title: String
    let items: [String]
}

class DetailViewModel {
    var presentable: DetailPresentable
    
    init(presentable: DetailPresentable) {
        self.presentable = presentable
    }
}
