//
//  ListItemViewPresentation.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 24/01/23.
//

import Foundation

protocol ListItemPresentable {
    var name: String { get }
    var description: String { get }
    var image: String { get }
    var topLeftSymbol: String { get }
    var topLeftValue: String { get }
    var topRightSymbol: String { get }
    var topRightValue: String { get }
    var listItemUIValues: ListItemUIConfiguration { get }
}

struct ListItemUIConfiguration {
    var cellImageSize: CGFloat
    var cornerRadius: CGFloat
    var spacing: CGFloat
}

class ListItemViewModel {
    var presentable: ListItemPresentable
    
    init(presentable: ListItemPresentable) {
        self.presentable = presentable
    }
}
