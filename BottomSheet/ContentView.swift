//
//  ContentView.swift
//  BottomSheet
//
//  Created by Angelos Staboulis on 19/1/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            Button("Show Sheet") {
                showSheet.toggle()
            }
        }
        .compactSheet(isPresented: $showSheet) {
            VStack(spacing: 16) {
                Text("Hello, SwiftUI-style Sheet!")
                    .font(.headline)
                Text("Compact, adaptive height, drag-to-dismiss")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Button("Dismiss") {
                    showSheet = false
                }
                .padding(.top)
            }
        }
    }
}
