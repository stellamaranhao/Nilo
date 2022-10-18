//
//  MenuView.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 18/10/22.
//

import SwiftUI

struct MenuView: View {
    @Binding var currentPage:AppPage
    var body: some View {
        HStack{
            ColorirCardView()
                .onTapGesture {
                    withAnimation{
                        currentPage = .colorirPage
                    }
                }
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView($)
//    }
//}
