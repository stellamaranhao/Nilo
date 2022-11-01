
import SwiftUI
import PhotosUI

struct ProcessarView: View {
    @State private var presentResultModal = false
    private var importtake: Bool {imageShown != nil}
    @State var image = UIImage()
    @State private var showSheet = false
    @State var oldImage: UIImage? //Imagem original da foto
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var imageShown:UIImage? //Nova imagem
    var apiUtilizada:APIProtocol


    
    var body: some View {
            VStack{
            
                if let imageShown = imageShown{

                    HStack{
                        Image(uiImage: imageShown)
                            .resizable()
                            .scaledToFit()
                            .scaledToFill()
                            .cornerRadius(8)
                            .frame(width: 214, height: 476)
                            .padding(.bottom, 80)
                    }
                    
                }

                if !importtake {
                    VStack(spacing: 130){
                        takePhotoButtom
                        importPhotoButtom
                            .padding(.bottom,100)
                    }
                }
               
                
                NavigationLink(destination:
                                ProcessandoView(presentedView: .carregando,
                                                apiUtilizada: apiUtilizada,
                                                imgPre:$oldImage,
                                                imgPos:$imageShown),
                               isActive: $presentResultModal) { EmptyView() }
                
                
                BtnProcessarView(usedAlgo:apiUtilizada.algorithm ,action: {
                    presentResultModal = true
                })
                .disabled((imageShown != nil) ? false : true)
                    
            }.background(Color.corDeFundo.ignoresSafeArea())
       
    }
    

    var takePhotoButtom: some View {
        ZStack{
           
            
                    Image("tirarFoto")//rever
                        .position(x: 250, y: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                                .frame(width: 275, height: 200)
                                .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8))
                    
                    
                    Text("Tirar Foto")
                        .foregroundColor(.letratelarestauracao)
                        .fontWeight(.bold)
                        .font(.title2)
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .onTapGesture {
                            showSheet = true
                        }
                        .padding(.top,120)
                        .padding(.trailing,130)
                        .sheet(isPresented: $showSheet) {
                            ImagePicker(sourceType: .camera, selectedImage: self.$image)
                        }
                        .onChange(of: image) { newItem in
                            imageShown = newItem
                            
                        }
                
            
        }
        .padding(.top,50)
    }
    
    var importPhotoButtom: some View{
        ZStack{
            Group{
                Image("importarFoto")//rever
                    .position(x: 280, y: 80)
                    .background(
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.white)
                            .frame(width: 275, height: 200)
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8))
                PhotosPicker(
                    
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text("Importar Foto")
                            .foregroundColor(.letratelarestauracao)
                            .fontWeight(.bold)
                            .font(.title2)
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .padding(.top,120)
                            .padding(.trailing,80)
                    }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        imageShown = UIImage(data: selectedImageData!)
                        oldImage = UIImage(data: selectedImageData!)
                    }
                }
            }
        }
    }
}

