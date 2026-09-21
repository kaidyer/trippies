import SwiftUI

struct TrippieCategoryView: View {
    let trippieCategory: TrippieCategory

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: "map.fill")
                .font(.title3.weight(.semibold))
                .foregroundStyle(Color.headerColor)
                .frame(width: 50, height: 50)
                .background(Color.headerColor.opacity(0.13), in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            VStack(alignment: .leading, spacing: 8) {
                Text(trippieCategory.type)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.textColor)

                Text("Average duration  •  \(trippieCategory.avgDuration) seconds")
                    .font(.subheadline)
                    .foregroundStyle(Color.textColor.opacity(0.72))
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(Color.textColor.opacity(0.45))
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 94)
        .background(Color.surfaceColor, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.7), lineWidth: 1)
        }
        .shadow(color: Color.softShadow, radius: 16, x: 0, y: 9)
    }
}

struct CreateTrippieCategoryView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "plus")
                .font(.body.weight(.bold))
                .frame(width: 30, height: 30)
                .background(Color.headerColor.opacity(0.16), in: Circle())

            Text("Add a category")
                .font(.body.weight(.semibold))

            Spacer()
        }
        .foregroundStyle(Color.textColor)
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity, minHeight: 64)
        .background(Color.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(0.6), style: StrokeStyle(lineWidth: 1, dash: [7, 5]))
        }
    }
}

#Preview {
    let trippieCategory = TrippieCategory(type: "Travel", avgDuration: 35, trippies: [])
    VStack {
        TrippieCategoryView(trippieCategory: trippieCategory)
        CreateTrippieCategoryView()
    }
}
