import SwiftUI

public extension View {
	func aligningLabels() -> some View {
		LabelContainer(content: self)
	}
}

private struct LabelContainer<Content: View>: View {
	let content: Content
	@State var labelWidth: CGFloat?
	
	var body: some View {
		content
			.environment(\.labelWidth, labelWidth)
			.onPreferenceChange(MaxWidthKey.self) { labelWidth = $0 }
	}
}

public extension View {
	func labeled<Label: View>(
		alignment: VerticalAlignment = .center,
		@ViewBuilder label: () -> Label
	) -> some View {
		Labeled(label: label(), content: self, alignment: alignment)
	}
	
	func labeled(_ label: String, alignment: VerticalAlignment = .center) -> some View {
		labeled(alignment: alignment) {
			Text("\(label):").fixedSize()
		}
	}
	
	@ViewBuilder
	func withoutLabel() -> some View {
		self.labeled { Color.clear.frame(width: 0) }
	}
}

public func LabeledTextField(_ label: String, text: Binding<String>) -> some View {
	TextField(label, text: text)
		.labeled(label, alignment: .firstTextBaseline)
}

private struct Labeled<Label: View, Content: View>: View {
	let label: Label
	let content: Content
	let alignment: VerticalAlignment
	@Environment(\.labelWidth) var labelWidth
	
	var body: some View {
		HStack(alignment: alignment) {
			label
				.background(GeometryReader { geometry in
					Color.clear.preference(key: MaxWidthKey.self, value: geometry.size.width)
				}.hidden())
				.fixedSize()
				.frame(width: labelWidth, alignment: .trailing)
			
			content.layoutPriority(1)
		}
	}
}

private enum MaxWidthKey: PreferenceKey {
	static var defaultValue: CGFloat = 0
	
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = max(value, nextValue())
	}
}

private extension EnvironmentValues {
	private enum LabelWidthKey: EnvironmentKey {
		static let defaultValue: CGFloat? = nil
	}
	
	var labelWidth: CGFloat? {
		get { self[LabelWidthKey.self] }
		set { self[LabelWidthKey.self] = newValue }
	}
}

struct Labeled_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			LabeledTextField("title", text: .constant("text"))
			LabeledTextField("longer title", text: .constant("text"))
			
			VStack(alignment: .leading) {
				Slider(value: .constant(0.5))
					.labeled("slider")
				
				Slider(value: .constant(0.3))
					.withoutLabel()
				
				Slider(value: .constant(0.1))
				
				if #available(macOS 11.0, iOS 14.0, *) {
					ColorPicker("color", selection: .constant(.accentColor))
						.labelsHidden()
						.labeled("color")
				}
				
				Divider()
				
				LabeledTextField("textextext", text: .constant("text"))
				
				Rectangle()
				Rectangle().withoutLabel()
				
				LabeledTextField("texting", text: .constant("text"))
			}
			.aligningLabels()
		}
		.frame(idealWidth: 200)
		.fixedSize()
		.padding()
	}
}
