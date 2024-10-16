import SwiftUI

struct ConnectPookieView: View {
    @ObservedObject var viewModel = ConnectPookieViewModel()
    @State private var isConnected = false
    
    var body: some View {
        ZStack {
            if isConnected {
                VStack {
                    Text("You are connected")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Button(action: {
                        viewModel.cleanInformation()
                        isConnected = false
                    }) {
                        Text("X")
                            .font(.title)
                            .frame(width: 100, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                }
                .transition(.opacity)
            } else {
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
                        if viewModel.canEnableStartButton() {
                            isConnected = true
                            viewModel.connectSuccessfully()
                        }
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
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isConnected)
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("Erro"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct ConnectPookieView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectPookieView(viewModel: ConnectPookieViewModel())
    }
}
