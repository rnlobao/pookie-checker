import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel    
    
    var body: some View {
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
            
            CodeGeneratorView(viewModel: viewModel)
            
            Spacer()
            
            Button(action: {
                print("Botão clicado! Personagem selecionado: \(viewModel.selectedButtonIndex!)")
            }) {
                Text("Iniciar")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background((viewModel.selectedButtonIndex != nil && viewModel.isCodeGenerated) ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(viewModel.selectedButtonIndex == nil || !viewModel.isCodeGenerated)
            
        }
        .padding(16)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
