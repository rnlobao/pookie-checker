import SwiftUI

struct HomeView: View {
    @State private var inputText: String = ""
    @State private var imagem: String = "antes"
    
    @ObservedObject var viewModel: HomeViewModel
    
    
    var body: some View {
        VStack(spacing: 16) {
            Image(imagem)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 350)
                .clipShape(Circle())
            
            Divider()
                .padding(.vertical)
            
            Button(action: {
                imagem = "depois"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    imagem = "antes"
                }
            }) {
                Text("Mande um abraço")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            HStack {
                TextField("Digite o código", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    print("Texto digitado: \(inputText)")
                }) {
                    Text("Enviar")
                        .font(.headline)
                        .padding()
                        .frame(height: 40)
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding(16)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
