import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color("TertiaryColor"))
            Spacer()
            Text("Trippies")
                .font(.largeTitle)
            Spacer()
            Image(systemName: "gearshape")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color("TertiaryColor"))
        }
        .padding()
        .background(Color("FourthColor"))
    }
}

#Preview {
    HeaderView()
}
