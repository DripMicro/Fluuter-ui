import 'package:fluent_ui/fluent_ui.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({Key? key}) : super(key: key);

  @override
  _InputsPageState createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  bool disabled = false;

  bool value = false;

  double sliderValue = 5;
  double get max => 9;

  final FlyoutController controller = FlyoutController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Wrap(spacing: 10, runSpacing: 10, children: [
          Acrylic(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(bottom: 8.0),
            child: InfoLabel(
              label: 'Interactive Inputs',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    checked: value,
                    onChanged: disabled
                        ? null
                        : (v) => setState(() => value = v ?? false),
                  ),
                  ToggleSwitch(
                    checked: value,
                    onChanged:
                        disabled ? null : (v) => setState(() => value = v),
                  ),
                  RadioButton(
                    checked: value,
                    onChanged:
                        disabled ? null : (v) => setState(() => value = v),
                  ),
                  ToggleButton(
                    child: Text('Toggle Button'),
                    checked: value,
                    onChanged: disabled
                        ? null
                        : (value) => setState(() => this.value = value),
                  ),
                ],
              ),
            ),
          ),
          _buildButtons(),
          _buildSliders(),
          Acrylic(
            padding: EdgeInsets.all(10.0),
            child: Flyout(
              content: Padding(
                padding: EdgeInsets.only(left: 27),
                child: FlyoutContent(
                  padding: EdgeInsets.zero,
                  child: ListView(shrinkWrap: true, children: [
                    TappableListTile(title: Text('New'), onTap: () {}),
                    TappableListTile(title: Text('Open'), onTap: () {}),
                    TappableListTile(title: Text('Save'), onTap: () {}),
                    TappableListTile(title: Text('Exit'), onTap: () {}),
                  ]),
                ),
              ),
              verticalOffset: 20,
              contentWidth: 100,
              controller: controller,
              child: Button(
                child: Text('File'),
                onPressed: () {
                  controller.open = true;
                },
              ),
            ),
          ),
        ]),
      ),
      Acrylic(
        padding: EdgeInsets.all(10.0),
        child: InfoLabel(
          label: 'Input Properties',
          child: Column(children: [
            InfoLabel(
              label: 'Disabled',
              isHeader: false,
              child: ToggleSwitch(
                checked: disabled,
                onChanged: (v) => setState(() => disabled = v),
              ),
            ),
          ]),
        ),
      ),
    ]);
  }

  Widget _buildButtons() {
    final splitButtonHeight = 50.0;
    return Acrylic(
      padding: EdgeInsets.all(8),
      child: InfoLabel(
        label: 'Buttons',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Button(
            child: Text('Show Dialog'),
            onPressed: disabled
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (_) => ContentDialog(
                        title: Text('Delete file permanently?'),
                        content: Text(
                          'If you delete this file, you won\'t be able to recover it. Do you want to delete it?',
                        ),
                        actions: [
                          Button(
                            child: Text('Delete'),
                            autofocus: true,
                            onPressed: () {
                              // Delete file here
                            },
                          ),
                          Button(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
          ),
          Button.icon(
            icon: Icon(Icons.add),
            onPressed: disabled ? null : () => print('pressed icon button'),
          ),
          SizedBox(
            height: splitButtonHeight,
            child: SplitButtonBar(buttons: [
              Button(
                child: SizedBox(
                  height: splitButtonHeight,
                  child: Container(
                    color: context.theme.accentColor,
                    height: 24,
                    width: 24,
                  ),
                ),
                onPressed: disabled ? null : () {},
              ),
              Button(
                child: SizedBox(
                  height: splitButtonHeight,
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                onPressed: disabled ? null : () {},
                style: ButtonThemeData(padding: EdgeInsets.all(6)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildSliders() {
    return Acrylic(
      padding: EdgeInsets.all(8),
      child: InfoLabel(
        label: 'Sliders',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Flexible(
              fit: FlexFit.loose,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 200,
                  child: Slider(
                    max: max,
                    label: '${sliderValue.toInt()}',
                    value: sliderValue,
                    onChanged: (v) => setState(() => sliderValue = v),
                    divisions: 10,
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 200,
                  child: Slider(
                    max: max,
                    value: sliderValue,
                    onChanged: null,
                    style: SliderThemeData(useThumbBall: false),
                  ),
                ),
                RatingBar(
                  amount: max.toInt(),
                  rating: sliderValue,
                  onChanged: (v) => setState(() => sliderValue = v),
                ),
                RatingBar(
                  amount: max.toInt(),
                  rating: sliderValue,
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Slider(
                vertical: true,
                max: max,
                label: '${sliderValue.toInt()}',
                value: sliderValue,
                onChanged: (v) => setState(() => sliderValue = v),
                divisions: 10,
                style: SliderThemeData(useThumbBall: false),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Slider(
                vertical: true,
                max: max,
                value: sliderValue,
                onChanged: null,
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
