import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple App calculator',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    );
  }
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  final _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _minPaddin = 5.0;
  String _currentItemSelect = 'Rupees';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: getAppBar(),
        body: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(_minPaddin * 2),
                child: ListView(
                  children: <Widget>[
                    getImageAsset(),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: _minPaddin, top: _minPaddin),
                      child: TextFormField(
                          style: textStyle,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please write input';
                            }

                            if (num.tryParse(value) != null) {
                              return 'Please write string only';
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: principalController,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15.0),
                              labelText: 'Principal',
                              labelStyle: textStyle,
                              hintText: 'Enter Principal e.g. 12000',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)))),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: _minPaddin, top: _minPaddin),
                        child: TextFormField(
                            style: textStyle,
                            controller: roiController,
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please write Roi';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Principal',
                                hintText: 'Enter Principal e.g. 12000',
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(5.0))))),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPaddin, bottom: _minPaddin),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                    style: textStyle,
                                    controller: termController,
                                    keyboardType: TextInputType.number,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Please write term";
                                      }
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Tern',
                                        hintText: 'Tome in years',
                                        labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.yellowAccent,
                                            fontSize: 15.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))))),
                            Container(width: _minPaddin * 5),
                            Expanded(
                                child: DropdownButton<String>(
                                    items: _currencies.map((String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    value: _currentItemSelect,
                                    onChanged: (String newValueSelected) {
                                      // your code app
                                      _onChangeSelectValue(newValueSelected);
                                    })),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPaddin, bottom: _minPaddin),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text('Calculator', textScaleFactor: 1.5),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    displayResult = _calculateTotalReturns();
                                  }
                                });
                              },
                            )),
                            Expanded(
                                child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Reset',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              },
                            ))
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: _minPaddin, bottom: _minPaddin),
                        child: Text(displayResult))
                  ],
                ))));
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result = 'After $term will be $totalAmountPayable';
    return result;
  }

  void _onChangeSelectValue(String value) {
    print(value);
    setState(() {
      this._currentItemSelect = value;
    });
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/img.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPaddin * 2),
    );
  }

  Widget getAppBar() {
    return AppBar(
        title: Container(
            alignment: AlignmentDirectional(-1.0, 0),
            child: Text(
              'Simple First App calculator',
              textAlign: TextAlign.left,
            )));
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
  }
}
