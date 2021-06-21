// To parse this JSON data, do
//
//     final testData = testDataFromJson(jsonString);

import 'dart:convert';

List<TestData> testDataFromJson(String str) => List<TestData>.from(json.decode(str).map((x) => TestData.fromJson(x)));

String testDataToJson(List<TestData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestData {
    TestData({
      required  this.name,
      required  this.age,
    });

    String name;
    String age;

    factory TestData.fromJson(Map<String, dynamic> json) => TestData(
        name: json["name"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
    };
}
