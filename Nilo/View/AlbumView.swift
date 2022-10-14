//Created by Stella Maranhao on 05/10/22.

import SwiftUI

enum ImagePickingState: Identifiable {
    var id: Self { self }
    case camera
    case picker
    
}

struct PickedPhoto: Equatable {
    let selectedImage: UIImage?
}

struct AlbumView: View {
    @State var data = [(String, UIImage)]()
    @State var options = ["2x", "3x", "5x", "8x"]
    @State var teste = ["Melhor qualidade ", "Mais detalhes e personalidade"]
    
    
    
    @State var pickedPhoto: PickedPhoto?
    @State var pickedPhotoName: String = ""
    
    @State private var imagePickingState: ImagePickingState?
    @State private var selectedOptionPickerQualidade = "One"
    @State private var selectedOptionPickerMelhorias = "One"
    @State private var selectedOptionPickerTeste = "One"
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            ZStack {
                
                VStack{
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    
                    
                    if data.isEmpty {
                        
                        
                            VStack {
                                //Tirar Foto foto
                                Group {
                                    Button {
                                        imagePickingState = .camera
                                        
                                    } label: {
                                        ZStack{
                                            
                                            
                                            Label("Tirar foto", systemImage: "")
                                                .foregroundColor(.letratelarestauracao)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                                .font(.custom("Poppins-SemiBold", size: 20))
                                                .position(x: 106, y: 150)
                                            Image("tirarFoto")
                                                .position(x: 225, y: 40)
                                        }
                                        
                                    }
                                    //.padding(.top,200)
                                    .padding(.horizontal, 22)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                                            .frame(width: 275, height: 200)
                                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                                    )
                                    
                                    .padding(.bottom, 37)
                                    .padding(.top,50)
                                }
                                //Iportar foto
                                Button {
                                    imagePickingState = .picker
                                    
                                } label: {
                                    ZStack{
                                        Label("Importar foto", systemImage: "")
                                            .foregroundColor(.letratelarestauracao)
                                            .fontWeight(.bold)
                                            .font(.title2)
                                            .font(.custom("Poppins-SemiBold", size: 20))
                                        
                                            .cornerRadius(400)
                                            .position(x: 135, y: 155)
                                        Image("importarFoto")//rever
                                            .position(x: 255, y: 40)
                                    }
                                }
                                
                                
                                .padding(12)
                                //.padding(.horizontal, 22)
                                .background(
                                    
                                    RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                                        .frame(width: 275, height: 200)
                                        .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                                )
                                .padding(.bottom, 32)
                                
                                
                            }
                            
                            //Modelo de Melhoria
                            Picker("Select", selection: $selectedOptionPickerMelhorias) {
                                
                                HStack {
                                    Label("Modelo de Melhoria", systemImage: "")
                                    Image(systemName: "chevron.down")
                                        .symbolRenderingMode(.monochrome)
                                        .tint(.letratelarestauracao)
                                        .foregroundColor(.letratelarestauracao)
                                }
                                ForEach(options, id: \.self) {
                                    
                                    Text($0)
                                }
                                
                            }
                            .tint(.melhoriaQualidade)
                            .pickerStyle(.menu)
                            .background(
                                RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                                    .frame(width: 360, height: 45)
                            )
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius:15 , y: 8)
                            .padding(.bottom, 20)
                            
                            //Qualidade
                            Picker("Select", selection: $selectedOptionPickerQualidade) {
                                ForEach(teste, id: \.self) {
                                    Text($0)
                                }
                                .navigationTitle("Modelo de Melhoria")
                            }
                            .tint(.melhoriaQualidade)
                            .pickerStyle(.menu)
                            .background(
                                RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                                    .frame(width: 360, height: 45)
                            )
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                            .padding(.bottom, 32)
                            
                            //Melhorar Foto
                            
                            Button {
                                
                            } label: {
                                Text("Melhorar Foto")
                                    .foregroundColor(.letratelarestauracao)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .cornerRadius(400)
                            }
                            
                            .padding(12)
                            .padding(.horizontal, 22)
                            .background(
                                RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
                                    .frame(width: 197, height: 60)
                            )
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                        }
                }
            }
            .navigationBarBackButtonHidden(true) 
        }
        
        .fullScreenCover(item: $imagePickingState) { state in
            if state == .camera {
                ImagePickerView(selectedImage: $pickedPhoto,
                                camera: true)
                .ignoresSafeArea()
            } else if state == .picker {
                ImagePicker(pickedPhoto: $pickedPhoto)
                    .ignoresSafeArea()
                
            }
        }
        
    }
}
struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}


