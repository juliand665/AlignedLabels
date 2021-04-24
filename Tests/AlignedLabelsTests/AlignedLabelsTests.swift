import XCTest
@testable import AlignedLabels
import SwiftUI

final class AlignedLabelsTests: XCTestCase {
    func testExample() {
		print("TODO meaningful tests! not sure how to go about this…")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

struct Labeled_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			LabeledTextField("title", text: .constant("text"))
			LabeledTextField("title", text: .constant("text"))
			
			VStack(alignment: .leading) {
				Slider(value: .constant(0.5))
					.labeled("slider")
				
				Slider(value: .constant(0.3))
					.withoutLabel()
				
				if #available(macOS 11.0, *) {
					ColorPicker("color", selection: .constant(.accentColor))
						.labelsHidden()
						.labeled("color")
				}
				
				Rectangle()
				Rectangle().withoutLabel()
				
				Divider()
				
				LabeledTextField("textext", text: .constant("text"))
				LabeledTextField("texting", text: .constant("text"))
			}
			.aligningLabels()
		}
		.frame(idealWidth: 200)
		.fixedSize()
		.padding()
	}
}
