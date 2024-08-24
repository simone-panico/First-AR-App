//
//  CustomARView.swift
//  First-AR-App
//
//  Created by Simone Panico on 24.08.2024.
//

import ARKit
import RealityKit
import SwiftUI

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
}
