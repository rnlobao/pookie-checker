import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    let buttonImages = ["standing-dog", "standing-cat", "standing-panda", "standing-penguin"]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Choose your pookie")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            HStack(spacing: 20) {
                ForEach(0..<buttonImages.count, id: \.self) { index in
                    Button(action: {
                        viewModel.selectedButtonIndex = index
                    }) {
                        Image(buttonImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(viewModel.selectedButtonIndex == index ? Color.blue : Color(white: 0.8), lineWidth: 2)
                            )
                    }
                }
            }
            
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
                    .background((viewModel.selectedButtonIndex != nil && viewModel.isConnected) ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(viewModel.selectedButtonIndex == nil || !viewModel.isConnected)
            
        }
        .padding(16)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
