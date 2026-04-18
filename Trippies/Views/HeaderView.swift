import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color("BrownColor"))
            Spacer()
            Text("Trippies")
                .font(.largeTitle)
                .foregroundStyle(Color("BrownColor"))
            Spacer()
            Image(systemName: "gearshape")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color("BrownColor"))
        }
        .padding()
        .background(Color("FourthColor"))
    }
}

#Preview {
    HeaderView()
}
