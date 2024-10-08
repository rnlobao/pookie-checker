import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Choose your pookie")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                ChoosePookieView(viewModel: viewModel)
                
                Divider()
                
                Text("Connect Devices")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                if viewModel.connectionSuccessful {
                    ConnectionSuccessfulView()
                } else {
                    CodeGeneratorView(viewModel: viewModel)
                }
                
                if viewModel.connectionSuccessful {
                    Divider()
                                        
                    VStack(spacing: 4) {
                        Text("This is your partner's pookie")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Text("It will appear on your homescreen")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                                                
                        PartnersPookieView(viewModel: viewModel)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                Spacer()
                
                Button(action: {
                    print("Botão clicado! Personagem selecionado: \(viewModel.currentUserPookieID!)")
                }) {
                    Text("Start")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(viewModel.canEnableStartButton() ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(!viewModel.canEnableStartButton())
            }
            .padding(16)
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("Erro"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
