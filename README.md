I'm creating new app with SwiftUI. This time, I made a little special border.

The border should be rounded only outside.

Maybe you might think it can be solved by overlay content on border.
However I wanted more customable.

# Installation
## SPM
```
Package(
  ...,
  dependencies: [
    .package(url: "https://github.com/2sem/swiftui-rounded-border", from: "0.0.1")
  ], ...
)
```

## Tuist
```
let project = Project(
    ...,
    packages: [
        ...,
        .remote(url: "https://github.com/2sem/swiftui-rounded-border",
            requirement: .upToNextMinor(from: "0.0.1")),
    ],
    targets: [
        .target(
            ...,
            dependencies: [
                .package(product: "RoundedBorder", type: .runtime),
            ],
```
