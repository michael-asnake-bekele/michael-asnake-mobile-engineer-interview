import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_engineer_interview/models/employee.dart';

/// For displaying employee list item data
///
/// Accepts
/// [employee] to populate employee data
///
/// [onDeleteTapped] a [VoidCallback] which is called when delete button is clicked
///
/// [onEditTapped] a [VoidCallback] which is called when edit button is clicked
///
/// [onTapped] a [VoidCallback] which is called when the list item is tapped
///
/// [disableGestures] a [bool] which is controls whether or not the listener callbacks are called.
/// created for disabling menu functionality it's set to false by default
class EmployeeListTile extends StatefulWidget {
  const EmployeeListTile({
    Key? key,
    required this.employee,
    required this.onDeleteTapped,
    required this.onEditTapped,
    required this.onTapped,
    this.disableGestures = false,
  }) : super(key: key);

  final Employee employee;
  final VoidCallback? onDeleteTapped;
  final VoidCallback? onEditTapped;
  final VoidCallback? onTapped;
  final bool disableGestures;

  @override
  State<EmployeeListTile> createState() => _EmployeeListTileState();
}

class _EmployeeListTileState extends State<EmployeeListTile> {
  bool isMenuVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8
      ),
      child: Material(
        child: InkWell(
          onLongPress: !widget.disableGestures?() {
            /// Toggles menu visibility
            setState(() {
              isMenuVisible = !isMenuVisible;
            });
          }:null,
          onTap: !widget.disableGestures?(){
            widget.onTapped!();
            /// hides menu
            setState(() {
              isMenuVisible = false;
            });
          }:null,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: 'https://www.w3schools.com/howto/img_avatar.png',
                      width: 110,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: SpinKitSpinningLines(
                          color: Colors.black,
                          size: 56,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      constraints: const BoxConstraints(minHeight: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.employee.fullName,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(widget.employee.position),
                          Text(widget.employee.phoneNumber),
                          Text(widget.employee.email),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: isMenuVisible ? 1 : 0,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 50,
                      color: const Color(0xcc000000),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed:
                              isMenuVisible ? widget.onEditTapped : null,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                          IconButton(
                            onPressed:
                            isMenuVisible ? widget.onDeleteTapped : null,
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleDelete() {}
}