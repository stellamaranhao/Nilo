//
//  ContentView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 04/10/22.
//

import SwiftUI

struct ContentView: View {
    let api = ReplicateAPI(authToken: "c7a7ef617f35f71f74a7ce1d0ef45853d6b58cec")
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
            print("tap")
            api.validateToken()
            print(api.authTokenValid)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
