//
//  TelaResultado2.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 20/10/22.
//

import SwiftUI

struct TelaResultado2: View {
    
    @Binding var imageShown:UIImage?
    @State var progressMsg:String = "progress: not started"
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Image(uiImage: imageShown!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                                Color.gray
                
                //                if let imageShown = imageShown {
                //                    Image(uiImage: imageShown)
                                Image(uiImage: imageShown!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                
                                //}
                                padding(.top)
                
                                VStack {
                                    Spacer()
                                    HStack(spacing: 20.0) {
                                        Button {
                
                                        } label: {
                                            Text("Fazer ABCD")
                                        }
                                        Button {
                
                                        } label: {
                                            Text("Fazer XYZ")
                                        }
                                    }
                                    .padding(.vertical, 100)
                                    .buttonStyle(.borderedProminent)
                                    .frame(maxWidth: .infinity)
                                    .background {
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(Color.corDeFundo)
                                    }
                                //    .padding(.horizontal, 50)
                
                                  //  Spacer()
                                }
                            }
                            .ignoresSafeArea()
                
                        }
            }
        }
        
        struct TelaResultado2_Previews: PreviewProvider {
            static var previews: some View {
                TelaResultado2(imageShown: .constant(UIImage(named: "ImageAnne")))
            }
        }
        
