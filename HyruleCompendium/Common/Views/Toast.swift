//
//  Toast.swift
//  HyruleCompendium
//
//  Created by Gabriel Colmenares on 23/01/23.
//

import Foundation
import SwiftUI


//MARK: - View
struct ToastView: View {
    var type: ToastStyle
    var message: String
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                type.iconFileName
                    .foregroundColor(type.themeColor)
                
                VStack(alignment: .leading) {
                    Text(type.title)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message)
                        .font(.system(size: 12))
                }
                
                Spacer(minLength: 10)
                
                Button {
                    onCancelTapped()
                } label: {
                    Symbols.xMark
                        .foregroundColor(Color(UIColor.label))
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

//MARK: - Style Enum
enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Theme.red
        case .warning: return Theme.orange
        case .info: return Theme.blue
        case .success: return Theme.green
        }
    }
    var iconFileName: Image {
        switch self {
        case .info: return Symbols.info
        case .warning: return Symbols.warning
        case .success: return Symbols.success
        case .error: return Symbols.error
        }
    }
    
    var title: String {
        switch self {
        case .info: return Localizables.info
        case .warning: return Localizables.warning
        case .success: return Localizables.success
        case .error: return Localizables.error
        }
    }
}

//MARK: - Struct
struct Toast: Equatable {
    var type: ToastStyle
    var message: String
    var duration: Double = 3
}

//MARK: - ViewModifier
struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                ToastView(
                    type: toast.type,
                    message: toast.message) {
                        dismissToast()
                    }
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
               dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
