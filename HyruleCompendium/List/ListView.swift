//
//  ListView.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import SwiftUI

struct ListView: View {

    @StateObject private var viewModel: ListViewModel
    
    @State var selectedItem: DetailPresentable?
    @State private var showSettings = false
    @State private var showDetail = false
    @State private var searchText = ""
    
    init(dataManager: DataManager) {
        _viewModel = StateObject(wrappedValue: ListViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.isLoading {
                    SkeletonLoaderView()
                    SkeletonLoaderView()
                } else if viewModel.hasContent {
                    if viewModel.monsters.count > 0 {
                        //MARK: - Monsters
                        Section(header: Text(viewModel.monstersTitle)) {
                            ForEach(viewModel.monsters, id: \.self) { monster in
                                ListItemView(presentable: monster)
                                .listRowSeparator(.hidden)
                                .background(.clear)
                                .onTapGesture {
                                    selectedItem = monster
                                    showDetail = true
                                }
                            }
                        }
                    }
                    
                    if viewModel.equipments.count > 0 {
                        //MARK: - Equipment
                        Section(header: Text(viewModel.equipmentTitle)) {
                            ForEach(viewModel.equipments, id: \.self) { equipment in
                                ListItemView(presentable: equipment)
                                .listRowSeparator(.hidden)
                                .background(.clear)
                                .onTapGesture {
                                    selectedItem = equipment
                                    showDetail = true
                                }
                            }
                        }
                    }
                    
                    if viewModel.materials.count > 0 {
                        //MARK: - Materials
                        Section(header: Text(viewModel.materialsTitle)) {
                            ForEach(viewModel.materials, id: \.self) { material in
                                ListItemView(presentable: material)
                                .listRowSeparator(.hidden)
                                .background(.clear)
                                .onTapGesture {
                                    selectedItem = material
                                    showDetail = true
                                }
                            }
                        }
                    }
                } else {
                    EmptyContent
                }
            }
            .refreshable {
                await viewModel.getAll()
            }
            .background {
                BackgroundView()
                    .edgesIgnoringSafeArea(.vertical)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .navigationBarTitle(viewModel.title)
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                viewModel.update(on: $0)
            }
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Settings
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EmptyView()
                }
            }
            .navigationDestination(isPresented: $showDetail, destination: {
                if let selectedItem = selectedItem {
                    DetailView(presentable: selectedItem)
                }
            })
        }
        .task {
            await viewModel.getAll()
        }
        .toastView(toast: $viewModel.toast)
    }
}

private extension ListView {
    
    var Settings: some View {
        Button {
            showSettings = true
        } label: {
            Image(systemName: viewModel.topRightSymbol)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(
                dataManager: viewModel.dataManager
            )
        }
    }
    
    var EmptyContent: some View {
        Text(Localizables.noContentAvailable)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(dataManager: DataManager(
            coreDataManager: CoreDataManager(),
            networkManager: NetworkManager())
        )
    }
}
