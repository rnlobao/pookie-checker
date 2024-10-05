import SwiftUI

struct ConnectionSuccessfulView: View {
    @State var show: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.green)
            
            Text("Connection successful")
                .font(.headline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .scaleEffect(show ? 1 : 0)
        .animation(.spring(), value: show)
        .onAppear {
            withAnimation {
                show = true
            }
        }
    }
}

struct SuccessConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionSuccessfulView()
    }
}
