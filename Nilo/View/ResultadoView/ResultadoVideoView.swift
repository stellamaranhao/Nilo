//
//  TelaResultado3.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 21/10/22.
//
import SwiftUI
import PhotosUI
import _AVKit_SwiftUI

struct ResultadoVideoView: View {
    @Binding var rootView:ProcessandoVideoViewsList

    @Binding var oldImage: UIImage?
    @Binding var videoFIle:TemporaryMediaFile?
    @State var isClicked: Bool = false
    @State private var shared = false
    @State var showAlertExit:Bool = false
    @State var showAlert:Bool = false

    @Binding var apiUsada:APIProtocol

    var body: some View {
        ZStack {
            ZStack {
                
                if let maybeVideo = videoFIle {
                    VideoPlayer(player: AVPlayer(url:  (maybeVideo.url)!))
                        .frame(height: 400)
                        .offset(y: -UIScreen.main.bounds.height*0.15)
                    
                }

                HStack {
                    VStack {

                        Button(action: {
                            if !shared {
                                showAlertExit = true

                            } else{
                                exitView()
                            }
                        }){
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30))
                                .padding(.top, UIScreen.main.bounds.height / 15)
                                .padding(.leading)
                        }.alert(isPresented: $showAlertExit) {

                            Alert(title: Text("Tem certeza?")
                                  ,message: Text("Gostaria de salvar o video antes de sair ou fazer outra alteração?")
                                  ,primaryButton: .default(Text("Salvar video")){
                                shareButton()
                            },secondaryButton: .destructive(Text("Continuar mesmo assim")){
                                exitView()

                            }

                            )
                        }




                        Spacer()
                    }
                    Spacer()
                }

                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.corDeFundo)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                            .shadow(color: Color.letratelarestauracao.opacity(0.50), radius: 15, y: 8)
                        VStack(spacing: 5){
                            HStack {
                                VStack (spacing: 5){
                                    Text("Memória Resgatada!")
                                        .foregroundColor(Color.melhorarfoto)
                                        .font(.custom("Poppins-SemiBold", size: 20))
                                        .font(.title3)
                                    Text("Não pare por aqui:")
                                        .foregroundColor(Color.melhorarfoto)
                                        .font(.custom("Poppins-Regular", size: 16))
                                        .font(.body)
                                }
                                .padding(.leading, UIScreen.main.bounds.width / 4.5)
                                Spacer()
                                eyeButton.frame(width: 50)


                            }
                            .padding(.bottom)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .center, spacing: 50) {
                                    Button {
                                        shareButton()

                                    } label: {
                                        ButtonsView(imgSistema: "square.and.arrow.up", texto: "Exportar memória")
                                    }

                                    // Btn nova opt
                                    BtnContinuarResultadoView(apiUtilizada: apiUsada){
                                        if !shared {
                                            showAlert = true

                                        } else{
                                            print("Clicked to change")
                                            exitView()

                                        }
                                    }
                                    .alert(isPresented: $showAlert) {

                                        Alert(title: Text("Tem certeza?")
                                              ,message: Text("Gostaria de salvar o video antes de sair ou fazer outra alteração?")
                                              ,primaryButton: .default(Text("Salvar video")){
                                            shareButton()
                                        },secondaryButton: .destructive(Text("Continuar mesmo assim")){
                                            print("Clicked to change")
                                            exitView()

                                        }

                                        )
                                    }


                                }.padding(.horizontal,30)

                            }
                        }
                    }
                }
            }
            .background(Color.corDeFundo)
            .ignoresSafeArea()
        }
    }

    var eyeButton: some View {
        Button {
            isClicked.toggle()
        } label: {
            Image(systemName: isClicked ? "eye.slash.circle" : "eye.circle")
                .foregroundColor(Color.melhorarfoto)
                .font(.system(size: 40))
                .padding(.trailing, UIScreen.main.bounds.width / 10)
        }

    }



    func shareButton() {
        if let maybeVideo = videoFIle{
            let yourUrl = maybeVideo.url
            let activity: [Any] = [yourUrl, "Exporte o seu video..."]
            let activityController = UIActivityViewController(activityItems: activity, applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: {shared = true})
            
        }
        

    }

    func exitView(){
        self.rootView = .exit
    }
}


