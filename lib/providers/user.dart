import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String? id;
  late final String name;
  final String email;
  final String password;
  final String gender;
  final String country;

  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.gender,
      required this.country});

  toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'country': country,
    };
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        gender: snapshot.get('gender'),
        email: snapshot.get('email'),
        name: snapshot.get('name'),
        password: snapshot.get('password'),
        country: snapshot.get('country'));
  }
  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return User(
      id: document.id,
      name: data['name'],
      gender: data['gender'],
      email: data['email'],
      password: data['password'],
      country: data['country'],
    );
  }
}
