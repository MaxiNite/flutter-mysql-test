import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HerramientaDataSource herramientaDataSource;
  late List<GridColumn> _columns;

  Future<dynamic> generateHerramientaList() async {
    var url = 'http://localhost/maqpro/phpScript.php';

    final response = await http.get(url as Uri);
    var list = json.decode(response.body);
    List<Herramienta> _herramientas = await list
        .map<Herramienta>((json) => Herramienta.fromJson(json))
        .toList();
    herramientaDataSource = HerramientaDataSource(_herramientas);
    return _herramientas;
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      gridColumn('medida', 'Medida'),
      gridColumn('codigo', 'Codigo'),
      gridColumn('cantidad', 'Cantidad'),
      gridColumn('ultimaFecha', 'Ultima Fecha Act'),
      gridColumn('tipo', 'Tipo'),
      gridColumn('isCarburo', 'Es Carburo'),
      gridColumn('bolaFlat', 'Bola/Flat'),
      gridColumn('filos', 'Filos'),
      gridColumn('nombreHerramienta', 'Nombre Herramienta'),
    ];
  }

  GridColumn gridColumn(String name, String text) {
    return GridColumn(
      columnName: name,
      width: 70,
      label: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _columns = getColumns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion flutter datagrid'),
      ),
      body: FutureBuilder<dynamic>(
        future: generateHerramientaList(),
        builder: (context, data) {
          return data.hasData
              ? SfDataGrid(
                  source: herramientaDataSource,
                  columns: _columns,
                  columnWidthMode: ColumnWidthMode.fill)
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: 0.8,
                  ),
                );
        },
      ),
    );
  }
}

class HerramientaDataSource extends DataGridSource {
  HerramientaDataSource(this.herramientas) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    _herramientaDataGridRows = herramientas
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'medida', value: e.medida),
              DataGridCell<String>(columnName: 'codigo', value: e.codigo),
              DataGridCell<int>(columnName: 'cantidad', value: e.cantidad),
              DataGridCell<DateTime>(
                  columnName: 'ultimaFecha', value: e.ultimaFecha),
              DataGridCell<String>(columnName: 'tipo', value: e.tipo),
              DataGridCell<bool>(columnName: 'isCarburo', value: e.isCarburo),
              DataGridCell<String>(columnName: 'bolaFlat', value: e.bolaFlat),
              DataGridCell<int>(columnName: 'filos', value: e.filos),
              DataGridCell<String>(
                  columnName: 'nombreHerramienta', value: e.nombreHerramienta),
            ],
          ),
        )
        .toList();
  }

  List<Herramienta> herramientas = [];

  List<DataGridRow> _herramientaDataGridRows = [];

  @override
  List<DataGridRow> get rows => _herramientaDataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  void updateDataGrid() {
    notifyListeners();
  }
}

class Herramienta {
  String medida;
  String codigo;
  int cantidad;
  DateTime ultimaFecha;
  String tipo;
  bool isCarburo;
  String bolaFlat;
  int filos;
  String nombreHerramienta;

  Herramienta({
    required this.medida,
    required this.codigo,
    required this.cantidad,
    required this.ultimaFecha,
    required this.tipo,
    required this.isCarburo,
    required this.bolaFlat,
    required this.filos,
    required this.nombreHerramienta,
  });

  factory Herramienta.fromJson(Map<String, dynamic> json) {
    return Herramienta(
      medida: json['medida'] as String,
      codigo: json['codigo'] as String,
      cantidad: int.parse(json['id']),
      ultimaFecha: DateTime.parse(json['ultimaFecha']),
      tipo: json['tipo'] as String,
      isCarburo: bool.parse(json['isCarburo']),
      bolaFlat: json['bolaFlat'] as String,
      filos: int.parse(json['filos']),
      nombreHerramienta: json['nombreHerramienta'] as String,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
