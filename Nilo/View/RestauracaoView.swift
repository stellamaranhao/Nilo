
import SwiftUI
import PhotosUI

struct RestauracaoView: View {
    @State private var isShowingDetailView = false
    private var importtake: Bool {imageShown != nil}
    @State var image = UIImage()
    @State private var showSheet = false
    @State var oldImage: UIImage?
 
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var imageShown:UIImage?
    @State var options = ["2x", "3x", "5x", "8x"]
    @State var teste = ["Melhor qualidade ", "Mais detalhes e personalidade"]
    @State var showingTutorial:Bool

  
    @State var pickedPhotoName: String = ""
    @State private var selectedOptionPickerQualidade = "One"
    @State private var selectedOptionPickerMelhorias = "One"
    @State private var selectedOptionPickerTeste = "One"
    
    @State var message:String = "GFP-GAN"
    @State var progressMsg:String = "progress: not started"
    let api = BasetenAPI()
        
    var body: some View {
        NavigationView{
            
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
                    
                    takePhotoButtom
                    importPhotoButtom
                }
               
                
                
                NavigationLink(destination: TelaResultado3(selectedItem: $selectedItem, oldImage: $oldImage, selectedImageData: $selectedImageData,imageShown: $imageShown,showingTutorial: showingTutorial), isActive: $isShowingDetailView) { EmptyView() }
                Button(action: {
                    
                    linkApiRestauracao()

                    
                    isShowingDetailView = true
                    
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.melhorarfoto)
                            .frame(width: 200, height: 70)
                            .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
                        Text("Melhorar Foto")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title2)
                            .font(.custom("Poppins-SemiBold", size: 20))
                                                }
                    .padding(.bottom,50)
                    
                    
                }.disabled((imageShown != nil) ? false : true)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @Environment(\.dismiss) var dismiss
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
                    }
                    .padding(.top,120)
                    .padding(.trailing,80)
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
//    var escolherQualidade: some View{
//        Picker("Select", selection: $selectedOptionPickerQualidade) {
//            ForEach(teste, id: \.self) {
//                Text($0)
//            }
//            .navigationTitle("Modelo de Melhoria")
//        }
//        .tint(.melhoriaQualidade)
//        .pickerStyle(.menu)
//        .background(
//            RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
//                .frame(width: 360, height: 45)
//        )
//        .shadow(color: Color.letratelarestauracao.opacity(0.25), radius: 15, y: 8)
//        .padding(.bottom, 32)
//    }
//    var escolherMelhoria: some View{
//        Picker("Select", selection: $selectedOptionPickerMelhorias) {
//            HStack {
//                Text("Modelo de Melhoria")
//                Image(systemName: "chevron.down")
//                    .symbolRenderingMode(.monochrome)
//                    .tint(.letratelarestauracao)
//                    .foregroundColor(.letratelarestauracao)
//            }
//            ForEach(options, id: \.self) {
//
//                Text($0)
//            }
//
//        }
//        .tint(.melhoriaQualidade)
//        .pickerStyle(.menu)
//        .background(
//            RoundedRectangle(cornerRadius: 8).foregroundColor(.white)
//                .frame(width: 360, height: 45)
//        )
//        .shadow(color: Color.letratelarestauracao.opacity(0.25), radius:15 , y: 8)
//        .padding(.bottom, 20)
//    }
    func linkApiRestauracao (){
        if let image = imageShown{
            api.imagePredictionPipeline(fromImage: image, progressUpdate:{progress in
                progressMsg = "\(progress)%"
                
            }){ result in
                api.imagePredictionPipelineCleanUp()
                switch result {
                case .success(let success):
                    imageShown = success
                    //return imageShown!
                    
                case .failure(let failure):
                    print(failure.asString)
                    //return nil
                }
    
               
            }
        }
    
    }

}
//struct RestauracaoView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestauracaoView(showingTutorial: )
//    }
//}
