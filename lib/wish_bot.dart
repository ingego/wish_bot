import 'dart:math';

import 'package:logger/logger.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:wish_bot/api.dart';
import 'package:wish_bot/config.dart';

class Bot with Api {
  final TeleDart _teleDart;
  Bot(this._teleDart);
  static Future<Bot> get init async {
    final username = (await Telegram(apiKey).getMe()).username;
    var tel = TeleDart(apiKey, Event(username ?? ""));
    tel.start();
    var bot = Bot(tel);
    await bot.initApi();
    return bot;
  }

  void _initCommand(String command, void Function(TeleDartMessage msg) action) {
    _teleDart.onCommand(command).listen((event) => action(event));
  }

  void _initMessage(String msg, void Function(TeleDartMessage msg) action) {
    _teleDart.onMessage(keyword: msg).listen((event) => action(event));
  }

  void start() async {
    _initCommand("start", (msg) async {
      await msg.reply(
        "Добрый день, команды которые сейчас достпуны:\n\n /random",
      );
    });
    _teleDart.onCallbackQuery().listen((event) {
      Logger().d(event.data);
    });
  }

  void randomGift() {
    _initCommand("random", (msg) {
      var random = titleNg.split("\n");
      var re = Random.secure().nextInt(random.length);
      msg.reply(random[re]);
    });
  }
}

const titleNg = '''
С наступающим Новым годом! 
С наступающим Новым годом, желаю чтобы этот год оказался с меньшими потрясениями, чем этот!
С наступающим Новым годом, желаю чтобы он был намного продуктивнее предыдущего!
Поздравляю с наступающим Новым годом! Всего наилучшего! 
С Новым годом, желаю успехов в новом году!! 
 С днем учителя! Спасибо за все, что Вы для меня сделали
 С днем учителя! Благодарю Вас за все
 С днем учителя! Спасибо за все Ваши старания
 С днем учителя! 
 С праздником 8 марта
 Поздравляю с 8 марта и желаю светиться и светить
 Поздравляю с этим прекрасным днем
 Поздравляю с 8 марта. Продолжайте делать этот мир прекраснее
 Поздравляю с тем, что еще на один год постарел
 Поздравляю с тем, что еще на один год постарела
 Поздравляю с днем рождения. Твои желания-мои пожелания
 Поздравляю с днем рождения 🎉 
 Поздравляю с днем рождения. Желаю счастья в личной жизни
 Поздравляю с днем рождения. Желаю осознанности и счастья 
 Поздравляю с днем рождения. Желаю настоящего счастья и крепкого здоровья 
 С днем рождения! Желаю личностного роста и достижения всех целей 
 С днем рождения! Желаю чтобы каждый день приносил счастье и радость ''';
