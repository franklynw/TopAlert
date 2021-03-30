# TopAlert

An alert which can be presented over any hierarchy of Views, with the ability to be dismissed programmatically if required. On occasion, you may want global alerts which need to be presented regardless of how many sub-views you've already presented. With the standard SwiftUI alert, this is awkward as you'd have to have an .alert on every view which is tied to the presentation logic. If you use TopAlert, just use it at the root level, and it will show above everything with no complaints about trying to present over another view which is already presenting.


## Installation

### Swift Package Manager

In Xcode:
* File ⭢ Swift Packages ⭢ Add Package Dependency...
* Use the URL https://github.com/franklynw/TopAlert.git


## Example

> **NB:** All examples require `import TopAlert` at the top of the source file


```swift
var body: some View {
    
    VStack {
        // my view content
    }
    
    TopAlert(alertConfig: $viewModel.alertConfig)
}
```

or 

```swift
var body: some View {
    
    VStack {
        // my view content
    }
    .topAlert(alertConfig: $viewModel.alertConfig)
}
```

The former method has the benefit of being able to add a modifier which allows you to dismiss the alert programmatically -

```swift
var body: some View {
    
    VStack {
        // my view content
    }
    
    TopAlert(alertConfig: $viewModel.alertConfig)
        .dismiss($viewModel.alertDismiss)
}
```


## Licence  

`TopAlert` is available under the MIT licence.
