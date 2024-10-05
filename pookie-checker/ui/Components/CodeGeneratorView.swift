import SwiftUI

struct CodeGeneratorView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            if !viewModel.isCodeGenerated, !viewModel.showInput {
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
                .transition(.move(edge: .leading).combined(with: .scale))
                
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
                .transition(.move(edge: .trailing).combined(with: .scale))

            } else {
                Button(action: {
                    withAnimation {
                        viewModel.isCodeGenerated = false
                        viewModel.showInput = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .transition(.scale)
                
                if viewModel.showInput {
                    HStack {
                        TextField("Code...", text: $viewModel.inputText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            viewModel.tryToConnect()
                            print("Código inserido: \(viewModel.inputText)")
                        }) {
                            Text("Connect")
                                .font(.headline)
                                .padding()
                                .frame(height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .transition(.scale)
                } else if let code = viewModel.generatedCode {
                    Text("Your code: \(code)")
                        .font(.headline)
                        .padding()
                        .transition(.scale)
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.isCodeGenerated)
    }
}
