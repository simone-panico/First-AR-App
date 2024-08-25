//
//  ARManager.swift
//  First-AR-App
//
//  Created by Simone Panico on 24.08.2024.
//

import Combine

class ARManager {
    static let shared = ARManager()
    private init() { }
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
