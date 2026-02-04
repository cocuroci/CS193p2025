import SwiftUI

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegChoices: [Peg]

    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }

    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(againts: masterCode))
        attempts.append(attempt)
    }

    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPegIndex = (indexOfExistingPegInChoices + 1) % pegChoices.count
            let newPeg = pegChoices[newPegIndex]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Peg.missing
        }
    }
}
