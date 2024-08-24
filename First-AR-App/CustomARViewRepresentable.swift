//
//  CustomARViewRepresentable.swift
//  First-AR-App
//
//  Created by Simone Panico on 24.08.2024.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
