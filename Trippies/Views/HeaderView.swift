import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.textColor)
            Spacer()
            Text("Trippies")
                .font(.largeTitle)
                .foregroundStyle(Color.headerColor)
            Spacer()
            Image(systemName: "gearshape")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.textColor)
        }
        .padding()
        .background(Color.tileColor)
    }
}

#Preview {
    HeaderView()
}
