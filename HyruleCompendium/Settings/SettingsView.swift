//
//  SettingsView.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 22/01/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel: SettingsViewModel
    @State private var toast: Toast? = nil
    @Environment(\.dismiss) var dismiss
    
    init(dataManager: DataProtocol) {
        _viewModel = StateObject(wrappedValue: SettingsViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text(Localizables.dataTitle)) {
                    Button(action: {
                        viewModel.removeAllPersistedData()
                        if let error = viewModel.error {
                            toast = Toast(type: .error, message: error.localizedDescription)
                        } else {
                            toast = Toast(type: .success, message: Localizables.removeAllSuccess)
                        }
                    }, label: {
                        Text(Localizables.removeAllData)
                    })
                }
            }
            .navigationTitle("Settings")
            .toastView(toast: $toast)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dataManager: DataManager(
            coreDataManager: CoreDataManager(),
            networkManager: NetworkManager()
            )
        )
    }
}
