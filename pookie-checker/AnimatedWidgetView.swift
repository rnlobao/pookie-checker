import SwiftUI

struct AnimatedWidgetView: View {
    // Estado para controlar se a animação deve aparecer
    @State private var showAnimation = false
    
    var body: some View {
        VStack {
            // Elemento que vai ser animado
            if showAnimation {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .transition(.scale) // Transição animada
                    .animation(.easeInOut, value: showAnimation) // Controla o tipo de animação
            }

            Spacer()

            // Botão que dispara a animação
            Button(action: {
                // Alterna o estado para mostrar/ocultar a animação
                withAnimation {
                    showAnimation.toggle()
                }
            }) {
                Text(showAnimation ? "Ocultar Animação" : "Mostrar Animação")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

struct AnimatedWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedWidgetView()
    }
}
