//
//  LoadingSpinnerView.swift
//  Nilo
//
//  Created by Stella Maranhao on 25/10/22.
//

import SwiftUI

struct LoadingSpinnerView: View{
    @State private var spinXLarge = false
    
    var body: some View {
        
        ZStack{
            VStack{
                VStack(alignment: .leading, spacing: 50) {
                    HStack {
                        Circle()//X-Large
                            .trim(from: 1/4, to: 1)
                            .stroke(style:StrokeStyle(lineWidth:5,lineCap: .round, lineJoin:.round))
                            .foregroundColor(.corTexto)
                            .frame (width: 40, height: 40)
                            .rotationEffect(.degrees(spinXLarge ? 360:0))
                            .animation(Animation.linear(duration: 1) .repeatForever (autoreverses: false) )
                            .onAppear(){
                                self.spinXLarge.toggle()
                                
                            }
                    }
                }
            }
            
        }
    }
}
struct LoadingSpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinnerView()
    }
}


