// ignore_for_file: import_of_legacy_library_into_null_safe

class AppVariables {
  static const String empty = '';
  static const List months = [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря'
  ];
  static const List months_short = [
    'янв',
    'фев',
    'мар',
    'апр',
    'мая',
    'июн',
    'июл',
    'авг',
    'сен',
    'окт',
    'ноя',
    'дек'
  ];
  static const List<String> categories = [
    CoreConstant.all,
    'Культура',
    'Спорт',
    'Бизнес',
    'Образование',
    'Туризм',
    'Детям',
    'Разные',
  ];
  static const List<String> formats = [
    FormatConstant.offline,
    FormatConstant.online
  ];

  static const List<String> ticketTypes = [
    TicketTypeConstant.standart,
    TicketTypeConstant.vip,
    TicketTypeConstant.adult,
    TicketTypeConstant.student,
    TicketTypeConstant.child
  ];

  static const List<String> eventType = [
    EventTypeConstant.open,
    EventTypeConstant.closed
  ];
  static const List<String> eventPaymentType = [
    EventPaymentTypeConstant.online,
    EventPaymentTypeConstant.withdrawal
  ];

  static const List<String> languages = ['Казахский язык', 'Русский язык'];
}

class CoreConstant {
  static const zeroDouble = 0.0;
  static const empty = '';
  static const all = 'Все';
  static const negative = -1;
  static const zeroInt = 0;
}

class FormatConstant {
  static const offline = 'Оффлайн';
  static const online = 'Онлайн';
}

class EventTypeConstant {
  static const open = 'Открытое мероприятие';
  static const closed = 'Закрытое мероприятие';
}

class EventPaymentTypeConstant {
  static const online = 'Онлайн';
  static const withdrawal = 'Наличными';
}

class TicketTypeConstant {
  static const standart = 'Стандартный';
  static const vip = 'Вип';
  static const adult = 'Взрослый';
  static const student = 'Студенческий';
  static const child = 'Детский';
}
