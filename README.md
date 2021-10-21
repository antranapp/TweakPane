# TweakPane

Control panel for fine-tuning and monitoring paramters

## About

TweakPane is a library for iOS to build a control panel screen for fine-tuning parameters and monitoring value chages.

It inspires largely form [TweakPane](https://cocopon.github.io/tweakpane/)

If you have many parameters used to control your UI, and you want to play around with such parameters without having to change the source code and recompile again, TweakPane is very helpful for this case where you can build a quick control panel view to adjust the parameters and see how it affect your UIs.

## How does it work?

TweakPane ultilise the `@Binding` mechanism introduced in SwiftUI to create 2-way binding between the original properties and the control panel views. 

With this binding in place, any change of the original properties will be reflected automatically to the control panel view for monitoring purpose. 

TweakPane provides a set of standard Views to manipulate different types of values such as String, Number, Color etc... Via Binding, any change user mades in control panel will be assigned back to the original properties which can be used to manipulate the original UI.

## Usage

This is the simplest functional example of TweakPane:

```
import Foundation
import SwiftUI
import TweakPane

struct SimpleView: View {
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text(text)
            Pane([
                InputBlade(name: "Text", binding: InputBinding($text))
            ]).render()
        }
    }
}
```

More complex examples are in the Sample project.

 
## Installation

Swift Package Manager

```
https://github.com/antranapp/TweakPane
```

## License

TweakPane is available under the MIT license. See LICENSE file for more info.
