//
//  DetailView.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import SwiftUI

struct DetailView: View {
    
    private var viewModel: DetailViewModel
    var configuration: DetailUIConfiguration
    
    init(presentable: DetailPresentable) {
        self.viewModel = DetailViewModel(presentable: presentable)
        self.configuration = self.viewModel.presentable.detailUIValues
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                MainImage
                    .padding([.vertical], 40)
            }
            VStack{
                HStack {
                    Text(viewModel.presentable.name.capitalized)
                        .font(.title)
                        .fontWeight(.semibold)

                    Spacer()
                    Text(viewModel.presentable.category.capitalized)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .padding(configuration.spacing)
                        .padding([.horizontal], configuration.spacing)
                        .background(Color.accentColor)
                        .cornerRadius(configuration.cornerRadius)
                        
                }
                
                Divider()
                    .padding([.vertical])
                
                Text(viewModel.presentable.description.capitalized)
                    .font(.caption)
                    .fontWeight(.light)
                
                Divider()
                    .padding([.vertical])
                
                ForEach(viewModel.presentable.horizontalItemsList, id: \.self) { horizontalItem in
                    HorizontalItems(title: horizontalItem.title, items: horizontalItem.items)
                        
                    Divider()
                        .padding([.vertical])
                }
            }
            .padding()
            .background(ItemsBackground)
            .padding([.horizontal])

            }
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension DetailView {
    
    var ItemsBackground: some View {
        Rectangle()
            .fill(Theme.groupedBackground)
            .cornerRadius(configuration.cornerRadius)
            .shadow(
                color: Color.black.opacity(0.1),
                radius: 20,
                x: 0,
                y: 2
            )
    }
    
    var MainImage: some View {
        AsyncImage(url: URL(string: viewModel.presentable.image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        placeholder: { Color.gray }
            .frame(width: configuration.mainImageSize, height: configuration.mainImageSize)
            .cornerRadius(configuration.cornerRadius)
            .background(
                Rectangle()
                    .fill(Theme.groupedBackground)
                    .cornerRadius(configuration.cornerRadius)
                    .shadow(
                        color: Color.black.opacity(0.3),
                        radius: 30,
                        x: 0,
                        y: 2
                    )
            )
    }
    
    private func HorizontalItemsHeader(title: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
        
    private func HorizontalItems(title: String, items: [String]) -> some View {
        VStack(alignment: .leading) {
            HorizontalItemsHeader(title: title)
            ScrollView (.horizontal, showsIndicators: false) {
            if items.count == 0 {
                Text(Localizables.noContentAvailable)
                    .font(.caption)
                    .fontWeight(.semibold)
            } else {
                HStack {
                    ForEach(items, id: \.self) { item in
                        Text(item.capitalized)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .padding(configuration.spacing)
                            .padding([.horizontal], configuration.spacing)
                            .background(Color.accentColor)
                            .cornerRadius(configuration.cornerRadius)
                    }
                }
                }
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(presentable: Monster(
            id: 10,
            category: "Monster",
            description: "This heavyweight species of monster can be found all over Hyrule. They're physically very strong, their legs along strong enough to resist the force of a bomb blast. They're much more dangerous than the Bokoblins. In fact, Moblins have been known to pick up Bokoblins and throw them as makeshift projectile weapons.",
            drops: ["weapon 1", "weapon 2"],
            image: "https://botw-compendium.herokuapp.com/api/v2/entry/spiked_boko_bat/image",
            name: "Monster name"))
    }
}
