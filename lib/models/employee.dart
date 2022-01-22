class Employee{
  late String fullName;
  late String phoneNumber;
  late String email;
  late String position;
  late double salary;

  Employee(
    this.fullName,
    this.phoneNumber,
    this.email,
    this.position,
    this.salary
  );

  Employee.empty();

}