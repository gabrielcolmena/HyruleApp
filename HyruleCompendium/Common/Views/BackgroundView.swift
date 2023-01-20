//
//  BackgroundView.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 23/01/23.
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient:
            Gradient(
                colors: [
                    Theme.backgroundGradient1,
                    Theme.backgroundGradient2,
                ]),
           startPoint: .top,
           endPoint: .bottom
        )
    }
}
