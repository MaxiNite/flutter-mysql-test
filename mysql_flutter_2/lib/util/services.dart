import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mysql_flutter_2/model/employee.dart';

class Services {
  static const ROOT = 'http://localhost/EmployeesDB/employee_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELTE_EMP_ACTION = 'DEL_EMP';

  // Method to create the table Employees
  static Future<String> createTable() async {
    try {
      // Add the parameters to pass to the request
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'ERROR';
      }
    } catch (e) {
      return 'ERROR';
    }
  }

  // Method to get all Employees
  static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Get Employees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        List<Employee> list = [];
        return list;
      }
    } catch (e) {
      List<Employee> list = [];
      return list; // Return an empty list on exception/error
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // Method to add an Employee to the database
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map["action"] = _ADD_EMP_ACTION;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Add Employee response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      return 'ERROR';
    }
  }

  // Method to update an Employee
  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map["action"] = _UPDATE_EMP_ACTION;
      map["emp_id"] = empId;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Update Employee response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      return 'ERROR';
    }
  }

  // Method to delete an Employee
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map["action"] = _DELTE_EMP_ACTION;
      map["emp_id"] = empId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Delete Employee response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'Error';
      }
    } catch (e) {
      return 'ERROR';
    }
  }
}
