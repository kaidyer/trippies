import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "location.north.circle.fill")
                .font(.title2)
                .foregroundStyle(Color.headerColor)
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.55), in: Circle())

            Spacer()

            VStack(spacing: 2) {
                Text("TRIPPIES")
                    .font(.title.weight(.bold))
                    .tracking(3)
                    .foregroundStyle(Color.textColor.opacity(0.65))
            }

            Spacer()

            Image(systemName: "gearshape.fill")
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.textColor)
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.55), in: Circle())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.white.opacity(0.32)).frame(height: 1)
        }
    }
}

#Preview {
    HeaderView()
}
