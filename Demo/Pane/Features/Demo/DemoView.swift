//
// Copyright © 2021 An Tran. All rights reserved.
//

import BottomSheet
import Combine
import SwiftUI
import TweakPane

struct DemoView: View {
    @State var isSheetExpanded = true

    @State var boolValue: Bool = false
    @State var textValue: String = ""

    @State var selectedSegmentValue: String = "Value 1"
    private let segmentValues = ["Value 1", "Value 2", "Value 3"]

    @State var dateValue = Date()

    @State var intStepperValue: Int = 0
    @State var doubleStepperValue: Double = 0
    @State var doubleSliderValue: Double = 0

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Double Slider Value")) {
                    SliderView(
                        name: "Double Stepper Value",
                        range: 0 ... 10,
                        sliderValue: $doubleSliderValue
                    )
                    Text(String(describing: doubleSliderValue))
                }

                Section(header: Text("Double Stepper Value")) {
                    StepperView(
                        name: "Double Stepper Value",
                        range: 0 ... 10,
                        stepValue: $doubleStepperValue
                    )
                    Text(String(describing: doubleStepperValue))
                }

                Section(header: Text("Int Stepper Value")) {
                    StepperView(
                        name: "Int Stepper Value",
                        range: 0 ... 10,
                        stepValue: $intStepperValue
                    )
                    Text(String(describing: intStepperValue))
                }

                Section(header: Text("Date Value")) {
                    DatePickerView(
                        name: "Date Value",
                        date: $dateValue
                    )
                    Text(String(describing: dateValue))
                }

                Section(header: Text("Segmented Value")) {
                    SegmentView(
                        name: "Segmented Value",
                        values: segmentValues,
                        selectedValue: $selectedSegmentValue
                    )
                    Text(String(describing: selectedSegmentValue))
                }

                Section(header: Text("Text Value")) {
                    TextField("Text value", text: $textValue)
                    Text(textValue)
                }

                Section(header: Text("Bool Value")) {
                    ToogleView(
                        name: "Bool Value",
                        value: $boolValue
                    )
                    Text(String(describing: boolValue))
                }
            }
        }
        .bottomSheet(
            BottomSheet(
                isExpanded: $isSheetExpanded,
                minHeight: .points(120),
                maxHeight: .points(500),
                style: .standard,
                content: {
                    ScrollView {
                        Pane([
                            InputBlade(
                                name: "Double Slider Input",
                                option: .slider(range: 0 ... 10),
                                binding: InputBinding($doubleSliderValue)
                            ),
                            InputBlade(
                                name: "Int Stepper Input",
                                option: .stepperInt(range: 0 ... 10),
                                binding: InputBinding($intStepperValue)
                            ),
                            InputBlade(
                                name: "Double Stepper Input",
                                option: .stepperDouble(range: 0 ... 10),
                                binding: InputBinding($doubleStepperValue)
                            ),
                            InputBlade(
                                name: "Date Input",
                                binding: InputBinding($dateValue)
                            ),
                            InputBlade(
                                name: "Picker Input",
                                option: .options(segmentValues, style: .segmented),
                                binding: InputBinding($selectedSegmentValue)
                            ),
                            InputBlade(
                                name: "Text Input",
                                binding: InputBinding($textValue)
                            ),
                            MonitoringBlade(
                                name: "Text Monitor",
                                binding: MonitorBinding($textValue)
                            ),
                            InputBlade(
                                name: "Bool Input",
                                binding: InputBinding($boolValue)
                            ),
                        ])
                            .padding(.horizontal)
                            .padding(.bottom, 100)

                    }
                }
            )
        )
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
