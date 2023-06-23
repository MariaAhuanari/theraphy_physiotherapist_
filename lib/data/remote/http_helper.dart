import 'dart:convert';
import 'dart:io';

import 'package:theraphy_physiotherapist_app/data/model/patient.dart';
import 'package:theraphy_physiotherapist_app/data/model/physiotherapist.dart';
import 'package:theraphy_physiotherapist_app/data/model/user.dart';
import 'package:theraphy_physiotherapist_app/data/model/treatment.dart';
import 'package:theraphy_physiotherapist_app/data/model/appointment.dart';



import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlBase =
      'https://backendproyectotheraphy-production-5698.up.railway.app/api/v1';

  /*Future<List<Physiotherapist>?> getPhysiotherapistById(int physiotherapistId) async {
    http.Response response = await http.get(Uri.parse(urlBase + physiotherapistId.toString()));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> physiotherapistsMap = jsonResponse[''];
      final List<Physiotherapist> pysiotherapists = physiotherapistsMap.map((e) => Physiotherapist.fromJson(e)).toList();
      return pysiotherapists;
    } else {
      return null;
    }     
  }*/

Future<Physiotherapist?> getPhysiotherapistById(int physiotherapistId) async {
  const String endpoint = '/physiotherapists';
  final String url = '$urlBase$endpoint/$physiotherapistId';

  http.Response response = await http.get(Uri.parse(url));

  //http.Response response = await http.get(Uri.parse('$urlBase/$physiotherapistId'));

  if (response.statusCode == HttpStatus.ok) {
    final jsonResponse = json.decode(response.body);
    final Physiotherapist physiotherapist = Physiotherapist.fromJson(jsonResponse);
    /*final Map<String, dynamic> physiotherapistMap = jsonResponse['physiotherapist'];
    final Physiotherapist physiotherapist = Physiotherapist.fromJson(physiotherapistMap);*/
    return physiotherapist;
  } else {
    return null;
  }
}

Future<List<Patient>?> getPatients() async {
    const String endpoint = '/patients';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));
  
    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> patientMap = jsonResponse['content'];
      final List<Patient> patients = patientMap.map((map) => Patient.fromJson(map)).toList();
      return patients;
    } else {
      return null;
    }
}

Future<List<Appointment>?> getAppointments() async {
    const String endpoint = '/appointments';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> appointmentsMap = jsonResponse['content'];
      final List<Appointment> appointments = appointmentsMap.map((map) => Appointment.fromJson(map)).toList();
      return appointments;
    } else {
      return null;
    }
}

Future<List<Treatment>?> getTreatments() async {
    const String endpoint = '/treatments';
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final List<dynamic> treatmentsMap = jsonResponse['content'];
      final List<Treatment> treatments = treatmentsMap.map((map) => Treatment.fromJson(map)).toList();
      return treatments;
    } else {
      return null;
    }
}

  

}

  Future<List<Physiotherapist>?> getPhysiotherapist() async {
    const String endpoint = '/physiotherapists'; // Ruta del endpoint específico
    final String url = '$urlBase$endpoint';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List physiotherapistMap = jsonResponse['content'];
      final List<Physiotherapist> physiotherapists = physiotherapistMap
          .map((map) => Physiotherapist.fromJson(map))
          .toList();
      return physiotherapists;
    } else {
      return null;
    }
  }

  Future<List<User>?> getUsers() async {
    const String endpoint = '/users'; // Ruta del endpoint específico
    final String url = '$urlBase$endpoint'; // URL completo

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final List userMap = jsonResponse['content'];
      final List<User> users =
          userMap.map((map) => User.fromJson(map)).toList();
      return users;
    } else {
      return null;
    }
  }

  void createUser(int id, String email, String password, String type) async {
    final user = User(id: id, email: email, password: password, type: type);

    const String endpoint = '/users'; // Ruta del endpoint específico
    final String url = '$urlBase$endpoint'; // URL completo

    final result = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));

    if (result.statusCode == 200) {
      // Solicitud exitosa
      print('Solicitud exitosa');
      print('Respuesta del servidor: ${result.body}');
    } else {
      // Solicitud fallida
      print('Solicitud fallida');
      print('Código de error: ${result.statusCode}');
      print(email + " " + password + " " + type);
    }
  }

  void createPatient(int id, String firstName, String lastname, int age, String photoUrl, String birthdayDate,
  int appointmentQuantity, String email, int userId) async {
    final user = Patient(id: id, firstName: firstName, lastName: lastname, age: age, photoUrl: photoUrl,
    birthdayDate: birthdayDate, appointmentQuantity: appointmentQuantity, email: email, userId: userId);

    const String endpoint = '/patients'; // Ruta del endpoint específico
    final String url = '$urlBase$endpoint'; // URL completo

    final result = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));

    if (result.statusCode == 200) {
      // Solicitud exitosa
      print('Solicitud exitosa');
      print('Respuesta del servidor: ${result.body}');
    } else {
      // Solicitud fallida
      print('Solicitud fallida');
      print('Código de error: ${result.statusCode}');
      
    }
  }

  void createPhysiotherapist(int id, String firstName, String paternalSurname, String maternalSurname,
  String specialization, int age, String location, String photoUrl, String birthdayDate,
  int consultationsQuantity, String email, double rating, int userId) async {
    final user = Physiotherapist(id: id, firstName: firstName, paternalSurname: paternalSurname, maternalSurname: maternalSurname,
    specialization: specialization, age: age, location: location, photoUrl: photoUrl, birthdayDate: birthdayDate,
    consultationsQuantity: consultationsQuantity, email: email, rating: rating, userId: userId);

    const String endpoint = '/physiotherapists'; // Ruta del endpoint específico
    final String url = '$urlBase$endpoint'; // URL completo

    final result = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));

    if (result.statusCode == 200) {
      // Solicitud exitosa
      print('Solicitud exitosa');
      print('Respuesta del servidor: ${result.body}');
    } else {
      // Solicitud fallida
      print('Solicitud fallida');
      print('Código de error: ${result.statusCode}');
      //print(email + " " + password + " " + type);
    }
  }
}
