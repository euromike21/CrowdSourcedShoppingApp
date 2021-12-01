import 'package:crowd_sourced_shopping_app/exports.dart';

Widget storePriceRow(int index) => Container(
      alignment: Alignment.centerLeft,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Store ${index}',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '\$ ${index}.99',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );

Widget priceBox() => SizedBox(
      height: 300,
      width: 1000,
      child: Container(
          color: Color(0xFFEAEAEA),
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) =>
                  storePriceRow(index),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: 15)),
    );
