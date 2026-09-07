import SwiftUI

struct AyahTodayCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "sparkles")
                Text("AYAH OF THE DAY")
                    .foregroundStyle(Color.primaryContainer).font(.caption)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(alignment: .center)
            .background(Color.primaryFixed, in: RoundedRectangle(cornerRadius: 12))

            Text("فَإِنَّ مَعَ الْعُسْرِ يُسْرًا")
                .foregroundStyle(.black)
                .font(.title2)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text("For indeed, with hardship [will be] ease.")
                .foregroundStyle(Color.neutral)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.surfaceContainer, in: RoundedRectangle(cornerRadius: 12))
        // .overlay(
        //     RoundedRectangle(cornerRadius: 12)
        //         .stroke(Color.surfaceContainer, lineWidth: 1)
        // )
    }
}

#Preview {
    AyahTodayCard()
}
