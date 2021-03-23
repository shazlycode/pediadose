import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pediatric_dosage/providers/dosage_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  static const String id = 'antipyretic';
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool remove;
  String _selectedDrug = 'Paracetamol';
  String _selectedMedicine = ' ';
  String _generic = '';
  String _selectedAntibioticUse = 'Select use';
  Drug _selectedTotal = Drug();
  bool _doseView = false;
  bool searchEnabled = true;
  bool _tradeView = false;
  bool _precView = false;
  bool _contraView = false;
  int selectedYear = 0;
  double _listHeight = 300;
  int selectedMonth = 0;
  double _minDose = 0;
  double _maxDose = 0;
  String freq = '';
  String query;
  double age;
  double _weight = 0;
  List<int> years = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List<int> months = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  final _amoxiKey = GlobalKey<FormState>();
  final _amoxiClavKey = GlobalKey<FormState>();
  List<Drug> _filteredDrugs = [];
  List<String> _ampicillinUses = [
    'Select use',
    'Ear, Nose, & Throat Infections',
    'Acute Otitis Media',
    'Lower Respiratory Tract Infections'
  ];
  List<String> _amoxicillinClavUses = [
    'Select use',
    'sinusitis',
    'otitis media',
    'skin infection',
    'tonsilitis',
    'lower respiratory tract infections',
    'Acute otitis media',
    'Community-acquired Pneumonia'
  ];
  List<String> _azithromycinUse = [
    'Select use',
    'Acute Otitis Media',
    'Community-acquired Pneumonia',
    'Pharyngitis/Tonsillitis'
  ];
  List<String> _cefdinirUse = [
    'Select use',
    'Acute Bacterial Otitis Media',
    'Pharyngitis/Tonsillitis',
    'Acute Maxillary Sinusitis',
    'Skin/Skin Structure Infections',
  ];
  List<String> _cefaclorUse = [
    'Select use',
    'Lower Respiratory Tract Infections',
    'Otitis Media',
    'Uncomplicated Skin and Skin Structure Infections',
    'Pharyngitis and Tonsillitis'
  ];
  List<String> _cefadroxilUse = [
    'Select use',
    'Endocarditis Prophylaxis',
    'Pharyngitis',
    'Susceptible Infections'
  ];
  List<String> _cefiximUse = [
    'Select use',
    'Acute Bronchitis',
    'Otitis Media',
    'Pharyngitis/Tonsillitis',
    'Uncomplicated Gonorrhea',
    'Uncomplicated Urinary Tract Infections',
  ];
  List<String> _clarithromycinUse = [
    'Select use',
    'Otitis Media',
    'Community-Acquired Pneumonia',
    'Sinusitis',
    'Bronchitis',
    'Skin Infections',
    'Mycobacterial Infection',
    'Streptococcal Pharyngitis',
    'Endocarditis (Off-label)',
  ];
  List<String> _cefalexinUse = [
    'Select use',
    'skin and soft tissue infections',
    'streptococcal pharyngitis',
    'mild, uncomplicated urinary tract infections',
    'otitis media',
  ];
  List<String> _metroUse = [
    'Select use',
    'Anaerobic Infection',
    'Clostridium Difficile Colitis',
    'Amebiasis',
    'Giardiasis',
    'Trichomoniasis',
  ];
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final catName = ModalRoute.of(context).settings.arguments;
    final drugsData = Provider.of<AntipyreticProvider>(context);
    List<Drug> drugs = catName == 'Antipyretic'
        ? drugsData.antipyretics
        : catName == 'Antibiotics'
            ? drugsData.antibiotics
            : catName == 'GIT'
                ? drugsData.git
                : catName == 'Respiratory'
                    ? drugsData.respiratory
                    : catName == 'Common Cold'
                        ? drugsData.commomCold
                        : catName == 'Allergy'
                            ? drugsData.allergy
                            : drugsData.drugs;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: BasicContainer(catName: catName == null ? null : catName),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(5)),
            //       border: Border.all(width: 1, color: Colors.white)),
            //   child: DropdownButton<String>(
            //     underline: Container(),
            //     items: drugs.antipyretics
            //         .map((e) => DropdownMenuItem(
            //               child: Text(
            //                 e.name,
            //                 style: Theme.of(context).textTheme.bodyText2,
            //               ),
            //               value: e.name,
            //             ))
            //         .toList(),
            //     value: _selectedDrug,
            //     hint: Text('Select Drug'),
            //     onChanged: (value) {
            //       setState(() {
            //         _selectedDrug = value;
            //       });
            //     },
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                enabled: searchEnabled,
                decoration: InputDecoration(
                    fillColor: Color(0xff173f5f),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: 'Enter Drug Name'),
                controller: _searchController,
                onChanged: (value) {
                  // var result = drugs.searchByName(value);
                  print(value);
                  setState(() {
                    _filteredDrugs = drugs
                        .where((element) => element.tradeName
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()))
                        .toList();
                    //query = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff173f5f),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(width: 1, color: Colors.white)),
                child: Text(
                  'Selected Medicine:  $_selectedMedicine \nActive Ingredients: $_generic',
                ),
              ),
            ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'AMOXICILLIN 400MG/5ML' ||
                  _selectedTotal.genericName == 'AMOXICILLIN 200MG/5ML' ||
                  _selectedTotal.genericName == 'AMOXICILLIN 250MG/5ML' ||
                  _selectedTotal.genericName == 'AMOXICILLIN 125MG/5ML')
                DropdownButton(
                    key: _amoxiKey,
                    hint: Text('Select antibiotic uses'),
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _selectedAntibioticUse = value;
                      });
                    },
                    value: _selectedAntibioticUse,
                    items: _ampicillinUses
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList()),

            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'AMOXICILLIN/CLAVULANIC ACID 156MG/5ML' ||
                  _selectedTotal.genericName ==
                      'AMOXICILLIN/CLAVULANIC ACID 312MG/5ML' ||
                  _selectedTotal.genericName ==
                      'AMOXICILLIN/CLAVULANIC ACID 228MG/5ML' ||
                  _selectedTotal.genericName ==
                      'AMOXICILLIN/CLAVULANIC ACID 457/5ML' ||
                  _selectedTotal.genericName ==
                      'AMOXICILLIN/CLAVULANIC ACID 600MG/5ML')
                DropdownButton(
                  key: _amoxiClavKey,
                  hint: Text('Select antibiotic uses'),
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                      print(_selectedAntibioticUse);
                    });
                  },
                  value: _selectedAntibioticUse,
                  items: _amoxicillinClavUses
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'AZITHROMYCIN 200MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'AZITHROMYCIN 100MG/5ML SUSP')
                DropdownButton(
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                    });
                  },
                  items: _azithromycinUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text('Select Antibiotic use'),
                  autofocus: false,
                ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'CEFDINIR 250MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CEFDINIR 125MG/5ML SUSP')
                DropdownButton(
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                    });
                  },
                  items: _cefdinirUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text('Select antibiotic uses'),
                  autofocus: false,
                ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'CEFACLOR 125MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CEFACLOR 250MG/5ML SUSP')
                DropdownButton(
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                    });
                  },
                  items: _cefaclorUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text('Select antibiotic uses'),
                  autofocus: false,
                ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'CEFADROXIL 125MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CEFADROXIL 250MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CEFADROXIL 500MG/5ML SUSP')
                DropdownButton(
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                      print(_selectedAntibioticUse);
                    });
                  },
                  items: _cefadroxilUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text('Select antibiotic uses'),
                  autofocus: false,
                ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'CEFIXIME 200MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CEFIXIME 100MG/5ML SUSP')
                DropdownButton(
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                      print(_selectedAntibioticUse);
                    });
                  },
                  items: _cefiximUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text('Select antibiotic uses'),
                  autofocus: false,
                ),

            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName ==
                      'CLARITHROMYCIN 250MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CLARITHROMYCIN 125MG/5ML SUSP')
                DropdownButton(
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                      print(_selectedAntibioticUse);
                    });
                  },
                  items: _clarithromycinUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  hint: Text('Select antibiotic uses'),
                  autofocus: false,
                ),
            if (catName == 'Antibiotics')
              if (_selectedTotal.genericName == 'CEFALEXIN 250MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'CEFALEXIN 125MG/5ML SUSP')
                DropdownButton(
                  items: _cefalexinUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                    });
                  },
                ),
            if (catName == 'GIT')
              if (_selectedTotal.genericName ==
                      'METRONIDAZOLE 125MG/5ML SUSP' ||
                  _selectedTotal.genericName == 'METRONIDAZOLE 200MG/5ML SUSP')
                DropdownButton(
                  items: _metroUse
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  value: _selectedAntibioticUse,
                  onChanged: (value) {
                    setState(() {
                      _selectedAntibioticUse = value;
                    });
                  },
                ),
            if (_searchController.text.isNotEmpty)
              Container(
                height: _listHeight,
                child: ListView.builder(
                    itemCount: _filteredDrugs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_filteredDrugs[index].tradeName),
                          onTap: () {
                            setState(() {
                              _selectedDrug = _filteredDrugs[index].tradeName;
                              _selectedMedicine =
                                  _filteredDrugs[index].tradeName;
                              _selectedTotal = _filteredDrugs[index];
                              _generic = _filteredDrugs[index].genericName;
                              _searchController.text = _selectedDrug;
                              searchEnabled = false;
                              _listHeight = 0;
                            });
                          },
                        ),
                      );
                      //  _searchController.text == null ||
                      //         _searchController.text == ''
                      // ? null
                      //     : drugs[index]
                      //             .tradeName
                      //             .toLowerCase()
                      //             .contains(query.toLowerCase())
                      // ? Card(
                      //             child: ListTile(
                      //               title: Text(drugs[index].tradeName),
                      //               onTap: () {
                      //                 setState(() {
                      //                   _searchController.text =
                      //                       drugs[index].tradeName;

                      //                   _selectedDrug =
                      //                       drugs[index].tradeName;
                      //                   _selectedMedicine =
                      //                       drugs[index].tradeName;
                      //                   _selectedTotal = drugs[index];
                      //                   _generic = drugs[index].genericName;
                      //                   _searchController.clear();
                      //                   // _listHeight = 0;
                      //                 });
                      //               },
                      //             ),
                      //           )
                      //         : Container();
                    }),
              ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Year'),
                  DropdownButton(
                    items: years
                        .map((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                    value: selectedYear,
                  ),
                  Text('Month'),
                  DropdownButton(
                    items: months
                        .map((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMonth = value;
                        selectedYear == 0
                            ? _weight = double.parse(
                                ((selectedMonth + 9) / 2).toStringAsFixed(1))
                            : _weight = double.parse(
                                ((selectedYear + selectedMonth / 12) * 2 + 8)
                                    .toStringAsFixed(1));
                      });
                    },
                    value: selectedMonth,
                  ),
                  Divider(
                    color: Colors.red,
                    thickness: 10,
                  ),
                  Text('Weight'),
                  Text('$_weight'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedTotal.genericName == null ||
                          _weight == 0.0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text('Sorry...'),
                                  content: Text('Select Drug and age First'),
                                ));
                        setState(() {
                          _doseView = false;
                        });
                        return;
                      }
                      if (_selectedAntibioticUse == 'Select use' &&
                          catName == 'Antibiotics') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text('Sorry...'),
                                  content: Text('Select use'),
                                ));
                        setState(() {
                          _doseView = false;
                        });
                        return;
                      } else if (catName == 'Common Cold') {
                        if (selectedYear < 6) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Caution...'),
                                    content: Text(
                                        'Safety and efficacy for use under 6 years not established '),
                                  ));
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        }

                        setState(() {
                          _minDose = double.parse((_weight *
                                  _selectedTotal.minD *
                                  _selectedTotal.conc)
                              .toStringAsFixed(1));
                          _maxDose = double.parse((_weight *
                                  _selectedTotal.maxD *
                                  _selectedTotal.conc)
                              .toStringAsFixed(1));
                          freq = '${_selectedTotal.freq}';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                          'Ibuprofen 100MG/5ML SUSP') {
                        if ((_weight < 7.5)) {
                          setState(() {
                            _doseView = false;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use of ibuprofen under 6 months not established '),
                                    ));
                          });

                          return;
                        }
                        //selectedYear + selectedMonth / 12
                        setState(() {
                          _minDose = double.parse((_weight *
                                  _selectedTotal.minD *
                                  _selectedTotal.conc)
                              .toStringAsFixed(1));
                          _maxDose = double.parse((_weight *
                                  _selectedTotal.maxD *
                                  _selectedTotal.conc)
                              .toStringAsFixed(1));
                          freq = '${_selectedTotal.freq}';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 125MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Ear, Nose, & Throat Infections') {
                        setState(() {
                          _minDose = (_weight *
                                  _selectedTotal.minD *
                                  _selectedTotal.conc)
                              .toDouble();
                          _maxDose = (_weight *
                                  _selectedTotal.maxD *
                                  _selectedTotal.conc)
                              .toDouble();
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 125MG/5ML' &&
                          _selectedAntibioticUse == 'Acute Otitis Media') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 40 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 45 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10-14 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 125MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Lower Respiratory Tract Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 22.5 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 250MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Ear, Nose, & Throat Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 20 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 250MG/5ML' &&
                          _selectedAntibioticUse == 'Acute Otitis Media') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 40 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 45 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10-14 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 250MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Lower Respiratory Tract Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 22.5 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 200MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Ear, Nose, & Throat Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 20 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 200MG/5ML' &&
                          _selectedAntibioticUse == 'Acute Otitis Media') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 40 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 45 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10-14 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 200MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Lower Respiratory Tract Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 22.5 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 400MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Ear, Nose, & Throat Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 20 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 400MG/5ML' &&
                          _selectedAntibioticUse == 'Acute Otitis Media') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 40 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 45 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10-14 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                              'AMOXICILLIN 400MG/5ML' &&
                          _selectedAntibioticUse ==
                              'Lower Respiratory Tract Infections') {
                        setState(() {
                          _minDose = double.parse(
                              ((_weight * 15 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          _maxDose = double.parse(
                              ((_weight * 22.5 * _selectedTotal.conc)
                                  .toStringAsFixed(1)));
                          freq = 'PO q12hr for 10 days ';
                        });
                        setState(() {
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                          'AMOXICILLIN/CLAVULANIC ACID 156MG/5ML') {
                        if (_selectedAntibioticUse == 'sinusitis' ||
                            _selectedAntibioticUse ==
                                'lower respiratory tract infections' ||
                            _selectedAntibioticUse == 'tonsilitis' ||
                            _selectedAntibioticUse == 'otitis media' ||
                            _selectedAntibioticUse == 'skin infection') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 20 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 40 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            freq = 'PO q8hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Acute otitis media') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            freq = 'PO q8hr for 10 days ';
                          });
                        } else if (_selectedAntibioticUse ==
                            'Community-acquired Pneumonia') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            freq = 'PO q8hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'AMOXICILLIN/CLAVULANIC ACID 312MG/5ML') {
                        if (_selectedAntibioticUse == 'sinusitis' ||
                            _selectedAntibioticUse ==
                                'lower respiratory tract infections' ||
                            _selectedAntibioticUse == 'tonsilitis' ||
                            _selectedAntibioticUse == 'otitis media' ||
                            _selectedAntibioticUse == 'skin infection') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 20 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 40 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            freq = 'PO q8hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Community-acquired Pneumonia') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            freq = 'PO q8hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'AMOXICILLIN/CLAVULANIC ACID 228MG/5ML') {
                        if (_selectedAntibioticUse == 'sinusitis' ||
                            _selectedAntibioticUse ==
                                'lower respiratory tract infections' ||
                            _selectedAntibioticUse == 'tonsilitis' ||
                            _selectedAntibioticUse == 'otitis media' ||
                            _selectedAntibioticUse == 'skin infection') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 20 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 40 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));

                            freq = 'PO q12hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Acute otitis media') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = 'PO q12hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Community-acquired Pneumonia') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = 'PO q12hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'AMOXICILLIN/CLAVULANIC ACID 457/5ML') {
                        if (_selectedAntibioticUse == 'sinusitis' ||
                            _selectedAntibioticUse ==
                                'lower respiratory tract infections' ||
                            _selectedAntibioticUse == 'tonsilitis' ||
                            _selectedAntibioticUse == 'otitis media' ||
                            _selectedAntibioticUse == 'skin infection') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 20 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 40 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = 'PO q12hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Acute otitis media') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = 'PO q12hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Community-acquired Pneumonia') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 80 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 90 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = 'PO q12hr for 10 days ';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                              'AZITHROMYCIN 200MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              "AZITHROMYCIN 100MG/5ML SUSP") {
                        if (_selectedAntibioticUse == 'Acute Otitis Media') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 6 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          _minDose = double.parse(
                              (_weight * 10 * _selectedTotal.conc)
                                  .toStringAsFixed(1));

                          freq = 'PO Daily for 3 days';
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Community-acquired Pneumonia') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 6 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          _minDose = double.parse(
                              (_weight * 10 * _selectedTotal.conc)
                                  .toStringAsFixed(1));
                          _maxDose = 0.0;
                          double contineusD = double.parse(
                              (_weight * 5 * _selectedTotal.conc)
                                  .toStringAsFixed(1));
                          freq =
                              'PO on day1 followed by $contineusD on day 2-5';
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Pharyngitis/Tonsillitis') {
                          if (_weight < 12) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 2 years for tonsilitis and pharyngitis not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          _maxDose = 0.0;
                          _minDose = double.parse(
                              (_weight * 12 * _selectedTotal.conc)
                                  .toStringAsFixed(1));

                          freq = 'PO daily for 5 days not to exceed 500 mg/day';
                          print('Min Dose= $_minDose');
                          print('Min Dose= $_maxDose');
                          print(freq);
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                              'CEFDINIR 250MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'CEFDINIR 125MG/5ML SUSP') {
                        if (_selectedAntibioticUse ==
                            'Acute Bacterial Otitis Media') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 6 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 7 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            _maxDose = 0.0;
                            double fullDose = double.parse(
                                (_weight * 14 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq =
                                ' PO q12 hr for 5-10 days or $fullDose PO q 24 hr for 10 days';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Pharyngitis/Tonsillitis') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 6 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (_weight * 7 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            double fullDose = double.parse(
                                (_weight * 14 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq =
                                ' PO q12 hr for 5-10 days or $fullDose PO q 24 hr for 10 days';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Acute Maxillary Sinusitis') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 6 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (_weight * 7 * _selectedTotal.conc)
                                    .toStringAsFixed(1));

                            double fullDose = double.parse(
                                (_weight * 14 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq =
                                ' PO q12 hr for 5-10 days or $fullDose PO q 24 hr for 10 days';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Skin/Skin Structure Infections') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 6 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (_weight * 7 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            double fullDose = double.parse(
                                (_weight * 14 * _selectedTotal.conc)
                                    .toStringAsFixed(1));

                            freq =
                                ' PO q12 hr for 5-10 days or $fullDose PO q 24 hr for 10 days';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                          print('Min Dose= $_minDose');
                          print('Min Dose= $_maxDose');
                          print(freq);
                        }
                      } else if (_selectedTotal.genericName ==
                              'CEFACLOR 125MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'CEFACLOR 250MG/5ML SUSP') {
                        if (_selectedAntibioticUse ==
                                'Lower Respiratory Tract Infections' ||
                            _selectedAntibioticUse == 'Otitis Media' ||
                            _selectedAntibioticUse ==
                                'Uncomplicated Skin and Skin Structure Infections' ||
                            _selectedAntibioticUse ==
                                'Pharyngitis and Tonsillitis') {
                          if (_weight < 4.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Caution...'),
                                      content: Text(
                                          'Safety and efficacy for use under 1 months not established '),
                                    ));
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 20 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                ((_weight * 40 * _selectedTotal.conc) / 3)
                                    .toStringAsFixed(1));
                            freq = 'ml PO q8hr not to exceed 1g/day';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                              'CEFADROXIL 125MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'CEFADROXIL 250MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'CEFADROXIL 500MG/5ML SUSP') {
                        if (_selectedAntibioticUse ==
                            'Susceptible Infections') {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                ((_weight * 30 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = ' PO q12hr not to exceed 1g/dose';
                          });
                          print(_minDose);
                        } else if (_selectedAntibioticUse ==
                            'Endocarditis Prophylaxis') {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                ((_weight * 50 * _selectedTotal.conc))
                                    .toStringAsFixed(1));
                            freq = ' PO 1 hr before procedure no more than 2g';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse == 'Pharyngitis') {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                ((_weight * 30 * _selectedTotal.conc) / 2)
                                    .toStringAsFixed(1));
                            freq = ' PO q12hr not to exceed 1g/dose';
                          });
                          setState(() {
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                              'CEFIXIME 200MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'CEFIXIME 100MG/5ML SUSP') {
                        if (_weight < 7.5) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 months not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        }
                        if (_selectedAntibioticUse == 'Acute Bronchitis') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 8 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq =
                                'ml PO in single daily dose or ${_minDose / 2} ml PO q12 hrs';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse == 'Otitis Media') {
                          {
                            setState(() {
                              _minDose = double.parse(
                                  (_weight * 8 * _selectedTotal.conc)
                                      .toStringAsFixed(1));
                              freq =
                                  'ml PO in single daily dose or ${_minDose / 2} ml PO q12 hrs';
                              _doseView = true;

                              _contraView = false;
                              _precView = false;
                              _tradeView = false;
                            });
                          }
                        } else if (_selectedAntibioticUse ==
                            'Pharyngitis/Tonsillitis') {
                          {
                            setState(() {
                              _minDose = double.parse(
                                  (_weight * 8 * _selectedTotal.conc)
                                      .toStringAsFixed(1));
                              freq =
                                  'ml PO in single daily dose or ${_minDose / 2} ml PO q12 hrs';
                              _doseView = true;

                              _contraView = false;
                              _precView = false;
                              _tradeView = false;
                            });
                          }
                        } else if (_selectedAntibioticUse ==
                            'Uncomplicated Gonorrhea') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 8 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq =
                                ' PO in single daily dose or ${_minDose / 2} ml PO q12 hrs';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Uncomplicated Urinary Tract Infections') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 8 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq =
                                ' PO in single daily dose or ${_minDose / 2} ml PO q12 hrs';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'CLARITHROMYCIN 250MG/5ML SUSP') {
                        if (_selectedAntibioticUse == 'Otitis Media' ||
                            _selectedAntibioticUse ==
                                'Community-Acquired Pneumonia' ||
                            _selectedAntibioticUse == 'Sinusitis' ||
                            _selectedAntibioticUse == 'Bronchitis' ||
                            _selectedAntibioticUse == 'Skin Infections' ||
                            _selectedAntibioticUse ==
                                'Mycobacterial Infection' ||
                            _selectedAntibioticUse ==
                                'Streptococcal Pharyngitis') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Caution...'),
                                    content: Text(
                                        'Safety and efficacy for use under 6 months not established '),
                                  );
                                });
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 7.5 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq = ' PO q12 hrs for 10 days';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'CLARITHROMYCIN 125MG/5ML SUSP') {
                        if (_selectedAntibioticUse == 'Otitis Media' ||
                            _selectedAntibioticUse ==
                                'Community-Acquired Pneumonia' ||
                            _selectedAntibioticUse == 'Sinusitis' ||
                            _selectedAntibioticUse == 'Bronchitis' ||
                            _selectedAntibioticUse == 'Skin Infections' ||
                            _selectedAntibioticUse ==
                                'Mycobacterial Infection' ||
                            _selectedAntibioticUse ==
                                'Streptococcal Pharyngitis') {
                          if (_weight < 7.5) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Caution...'),
                                    content: Text(
                                        'Safety and efficacy for use under 6 months not established '),
                                  );
                                });
                            setState(() {
                              _doseView = false;
                            });
                            return;
                          }
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 7.5 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq = ' PO q12 hrs for 10 days';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                              'CEFALEXIN 250MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'CEFALEXIN 125MG/5ML SUSP') {
                        if (_selectedAntibioticUse == 'otitis media') {
                          setState(() {
                            _minDose = double.parse(
                                ((_weight * 18.75 * _selectedTotal.conc)
                                    .toStringAsFixed(1)));
                            _maxDose = double.parse(
                                ((_weight * 25 * _selectedTotal.conc)
                                    .toStringAsFixed(1)));
                            freq = ' Po q4hr for 10 days';
                          });
                        } else {
                          setState(() {
                            _minDose = double.parse((_weight *
                                    _selectedTotal.minD *
                                    _selectedTotal.conc)
                                .toStringAsFixed(1));
                            _maxDose = double.parse((_weight *
                                    _selectedTotal.maxD *
                                    _selectedTotal.conc)
                                .toStringAsFixed(1));
                            freq = '${_selectedTotal.freq}';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                              'METRONIDAZOLE 125MG/5ML SUSP' ||
                          _selectedTotal.genericName ==
                              'METRONIDAZOLE 200MG/5ML SUSP') {
                        if (_selectedAntibioticUse == 'Anaerobic Infection') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 10 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            _maxDose = 0.0;
                            freq = ' Po q8hrs 7-10 days not to exceed 4g/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse ==
                            'Clostridium Difficile Colitis') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 10 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            _maxDose = 0.0;
                            freq = ' Po q8hrs 7-10 days not to exceed 4g/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse == 'Amebiasis') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 11.7 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            _maxDose = double.parse(
                                (_weight * 16.7 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            freq = ' Po q8hrs 10 days not to exceed 4g/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse == 'Giardiasis') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 5 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            _maxDose = 0.0;
                            freq = ' Po q8hrs 5 days';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_selectedAntibioticUse == 'Trichomoniasis') {
                          setState(() {
                            _minDose = double.parse(
                                (_weight * 5 * _selectedTotal.conc)
                                    .toStringAsFixed(1));
                            _maxDose = 0.0;
                            freq = ' Po q8hrs 7 days, not to exceed 2g/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'NITAZOXANIDE 100MG/5ML SUSP') {
                        if (_weight < 10) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 1 year not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight >= 10 && _weight < 14) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = 'PO q12hr x 3 days';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 10;
                            freq = 'PO q12hr x 3 days';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'DIOCTAHEDRAL SMECTITE') {
                        if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 10;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'KAOLIN+PECTIN') {
                        if (_weight < 14) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 3 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 15;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'NIFUROXAZIDE') {
                        if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 15;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'TRIMEBUTINE') {
                        if (_weight < 10) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = 'PO q12hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 10;
                            freq = 'PO q8hr';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'CARAWAY OIL+DILL OIL+SODIUM BICARBONATE') {
                        if (_weight < 7.5) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq =
                                'PO during or after each feed or up to six times/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 10;
                            freq =
                                'PO during or after each feed or up to six times/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'DOMPERIDONE 100MG/100ML ORAL SUSP') {
                        setState(() {
                          _maxDose =
                              double.parse((_weight * .50).toStringAsFixed(1));
                          _minDose =
                              double.parse((_weight * .25).toStringAsFixed(1));
                          freq = 'PO q8hr before meal, do not exceed 80 mg/day';
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName == 'LACTULOSE') {
                        setState(() {
                          _maxDose = double.parse(
                              ((_weight * 3) / 3).toStringAsFixed(1));
                          _minDose = double.parse(
                              ((_weight * 1) / 3).toStringAsFixed(1));
                          freq = 'PO q8hr, do not exceed 60 ml/day';
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      } else if (_selectedTotal.genericName ==
                          'DOCUSATE SODIUM') {
                        if (_weight < 12) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 2 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else {
                          setState(() {
                            _maxDose = 12.50;
                            _minDose = 4.16;
                            freq = 'PO q8hr, do not exceed 60 ml/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'SIMETHICONE') {
                        if (_weight < 12) {
                          setState(() {
                            _doseView = true;
                            _maxDose = 0.0;
                            _minDose = 0.3;
                            freq =
                                ' Po ie: 6 drops q6hr after meals and at bedtime, not to exceed 240 mg/day';

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = .6;
                            freq =
                                ' Po ie: 12 drops q6hr after meals and at bedtime, not to exceed 480 mg/day';
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'CETIRIZINE') {
                        if (_weight < 12) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 2 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 20) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 2.5;
                            freq =
                                " Po once daily can increase to 5 mg PO qDay or 2.5 mg PO twice daily; not to exceed 5 mg qDay";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 10;
                            _minDose = 5;
                            freq =
                                " PO qDay, depending on severity of symptoms; not to exceed 10 mg qDay";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'CHLORPHENIRAMINE') {
                        if (_weight < 12) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 2 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 20) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 2.5;
                            freq = " PO q4-6hr; not to exceed 6 mg/day";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0;
                            _minDose = 5;
                            freq =
                                " PO q4-6hr; not to exceed 12 mg/day or sustained release HS";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'CLEMASTINE') {
                        if (_weight < 20) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                ((_weight * 0.335 * _selectedTotal.conc) / 12)
                                    .toStringAsFixed(1));
                            freq = " PO q12hr; not to exceed 1.34 mg";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = double.parse(
                                ((_weight * 1 * _selectedTotal.conc) / 12)
                                    .toStringAsFixed(1));
                            _minDose = double.parse(
                                ((_weight * 0.5 * _selectedTotal.conc) / 12)
                                    .toStringAsFixed(1));
                            freq = " PO q12hr; not to exceed 4.02 mg/day";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'DESLORATADINE') {
                        if (_weight < 7.5) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 months not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 12) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (1 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO qd";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse((1.25 * _selectedTotal.conc)
                                .toStringAsFixed(1));
                            freq = " PO qd";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_weight < 32) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (2.5 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO qd";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (5 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO qd";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'FEXOFENADINE') {
                        if (_weight < 7.5) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 months not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 12) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (15 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO bid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_weight < 32) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (30 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO bid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (60 * _selectedTotal.conc).toStringAsFixed(1));
                            freq =
                                " PO bid or ${_minDose * 2} ml PO once daily";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'KETOTIFEN') {
                        if (_weight < 7.5) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 months not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 14) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 2.5;
                            freq = " PO bid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_weight >= 14) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = " PO bid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'LEVOCETIRIZINE') {
                        if (_weight < 7.5) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 months not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse((1.25 * _selectedTotal.conc)
                                .toStringAsFixed(1));
                            freq = " PO qDay in evening";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else if (_weight < 32) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (2.5 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO qDay in evening";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (5 * _selectedTotal.conc).toStringAsFixed(1));
                            freq =
                                " PO qDay in evening; some patients may respond to 2.5 mg/day";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName == 'LORATADINE') {
                        if (_weight < 12) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 2 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 20) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (5 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO qDay";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = double.parse(
                                (10 * _selectedTotal.conc).toStringAsFixed(1));
                            freq = " PO qDay not to exceed 10 mg qDay";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'GUAIACOL+PHOLCODINE') {
                        if (_weight < 13.2) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 30 months not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 18) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 2.5;
                            freq = " PO tid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = " PO tid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'LEVODROPROPIZINE') {
                        if (_weight < 12) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 2 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else if (_weight < 20) {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 2.5;
                            freq = " PO tid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = " PO tid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'CARBINOXAMINE+EPHEDRINE+PHOLCODINE') {
                        if (_weight < 20) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = " PO tid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else if (_selectedTotal.genericName ==
                          'CHLORPHENIRAMINE+DEXTROMETHORPHAN') {
                        if (_weight < 20) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Caution...'),
                                  content: Text(
                                      'Safety and efficacy for use under 6 years not established '),
                                );
                              });
                          setState(() {
                            _doseView = false;
                          });
                          return;
                        } else {
                          setState(() {
                            _maxDose = 0.0;
                            _minDose = 5;
                            freq = " PO tid";
                            _doseView = true;

                            _contraView = false;
                            _precView = false;
                            _tradeView = false;
                          });
                        }
                      } else {
                        setState(() {
                          _minDose = double.parse((_weight *
                                  _selectedTotal.minD *
                                  _selectedTotal.conc)
                              .toStringAsFixed(1));
                          _maxDose = double.parse((_weight *
                                  _selectedTotal.maxD *
                                  _selectedTotal.conc)
                              .toStringAsFixed(1));
                          freq = '${_selectedTotal.freq}';
                          _doseView = true;

                          _contraView = false;
                          _precView = false;
                          _tradeView = false;
                        });
                      }
                      setState(() {
                        searchEnabled = false;
                      });
                    },
                    child: Text('Dose'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectedTotal == null
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Sorry...'),
                                    content: Text('Select Drug First'),
                                  ))
                          : setState(() {
                              _doseView = false;
                              _contraView = false;
                              _precView = false;
                              _tradeView = true;
                            });
                    },
                    child: Text('Trade Name'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectedTotal == null
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Sorry...'),
                                    content: Text('Select Drug First'),
                                  ))
                          : setState(() {
                              _doseView = false;
                              _contraView = false;
                              _precView = true;
                              _tradeView = false;
                            });
                    },
                    child: Text('Precautions'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectedTotal == null
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text('Sorry...'),
                                    content: Text('Select Drug First'),
                                  ))
                          : setState(() {
                              _doseView = false;
                              _contraView = true;
                              _precView = false;
                              _tradeView = false;
                            });
                    },
                    child: Text('Contraindications'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // setState(() {
                      //   _weight = 0.0;
                      //   _minDose = 0.0;
                      //   _maxDose = 0.0;
                      //   selectedYear = 0;
                      //   selectedMonth = 0;

                      //   _selectedMedicine = '';
                      //   _selectedDrug = '';
                      //   _selectedTotal = Drug();
                      //   _generic = '';
                      //   _selectedAntibioticUse = 'Select use';
                      //   freq = '';
                      //   _doseView = false;
                      //   _contraView = false;
                      //   _precView = false;
                      //   _tradeView = false;
                      //   _searchController.clear();
                      //   searchEnabled = true;
                      //   drugs = catName == 'Antipyretic'
                      //       ? drugsData.antipyretics
                      //       : catName == 'Antibiotics'
                      //           ? drugsData.antibiotics
                      //           : catName == 'GIT'
                      //               ? drugsData.git
                      //               : catName == 'Respiratory'
                      //                   ? drugsData.respiratory
                      //                   : catName == 'Common Cold'
                      //                       ? drugsData.commomCold
                      //                       : drugsData.drugs;
                      // });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text('New Search'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (_doseView == true && _weight != 0)
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff173f5f),
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: selectedYear + selectedMonth / 12 == 0 ||
                          _minDose == 0.0
                      ? Text('Dose:\n ${_selectedTotal.doseNote}')
                      : _maxDose == 0.0
                          ? Text(
                              'Dose:\n $_minDose ml $freq\n${_selectedTotal.doseNote} ')
                          : Text(
                              'Dose:\n $_minDose - $_maxDose ml $freq\n${_selectedTotal.doseNote} ')),
            if (_precView == true && _selectedTotal.freq != null)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff173f5f),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: _selectedTotal.prec.length * 60.0 >= 350
                    ? 350
                    : _selectedTotal.prec.length * 60.0,
                child: Column(
                  children: [
                    Text('Precautions: '),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: _selectedTotal.prec
                            .map((e) => Text('\n▶ $e'))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            // ResultContainer('Precautions:\n\n ${_selectedTotal.prec}'),
            if (_contraView == true && _selectedTotal.contra != null)
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff173f5f),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: _selectedTotal.contra.length * 100.0,
                child: Column(
                  children: [
                    Text('Contraindications: '),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: _selectedTotal.contra
                            .map((e) => Text('\n▶ $e'))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            if (_tradeView == true && _selectedTotal.tradeName != null)
              ResultContainer('Trade Name:\n\n ${_selectedTotal.tradeName}'),
          ]),
        ),
      ),
    ));
  }
}

class ResultContainer extends StatelessWidget {
  final String text;
  ResultContainer(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xff173f5f),
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Text(text));
  }
}

class BasicContainer extends StatelessWidget {
  const BasicContainer({
    @required this.catName,
  });

  final String catName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 1)),
      child: Text(
        catName,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
