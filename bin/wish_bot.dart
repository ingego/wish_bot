import 'package:wish_bot/wish_bot.dart';

void main(List<String> arguments) async {
  var bot = await Bot.init;
  bot.start();
  bot.randomGift();
}
