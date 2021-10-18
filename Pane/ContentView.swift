import SwiftUI
import BottomSheet
import Combine



struct ContentView: View {
    @State var isSheetExpanded = true

    @State var boolValue: Bool = false
    @State var textValue: String = ""

    @State var selectedSegmentValue: String = "1"
    private let segmentValues = ["1", "2", "3"]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Segmented Value")) {
                    SegmentView(
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
                    ToogleView(value: $boolValue)
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
                            name: "Picker Input",
                            option: .options(segmentValues),
                            binding: InputBinding(parameter: $selectedSegmentValue.asParameterBinding)
                        ),
                        InputBlade(
                            name: "Text Input",
                            option: .none,
                            binding: InputBinding(parameter: $textValue.asParameterBinding)
                        ),
                        MonitoringBlade(
                            name: "Text Monitor",
                            binding: MonitorBinding(parameter: $textValue.asParameterBinding)
                        ),
                        InputBlade(
                            name: "Bool Input",
                            option: .none,
                            binding: InputBinding(parameter: $boolValue.asParameterBinding)
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
