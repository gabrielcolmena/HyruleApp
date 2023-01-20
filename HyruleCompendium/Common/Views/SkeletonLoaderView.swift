//
//  SkeletonLoaderView.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 23/01/23.
//

import SwiftUI

struct SkeletonLoaderView: View {
    
    @State var isAnimating: Bool = false
     
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Rectangle()
                    .fill(self.isAnimating ? Theme.loading1 : Theme.loading2)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading, spacing: 12) {
                    TextRectangle
                    TextRectangle
                    TextRectangle
                }
            }
        }
        .padding()
        .background(
            Background
        )
        .animation(foreverAnimation, value: isAnimating)
        .onAppear {
            self.isAnimating = true
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 1)
        .repeatForever(autoreverses: true)
    }
}

private extension SkeletonLoaderView {
    
    var TextRectangle: some View {
        Rectangle()
            .fill(self.isAnimating ? Theme.loading1 : Theme.loading2)
            .frame(height: 20)
            .cornerRadius(10)
    }
    
    var Background: some View {
        Rectangle()
            .fill(Theme.groupedBackground)
            .cornerRadius(10)
            .shadow(
                color: Color.black.opacity(0.05),
                radius: 20,
                x: 0,
                y: 2
            )
    }
}


struct SkeletonLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SkeletonLoaderView()
    }
}
