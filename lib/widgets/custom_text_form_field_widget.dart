import 'package:flutter/material.dart';
/// For creating customized form text fields
/// requires
/// [String] hint to show as hint text of the field
/// an[onChanged] VoidCallback function triggered when text is changed
/// a [validator] function triggered for validting the entered text
///
/// optional
/// [isDecimal] bool for setting keyboard type to number
/// [isPhoneNumber] bool for setting keyboard type to phonenumber
/// [initialValue] to set initial value of the field when first displayed
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
        required this.hint,
        required this.onChanged,
        required this.validator,
        this.isDecimal = false,
        this.isPhoneNumber = false,
        this.initialValue = ''})
      : super(key: key);

  final String hint;
  final void Function(String) onChanged;
  final String? Function(String?) validator;
  final bool isDecimal;
  final bool isPhoneNumber;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          hint,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            initialValue: initialValue,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
            validator: validator,
            keyboardType: isDecimal
                ? const TextInputType.numberWithOptions(
                decimal: true, signed: false)
                : isPhoneNumber
                ? TextInputType.phone
                : TextInputType.name,

            /// auto validate the text when the user interacts with the text field
            autovalidateMode: AutovalidateMode.onUserInteraction,

            /// set action next so that the user can click next on the keyboard
            /// to focus on the next field
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }
}
