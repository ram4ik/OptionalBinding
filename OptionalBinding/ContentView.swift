//
//  ContentView.swift
//  OptionalBinding
//
//  Created by Ramill Ibragimov on 01.06.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

extension Optional where Wrapped == String {
    
    var _bound: String? {
        get { return self }
        set { self = newValue }
    }
    
    var bound: String {
        
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

extension Binding {
    
    static func ??(lhs: Binding<Optional<Value>>, rhs: Value) -> Binding<Value> {
        
        return Binding(get: {lhs.wrappedValue ?? rhs }, set: { lhs.wrappedValue =  $0 })
    }
}

struct ContentView: View {
    
    @State private var name: String?
    @State private var otherName: String? = "John Doe"
    
    var body: some View {
        VStack {
            
            TextField("Enter name", text: $name.bound)
            // or
            TextField("Enter name", text: $name ?? "Default Value")
            // or
            TextField("Enter name", text: $otherName ?? "Default Value")
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
