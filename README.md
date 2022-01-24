## Dukka Mobile Engineer Interview Exam Project submitted by Michael Asnake
---

# Overview
- This application allows admins to keep employee data by entering employee details. The employee list is persisted (using the [hive](https://docs.hivedb.dev/) package) so the admin can view previously saved employees after restarting the app.

- The employee list is saved in a hive box called 'employees_box' which is first opened in the main fuction of the app and is accessed in employeeListProvider which is a riverpod provider that can be accessed anywhere in the application

- I have implemented the bonus feature which alows admins to view employee loan records (mock data) in the employee details page

- I have also implemented my own bonus feature which allows admins to edit employee data instead of displaying "feature is not available at the moment" message that was specified in the instruction

- I added a splash screen to display the name of the app and a loading indicator which is shown for a constant duration of two seconds

# Features
## Save Employees
- The admin can enter employee data and save it persistently
## View Employee List
- The admin can view all employees previously saved in the app 

## View Employee Details (Bonus)
- Tapping on employee in the employee list will display the employee details page

- It displays random fake loan data along with the employee name, position, phonenumber and email

## Editing and Deleting Employee (Bonus)
- Long pressing on an employee in the employee list page will 
display the edit/delete menu

- Tapping on the delete icon will delete the employee after showing a confirmation dialog

- Tapping on the edit icon will take the admin to the edit employee profile page (which reuses the Create Employee Page as opposed to being a new page)

## Splash screen (Additional Feature)
- added to display the branding

## Generate random employee list (Utility feature)
- Added for seeding random employee data to the employee hive box, which will help in testing editing and deleting instead of having to manually entering data and saving employees

- By opening the Drawer in the employee list page you can find the  Generate Random Employee List button which when clicked will generate random employee objects and saves them to the hive box

# External Dependencies
- [hive,  hive_flutter, hive_generator and build_runner](https://docs.hivedb.dev/) for persistent storage

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) for state management

- [google_fonts](https://pub.dev/packages/google_fonts) 
for changing app font family, 

- [sprintf](https://pub.dev/packages/sprintf) for string formating 

- [basic_utils](https://pub.dev/packages/basic_utils) for email validation

- [faker](https://pub.dev/packages/faker) for generating fake employee data

- [cached_network_image](https://pub.dev/packages/cached_network_image) for caching fake employee image from fetched from network

- [flutter_spinkit](https://pub.dev/packages/flutter_spinkit) for creating loading indicators in the splash page and for loading images

<br/>
<br/>

---
# Please Note
## You will find a the built apk int the root folder with the name of app-release.apk