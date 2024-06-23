import 'package:adhan_dart/adhan_dart.dart';

getprayerhr() {
  DateTime date = (DateTime.now());
  Coordinates coordinates =
      Coordinates(53.506516477842055, -2.2445736729918266);
  CalculationParameters params = CalculationMethod.UmmAlQura();
  params.madhab = Madhab.Shafi;
  var prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
  int vs = 0;
  if (prayerTimes.currentPrayer(date: date) == 'fajr') {
    vs = prayerTimes.fajrafter!.hour;
  }
  if (prayerTimes.currentPrayer(date: date) == 'dhuhr') {
    vs = prayerTimes.dhuhr!.hour;
  }
  if (prayerTimes.currentPrayer(date: date) == 'asr') {
    vs = prayerTimes.asr!.hour;
  }
  if (prayerTimes.currentPrayer(date: date) == 'maghrib') {
    vs = prayerTimes.maghrib!.hour;
  }
  if (prayerTimes.currentPrayer(date: date) == 'isha') {
    vs = prayerTimes.ishabefore!.hour;
  }

  ;
  return vs;
}

getprayermin() {
  DateTime date = (DateTime.now());
  Coordinates coordinates =
      Coordinates(53.506516477842055, -2.2445736729918266);
  CalculationParameters params = CalculationMethod.UmmAlQura();
  params.madhab = Madhab.Shafi;
  var prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
  int vs = 0;
  if (prayerTimes.currentPrayer(date: date) == 'fajr') {
    vs = prayerTimes.fajrafter!.minute;
  }
  if (prayerTimes.currentPrayer(date: date) == 'dhuhr') {
    vs = prayerTimes.dhuhr!.minute;
  }
  if (prayerTimes.currentPrayer(date: date) == 'asr') {
    vs = prayerTimes.asr!.minute;
  }
  if (prayerTimes.currentPrayer(date: date) == 'maghrib') {
    vs = prayerTimes.maghrib!.minute;
  }
  if (prayerTimes.currentPrayer(date: date) == 'isha') {
    vs = prayerTimes.ishabefore!.minute;
  }

  ;
  return vs;
}
