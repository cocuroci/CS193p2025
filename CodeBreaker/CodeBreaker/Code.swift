import SwiftUI

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Peg.missing, count: 4)

    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
        case unknown
    }

    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Peg.missing
        }
    }

    var matches: [Match]? {
        switch kind {
        case .attempt(let matches): return matches
        default: return nil
        }
    }

    func match(againts otherCode: Code) -> [Match] {
        var pegsToMatch = otherCode.pegs

        let backwardsExactMatches: [Match] = pegs.indices.reversed().map { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return .exact
            }
            return .nomatch
        }

        let exactMatches = Array(backwardsExactMatches.reversed())

        return pegs.indices.map { index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            }

            return exactMatches[index]
        }
    }
}
