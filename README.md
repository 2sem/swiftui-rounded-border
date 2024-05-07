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

# Usages
## width
![화면 기록 2024-05-07 오후 5 12 59](https://github.com/2sem/swiftui-rounded-border/assets/16129260/aa260aba-4b54-4980-82a3-f8d44b5b446f)

## CornerRadius
![화면 기록 2024-05-07 오후 5 18 23](https://github.com/2sem/swiftui-rounded-border/assets/16129260/d7ef7b70-9582-490c-b6fc-dfb4c9a647c2)

## position
<img width="170" alt="스크린샷 2024-05-07 오후 5 27 07" src="https://github.com/2sem/swiftui-rounded-border/assets/16129260/66cd89b5-8fb4-4e8e-9820-92953176a113">

## in
<img width="474" alt="스크린샷 2024-05-07 오후 5 29 16" src="https://github.com/2sem/swiftui-rounded-border/assets/16129260/9e3fdcce-81cc-488a-ba66-6500fad63f10">

## out
<img width="475" alt="스크린샷 2024-05-07 오후 5 30 00" src="https://github.com/2sem/swiftui-rounded-border/assets/16129260/fc90592b-9f2b-4702-869f-efaaae67bc32">
