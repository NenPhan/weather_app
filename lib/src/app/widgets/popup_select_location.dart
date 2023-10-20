import 'package:flutter/material.dart';
import 'package:weather_app/core/config/my_theme.dart';
import 'package:weather_app/core/utils/classes/storage.dart';
import 'package:weather_app/core/widgets/my_text.dart';
import 'package:weather_app/src/app/widgets/rounded_button.dart';
import 'package:weather_app/src/app/widgets/spacing_widget.dart';

class SelectLocationPopup extends StatelessWidget {
  const SelectLocationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SpacingColumn(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: MyText(
                'Location',
                style: textTheme(context).titleMedium,
              ),
            ),
            Form(
              key: formKey,
              child: TextFormField(
                  controller: textEditingController,
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Please input a location';
                    }
                    return null;
                  },
                  style: textTheme(context).bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Input a location...',
                    hintStyle: textTheme(context).bodyMedium,
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
            ),
            RoundedButton(
              text: 'Submit',
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.pop(context,
                      /*location string */ textEditingController.text.trim());
                }
              },
            ),
            const MyText('History'),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(.1)),
                child: Builder(builder: (context) {
                  var data = Storage().getSavedLocations();
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context, data[index].split(', ').last);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide())),
                            child: Text(data[index]),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
