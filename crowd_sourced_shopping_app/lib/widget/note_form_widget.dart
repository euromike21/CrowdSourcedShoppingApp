import 'package:crowd_sourced_shopping_app/exports.dart';

class NoteFormWidget extends StatelessWidget {
  final String? title;
  final ValueChanged<String> onChangedTitle;

  const NoteFormWidget({
    Key? key,
    this.title = '',
    required this.onChangedTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          backgroundColor: Colors.lightBlue[50],
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter Item Name...',
          hintStyle: TextStyle(color: Colors.black),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The item name cannot be empty'
            : null,
        onChanged: onChangedTitle,
      );
}
