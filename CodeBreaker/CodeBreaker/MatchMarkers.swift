import SwiftUI

struct MatchMarkers: View {
    var matches: [Match]

    var body: some View {
        HStack {
            VStack {
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }

    func matchMarker(peg: Int) -> some View {
        let exactCount = matches.count { $0 == .exact }
        let foundCount = matches.count { $0 != .nomatch }
        let exactFill = exactCount > peg ? Color.primary : Color.clear
        let exactStroke = foundCount > peg ? Color.primary : Color.clear
        return Circle()
            .fill(exactFill)
            .strokeBorder(exactStroke, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact]).padding()
}
