import 'package:appweather/functions/functions.dart';
import 'package:flutter/material.dart';

class AcordionCard extends StatelessWidget {
  final List forecastDay;
  const AcordionCard({
    super.key,
    required this.forecastDay,
  });

  @override
  Widget build(BuildContext context) {
    Image icon = Image.asset('lib/Icons/arrow.png', width: 25, height: 25);
    List tableList = [];
    for (var i in forecastDay) {
      tableList.add(
        Tables(
          time: getHour(i['time']),
          wind: i['windSpeed'],
          gust: i['windGust'],
          direction: i['windDirection'],
          icon: icon,
        ),
      );
    }

    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset('lib/Icons/wind.png'),
              ),
              const SizedBox(width: 10),
              const Text(
                'Actual Wind Speed',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  const Tables(),
                  // Map of the wind speed
                  for (var item in tableList) item,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Tables extends StatelessWidget {
  final String? time;
  final double? wind;
  final double? gust;
  final int? direction;
  final Image? icon;

  const Tables({
    Key? key,
    this.time,
    this.wind,
    this.gust,
    this.direction,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(228, 224, 222, 1),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            (time != null) ? Text(time!) : const Text('Time'),
            (gust != null) ? Text(gust!.toString()) : const Text('Gust'),
            (wind != null) ? Text(wind!.toString()) : const Text('Wind'),
            Row(
              children: [
                (direction != null)
                    ? Text(direction!.toString())
                    : const Text('Direction'),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(
                      (direction != null) ? (direction! % 360) / 360 : 0),
                  child: Container(
                    child: (icon != null) ? icon! : icon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
