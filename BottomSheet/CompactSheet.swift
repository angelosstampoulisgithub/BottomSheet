//
//  CompactSheet.swift
//  BottomSheet
//
//  Created by Angelos Staboulis on 19/1/26.
//

import Foundation
import SwiftUI

struct CompactSheet<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let sheetContent: SheetContent
    
    @State private var translation: CGFloat = 0
    
    func body(content base: Content) -> some View {
        ZStack {
            base
            
            if isPresented {
                // Dimmed background
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                
                // Sheet container
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        // Drag handle
                        Capsule()
                            .frame(width: 40, height: 5)
                            .foregroundColor(Color.gray.opacity(0.5))
                            .padding(.top, 8)
                        
                        sheetContent
                            .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)
                    )
                    .offset(y: translation)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    translation = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 150 {
                                    withAnimation(.spring()) {
                                        isPresented = false
                                    }
                                }
                                translation = 0
                            }
                    )
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: isPresented)
                }
            }
        }
    }
}

// MARK: - Convenience extension
extension View {
    func compactSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) -> some View {
        self.modifier(
            CompactSheet(isPresented: isPresented, sheetContent: content())
        )
    }
}
