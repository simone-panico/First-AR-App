//
//  ContentView.swift
//  First-AR-App
//
//  Created by Simone Panico on 24.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var colors: [Color] = [
        .green, .red, .blue
    ]
    
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(.regularMaterial)
                                .clipShape(Circle())
                        }
                        
                        ForEach(colors, id: \.self) { color in
                            Button {
                                ARManager.shared.actionStream.send(.placeBlock(color: color))
                            } label: {
                                color
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(.regularMaterial)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding()
                }
            }
    }
}

#Preview {
    ContentView()
}

