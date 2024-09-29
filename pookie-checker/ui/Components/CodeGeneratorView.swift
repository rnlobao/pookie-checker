import SwiftUI

struct CodeGeneratorView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        HStack {
            if !viewModel.isCodeGenerated {
                Button(action: {
                    viewModel.generateCode()
                }) {
                    Text("Create code")
                        .font(.headline)
                        .padding()
                        .frame(height: 60)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .transition(.scale)

                Button(action: {
                    viewModel.showInputCodeField()
                }) {
                    Text("Add existing")
                        .font(.headline)
                        .padding()
                        .frame(height: 60)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .transition(.scale)
            } else {
                HStack {
                    TextField("Code...", text: $viewModel.inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        print("Código inserido: \(viewModel.inputText)")
                        viewModel.isConnected = true
                    }) {
                        Text("Enviar")
                            .font(.headline)
                            .padding()
                            .frame(height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .transition(.scale)
            }

            if viewModel.showGeneratedCode, let code = viewModel.generatedCode {
                Text("Your code: \(code)")
                    .font(.headline)
                    .padding()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut, value: viewModel.isCodeGenerated)
    }
}
