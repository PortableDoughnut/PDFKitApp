//
//  ContentView.swift
//  PDFKitApp
//
//  Created by Gwen Thelin on 2/14/25.
//

import SwiftUI

struct ContentView: View {
	@State private var characterName = "Hero"
	@State private var strength = 8
	@State private var dexterity = 8
	@State private var intelligence = 8
	@State private var wisdom = 8
	@State private var charisma = 8
	@State private var pointsRemaining = 27
	@State private var pdfURL: URL?
	
	var body: some View {
		VStack {
			Form {
				Section(header: Text("Character Info")) {
					TextField("Character Name", text: $characterName)
				}
				
				Section(header: Text("Stats")) {
					StatStepper(label: "Strength", value: $strength, pointsRemaining: $pointsRemaining, updatePoints: updatePointsRemaining)
					StatStepper(label: "Dexterity", value: $dexterity, pointsRemaining: $pointsRemaining, updatePoints: updatePointsRemaining)
					StatStepper(label: "Intelligence", value: $intelligence, pointsRemaining: $pointsRemaining, updatePoints: updatePointsRemaining)
					StatStepper(label: "Wisdom", value: $wisdom, pointsRemaining: $pointsRemaining, updatePoints: updatePointsRemaining)
					StatStepper(label: "Charisma", value: $charisma, pointsRemaining: $pointsRemaining, updatePoints: updatePointsRemaining)
				}
				
				Section(header: Text("Points Remaining")) {
					Text("\(pointsRemaining)")
						.foregroundColor(pointsRemaining < 0 ? .red : .primary)
				}
			}
			
			Button("Generate PDF") {
					// pdfURL = generatePDF()
			}
			.padding()
			.disabled(pointsRemaining != 0)
			
			if let url = pdfURL {
				ShareLink(item: url) {
					Text("Share PDF")
				}
			}
		}
		.navigationTitle("Character Sheet")
	}
	
	private func updatePointsRemaining() {
		let totalPointsSpent = cost(for: strength) +
		cost(for: dexterity) +
		cost(for: intelligence) +
		cost(for: wisdom) +
		cost(for: charisma)
		pointsRemaining = 27 - totalPointsSpent
	}
	
	private func cost(for score: Int) -> Int {
		switch score {
			case 8: return 0
			case 9: return 1
			case 10: return 2
			case 11: return 3
			case 12: return 4
			case 13: return 5
			case 14: return 7
			case 15: return 9
			default: return 0
		}
	}
}

struct StatStepper: View {
	let label: String
	@Binding var value: Int
	@Binding var pointsRemaining: Int
	var updatePoints: () -> Void
	
	var body: some View {
		Stepper("\(label): \(value)", value: $value, in: 8...15, step: 1) {
			_ in
			updatePoints()
		}
	}
}
#Preview {
    ContentView()
}
