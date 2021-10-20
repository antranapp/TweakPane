import SwiftUI
import BottomSheet
import Combine
import TweakPane

struct ContentView: View {
    @State var isSheetExpanded = true

    @State var boolValue: Bool = false
    @State var textValue: String = ""

    @State var selectedSegmentValue: String = "Value 1"
    private let segmentValues = ["Value 1", "Value 2", "Value 3"]

    @State var dateValue: Date = Date()

    @State var intStepperValue: Int = 0
    @State var doubleSliderValue: Double = 0

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Double Slider Value")) {
                    SliderView(
                        name: "Double Stepper Value",
                        range: 0...10,
                        sliderValue: $doubleSliderValue
                    )
                    Text(String(describing: doubleSliderValue))
                }

                Section(header: Text("Int Stepper Value")) {
                    StepperView(
                        name: "Int Stepper Value",
                        range: 0...10,
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
                minHeight: .points(100),
                maxHeight: .points(500),
                style: .standard,
                content: {
                    Pane([
                        InputBlade(
                            name: "Double Stepper Input",
                            option: .slider(range: 0...10),
                            binding: InputBinding($doubleSliderValue)
                        ),
                        InputBlade(
                            name: "Int Stepper Input",
                            option: .stepper(range: 0...10),
                            binding: InputBinding($intStepperValue)
                        ),
                        InputBlade(
                            name: "Date Input",
                            option: .none,
                            binding: InputBinding($dateValue)
                        ),
                        InputBlade(
                            name: "Picker Input",
                            option: .options(segmentValues),
                            binding: InputBinding($selectedSegmentValue)
                        ),
                        InputBlade(
                            name: "Text Input",
                            option: .none,
                            binding: InputBinding($textValue)
                        ),
                        MonitoringBlade(
                            name: "Text Monitor",
                            binding: MonitorBinding($textValue)
                        ),
                        InputBlade(
                            name: "Bool Input",
                            option: .none,
                            binding: InputBinding($boolValue)
                        ),
                    ]).render()
                }
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
