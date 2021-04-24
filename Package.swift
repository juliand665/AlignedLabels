// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "AlignedLabels",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
	],
	products: [
		.library(
			name: "AlignedLabels",
			targets: ["AlignedLabels"]
		),
	],
	dependencies: [],
	targets: [
		.target(
			name: "AlignedLabels",
			dependencies: []
		),
		.testTarget(
			name: "AlignedLabelsTests",
			dependencies: ["AlignedLabels"]
		),
	]
)
