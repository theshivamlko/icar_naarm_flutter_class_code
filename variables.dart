import 'dart:math';

void main() {
  int name = 100;
  int name2 = -10;

  print(name);
  print(name2);

  double pi = 3.14;
  double randomvalue = 3.14;

  print(pi);

  bool isBulbOn = true;
  bool isBulbOff = false;

  print(isBulbOn);
  print(isBulbOff);

  String word = "A";
  String statements = "Hello Everyone !";
  word = "B";
  word = "100";
  print(word);
  print(statements);

  final double salary = 100;
  print(salary);

  final String hello = "Hello";

  var number4 = 100;
  print(number4);

  dynamic number5 = 100.01;
  number5 = "Hello";

  print(number5);

  int number6 = 101;

  // 10%10 == rem
  // 10/10 == quot

  // if
  // if-else

  if (number6 % 2 == 0) {
    print("Is Even Number");
  } else {
    print("Is Odd Number");
  }

  // if-else if - else

  int marks = 30;

  if (marks > 90) {
    print("BEST");
  } else if (marks > 70 && marks < 90) {
    print("GOOD");
  } else if (marks > 60 && marks < 70) {
    print("AVERAGE");
  } else if (marks > 40 && marks < 60) {
    print("Passed");
  } else if (marks < 40) {
    print("Failed");
  }

  for (int i = 1; i <= 10; i = i + 1) {
    print("Hello ${i}");
  }
  print("End of Loop");

  int j = 1;
  while (j <= 5) {
    print("Hello while loop ${j}");
    j = j + 1;
  }
  print("End of While Loop");

  Student student1 = Student("John", 101, 85.5, true);
  Student student2 = Student("Doe", 102, 75.5, false);

  print("Student Name: ${student1.name}");
  print("Student Name: ${student2.name}");

  student1.display();
  student2.display();

  int sum = add(10, 20);
  print("sum: $sum");

  num result1 = pow(2, 6);
  print("result1: $result1");

  List<String> numberList = ["HYD", "LKO", "MUMB", "GUJ"];

  print("result1: ${numberList.length} ${numberList[0]} ${numberList[2]}");

  print("List:");
  for (int i = 0; i < numberList.length; i = i + 1) {
    print(numberList[i]);
  }

  numberList.insert(1, "Pune");
  numberList.remove(3);

  print("After adding at index 1:");
  for (int i = 0; i < numberList.length; i = i + 1) {
    print(numberList[i]);
  }

  List<int> numberList2 = [100, 34, 55, 0, 1];
  numberList2.sort();
  print(numberList2);
  print(numberList2.isEmpty);

  Map<String, String> map1 = {};
  Map<String, dynamic> map3 = {};
  map1["name"] = "John";

  print(map1);
  print(map1["name"]);

  Map<String, Student> student6 = {};

  student6["101"] = Student("Alice", 103, 90.0, true);
  student6["102"] = Student("Bob", 104, 80.0, false);
  print(student6["102"]?.name);
}

class Student {
  String name;
  int roll;
  double marks;
  bool isPassed;

  Student(this.name, this.roll, this.marks, this.isPassed);

  void display() {
    print("Name: $name, Roll: $roll, Marks: $marks, Passed: $isPassed");
  }
}

int add(int a, int b) {
  int result = a + b;
  return result;
}
