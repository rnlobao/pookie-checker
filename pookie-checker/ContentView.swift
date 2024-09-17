import SwiftUI

struct ContentView: View {
    let images = ["cat"] // Substitua pelos nomes das suas imagens
    @State private var code: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Put your partner code:")
                .font(.title)
            HStack(spacing: 8) {
                TextField("Enter your code", text: $code)
                    .keyboardType(.numberPad) // Abre o teclado numérico
                    .padding(12)
                    .background(Color(UIColor.systemGray6)) // Fundo do TextField
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Button(action: {
                    // Ação ao pressionar o botão
                    print("Code entered: \(code)")
                }) {
                    Text("Submit")
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            Text("Choose your pookie:")
                .font(.title)
            HStack(spacing: 16) {
                
                ForEach(0..<1) { index in
                    Button(action: {
                        // Ação do botão
                        print("Botão \(index + 1) pressionado")
                    }) {
                        Image(images[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                    }
                    .cornerRadius(8)
                }
            }
            
            Text("Choose your interation:")
                .font(.title)
            
            Button(action: {
            }) {
                Text("Send a hug")
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .cornerRadius(8)
            
            Spacer()
            
            
        }
        .padding(16)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
