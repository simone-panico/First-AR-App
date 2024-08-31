//
//  CustomARView.swift
//  First-AR-App
//
//  Created by Simone Panico on 24.08.2024.
//

import ARKit
import Combine
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
        
        
        // 1. Start Plane Detection
        startPlaneDetection()
        
        // 2. 2D Point
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
                                
    }
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer) {
        // Get Touch Location
        let tapLocation = recognizer.location(in: self)
        
        // Raycast (2D -> 3D)
        let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        if let firstResult = results.first {
            
            // Get 3D Point (x, y, z)
            let worldPos = simd_make_float3(firstResult.worldTransform.columns.3)
            
            // Create Spehere
            let spehre = creaeteSpehre()
            
            // Place Spehre
            placeObject(object: spehre, location: worldPos)
            
            // Install Gestures
            installGesures(object: spehre)
        }
        
    }
    
    func creaeteSpehre() -> ModelEntity {
            
        // Mesh
        let spehre = MeshResource.generateSphere(radius: 0.5)
        
        // Material
        let spehreMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
        
        // Model Entity
        let spehreEntity = ModelEntity(mesh: spehre, materials: [spehreMaterial])
        
        return spehreEntity
    }
                                  
    func placeObject(object: ModelEntity, location: SIMD3<Float>) {
        
        // Create Anchor
        let objectAnchor = AnchorEntity(world: location)
        
        // Tie the model to anchor
        objectAnchor.addChild(object)
        
        // Attach model to the scene
        self.scene.addAnchor(objectAnchor)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func startPlaneDetection() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        
        self.session.run(configuration)
    }
    
    func installGesures(object: ModelEntity) {
        object.generateCollisionShapes(recursive: true)
        
        self.installGestures([.all], for: object)
    }
    
    
}
