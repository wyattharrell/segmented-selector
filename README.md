# Segmented Selector

A modern UISegmentedControl built with SwiftUI.

## Requirements

- iOS 17.0+

## Installation

### Swift Package Manager

`segmented-selector` supports SPM. In Xcode, click File -> Swift Packages -> Add Package Dependency, enter https://github.com/wyattharrell/segmented-selector.git. Select the version you’d like to use.

You can also manually add the package to your Package.swift file:
```ruby
.package(url: "https://github.com/wyattharrell/segmented-selector.git", from: "1.0.0")
```

## Getting Started

### Create an Enum

```swift
enum ExampleEnum: String, CaseIterable, Identifiable {
    var id: Self { self }

    case option1 = "Option 1"
    case option2 = "Option 2"
    case option3 = "Option 3"
}

```
This will be used as the datasource for the View. It should conform to `String`, `CaseIterable` & `Identifiable`.

### Create a ViewModel

```swift
class ExampleViewModel: SegmentedSelectorViewModel {

	var viewState: SegmentedSelectorViewState<ExampleEnum>

    init(viewState: SegmentedSelectorViewState<ExampleEnum>) {
        self.viewState = viewState
    }

    func selectionChanged() {
        // React to selection changes with your own haptic feedback implementation
    }
}
```
It should conform to `SegmentedSelectorViewModel`.

### Initialize your ViewModel & SegmentedSelector

```swift
let exampleViewModel = ExampleViewModel(viewState: .init(selectedSegment: .option1))

var body: some View {
	...
	SegmentedSelector(viewModel: exampleViewModel)
	...
}
```


