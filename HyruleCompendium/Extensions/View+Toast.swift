//
//  View+Toast.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 23/01/23.
//

import Foundation
import SwiftUI

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
