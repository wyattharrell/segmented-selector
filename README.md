# Segmented Selector
[![GitHub release](https://img.shields.io/github/release/wyattharrell/segmented-selector.svg)](https://github.com/wyattharrell/segmented-selector/releases)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/wyattharrell/segmented-selector/master/LICENSE)

[![GitHub issues](https://img.shields.io/github/issues-raw/wyattharrell/segmented-selector.svg)](https://github.com/wyattharrell/segmented-selector/issues) [![Swift Package Manager compatible](https://img.shields.io/badge/swift%20package%20manager-compatible-green)](https://swift.org/package-manager/)


![Segmented Select Gif](https://raw.githubusercontent.com/wyattharrell/segmented-selector/refs/heads/main/segmented-selector.gif)

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
This will be used as the datasource for the view. It should conform to `String`, `CaseIterable` & `Identifiable`.

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

### Initialize your ViewModel & SegmentedSelector View

```swift
// Create using default parameters
let viewState = SegmentedSelectorViewState(selectedSegment: .option1)
let exampleViewModel = ExampleViewModel(viewState: viewState)

// Or customize font, color, cornerRadius, etc.
let exampleViewModel = ExampleViewModel(
    viewState: SegmentedSelectorViewState(
        shape: <#T##Shape#>,
        selectedSegmentColor: <#T##Color#>,
        backgroundColor: <#T##Color#>,
        font: <#T##Font#>,
        animation: <#T##Animation#>,
        padding: <#T##CGFloat#>,
        selectedSegment: <#T##T#>
    )
)

struct SomeView: View {

    var viewModel: ExampleViewModel

    @ObservedObject
    var viewState: SegmentedSelectorViewState<ExampleEnum>

    init() {
    	self.viewModel = ExampleViewModel(
            viewState: SegmentedSelectorViewState(
                selectedSegmentColor: Color(UIColor.systemGray5),
                selectedSegment: .option1
            )
        )

        self.viewState = viewModel.viewState
    }

    var body: some View {
        ...
        SegmentedSelector(viewModel: exampleViewModel)
        ...

        // React to selection changes using `$viewState.selectedSegment`
    }
}
```

## Appearance

Some supported appearance properties via the `SegmentedSelectorViewState` are:

| Property | Type | Description |
|---|---|---|
| `backgroundColor` | `Color` | Background color |
| `selectedSegmentColor` | `Color` | Background color of the selected segment |
| `padding` | `CGFloat` | Padding between the selected segment and the background view |
| `shape` | `Shape` | The shape of the control. Either .roundedRectangle, or .capsule |
| `font` | `UIFont` | Um.. the font |
| `animation` | `Animation` | Animation of the segment selection. Can be set to `.bouncy`, `.easeIn`, etc. |

