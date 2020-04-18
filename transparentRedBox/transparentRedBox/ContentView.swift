//
//  ContentView.swift
//  transparentRedBox
//
//  Created by Oscar Capraro on 4/17/20.
//  Copyright © 2020 Oscar Capraro. All rights reserved.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        // when the scene loads, run this function. Called because of reality composer
        boxAnchor.actions.onStart.onAction = onStart(_:)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func onStart(_ entity: Entity?) {
        guard let entity = entity else { return }
        // Do something with entity...
        print(entity.name)
        
        
        //Color Stuff ---------------------------------------------------
        var material = SimpleMaterial(color: .red, isMetallic: false)
        material.metallic = MaterialScalarParameter(floatLiteral: 0.0)
        material.roughness = MaterialScalarParameter(floatLiteral: 1.0)
        material.tintColor = UIColor.red //tint
        material.baseColor = MaterialColorParameter.color(UIColor(red: 1.0,
        green: 0.0,
         blue: 0.0,
         alpha: 0.75))//opacity
        //-----------------------------------------------------------------
        
        let box = entity.scene?.findEntity(named: "box")
        print(box?.name as Any)
        
        var modComp : ModelComponent = (box?.children[0].components[ModelComponent])! // the first child of the anchor entity is a model entity
       
        modComp.materials = [material]
        
        box?.children[0].components.set(modComp)
        
    
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
