//
//  ListItemView.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 20/01/23.
//

import SwiftUI

struct ListItemView: View {
    
    private var viewModel: ListItemViewModel
    var configuration: ListItemUIConfiguration
    
    init(presentable: ListItemPresentable) {
        self.viewModel = ListItemViewModel(presentable: presentable)
        self.configuration = self.viewModel.presentable.listItemUIValues
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: viewModel.presentable.image)) { image in
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
                placeholder: { Color.gray }
                    .frame(width: configuration.cellImageSize, height: configuration.cellImageSize)
                    .cornerRadius(configuration.cornerRadius)

                VStack(alignment: .leading, spacing: configuration.spacing) {
                    HStack {
                        Text(viewModel.presentable.name.capitalized)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        Spacer()
                        HStack(spacing: configuration.spacing) {
                            HStack(spacing: 0) {
                                Image(systemName: viewModel.presentable.topLeftSymbol)
                                    .font(.caption2)
                                Text(viewModel.presentable.topLeftValue)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                            }
                            HStack(spacing: 0) {
                                Image(systemName: viewModel.presentable.topRightSymbol)
                                    .font(.caption2)
                                Text(viewModel.presentable.topRightValue)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    
                    Text(viewModel.presentable.description)
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(4)
                }
            }
            .padding()
            .background(
               Background
            )
        }
        .listRowBackground(Color.clear)
    }
}

private extension ListItemView {
    var Background: some View {
        Rectangle()
            .fill(Theme.groupedBackground)
            .cornerRadius(configuration.cornerRadius)
            .shadow(
                color: Color.black.opacity(0.15),
                radius: 20,
                x: 0,
                y: 2
            )
    }
}
