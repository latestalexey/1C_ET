﻿// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ
// Процедура представляет обработчик события "Нажатие" кнопки
// "ОК" командной панели "ОсновныеДействияФормы".
// 
// Параметры:
//  Кнопка - <КнопкаКоманднойПанели>
//         - Кнопка, с которой связано данное событие (кнопка "ОК").
// 
&НаКлиенте
Процедура ЗаписатьИЗакрытьВыполнить()

	Параметры.ПараметрыНастройки.Добавить(Порт                      , "Порт");
	Параметры.ПараметрыНастройки.Добавить(Скорость                  , "Скорость");
	Параметры.ПараметрыНастройки.Добавить(Таймаут                   , "Таймаут");
	Параметры.ПараметрыНастройки.Добавить(ПарольПользователя        , "ПарольПользователя");
	Параметры.ПараметрыНастройки.Добавить(ПарольАдминистратора      , "ПарольАдминистратора");
	Параметры.ПараметрыНастройки.Добавить(ОтменятьЧекПриПодключении , "ОтменятьЧекПриПодключении");
	Параметры.ПараметрыНастройки.Добавить(НаименованиеОплаты1       , "НаименованиеОплаты1");
	Параметры.ПараметрыНастройки.Добавить(НаименованиеОплаты2       , "НаименованиеОплаты2");
	Параметры.ПараметрыНастройки.Добавить(НомерСекции               , "НомерСекции");
	Параметры.ПараметрыНастройки.Добавить(КодСимволаЧастичногоОтреза, "КодСимволаЧастичногоОтреза");
	Параметры.ПараметрыНастройки.Добавить(ЖурналОперацийДрайвера    , "ЖурналОперацийДрайвера");
	Параметры.ПараметрыНастройки.Добавить(Модель                    , "Модель");

	ОчиститьСообщения();
	Закрыть(КодВозвратаДиалога.ОК);

КонецПроцедуры

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
&НаКлиенте
Процедура ОбновитьИнформациюОДрайвере()

	ВходныеПараметры  = Неопределено;
	ВыходныеПараметры = Неопределено;

	времПараметрыУстройства = Новый Структура();
	времПараметрыУстройства.Вставить("Порт"                      , Порт);
	времПараметрыУстройства.Вставить("Скорость"                  , Скорость);
	времПараметрыУстройства.Вставить("Таймаут"                   , Таймаут);
	времПараметрыУстройства.Вставить("ПарольПользователя"        , ПарольПользователя);
	времПараметрыУстройства.Вставить("ПарольАдминистратора"      , ПарольАдминистратора);
	времПараметрыУстройства.Вставить("ОтменятьЧекПриПодключении" , ОтменятьЧекПриПодключении);
	времПараметрыУстройства.Вставить("НаименованиеОплаты1"       , НаименованиеОплаты1);
	времПараметрыУстройства.Вставить("НаименованиеОплаты2"       , НаименованиеОплаты2);
	времПараметрыУстройства.Вставить("НомерСекции"               , НомерСекции);
	времПараметрыУстройства.Вставить("КодСимволаЧастичногоОтреза", КодСимволаЧастичногоОтреза);
	времПараметрыУстройства.Вставить("ЖурналОперацийДрайвера"    , ЖурналОперацийДрайвера);
	времПараметрыУстройства.Вставить("Модель"                    , Модель);

	Если МенеджерОборудованияКлиент.ВыполнитьДополнительнуюКоманду("ПолучитьВерсиюДрайвера",
	                                                               ВходныеПараметры,
	                                                               ВыходныеПараметры,
	                                                               Идентификатор,
	                                                               времПараметрыУстройства) Тогда
		Драйвер = ВыходныеПараметры[0];
		Версия  = ВыходныеПараметры[1];
	Иначе
		Драйвер = ВыходныеПараметры[2];
		Версия  = НСтр("ru='Не определена'");
	КонецЕсли;

	Элементы.Драйвер.ЦветТекста = ?(Драйвер = НСтр("ru='Не установлен'"), ЦветОшибки, ЦветТекста);
	Элементы.Версия.ЦветТекста  = ?(Версия  = НСтр("ru='Не определена'"), ЦветОшибки, ЦветТекста);

	Элементы.УстановитьДрайвер.Доступность = Не (Драйвер = НСтр("ru='Установлен'"));

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбновитьИнформациюОДрайвере();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест"
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	Параметры.Свойство("Идентификатор", Идентификатор);
	Заголовок = НСтр("ru='ФР'") + " """ + Строка(Идентификатор) + """";

	ЦветТекста = ЦветаСтиля.ЦветТекстаФормы;
	ЦветОшибки = ЦветаСтиля.ЦветОтрицательногоЧисла;

	СпПорт = Элементы.Порт.СписокВыбора;
	Индекс = Неопределено;
	Для Индекс = 1 По 63 Цикл
		СпПорт.Добавить(Индекс, "COM" + СокрЛП(Индекс));
	КонецЦикла;

	СпСкорость = Элементы.Скорость.СписокВыбора;
	СпСкорость.Добавить(2400,   "2400");
	СпСкорость.Добавить(4800,   "4800");
	СпСкорость.Добавить(9600,   "9600");
	СпСкорость.Добавить(19200,  "19200");
	СпСкорость.Добавить(38400,  "38400");
	СпСкорость.Добавить(57600,  "57600");
	СпСкорость.Добавить(115200, "115200");

	времПорт                       = Неопределено;
	времСкорость                   = Неопределено;
	времТаймаут                    = Неопределено;
	времПарольПользователя         = Неопределено;
	времПарольАдминистратора       = Неопределено;
	времОтменятьЧекПриПодключении  = Неопределено;
	времНаименованиеОплаты1        = Неопределено;
	времНаименованиеОплаты2        = Неопределено;
	времНомерСекции                = Неопределено;
	времКодСимволаЧастичногоОтреза = Неопределено;
	времЖурналОперацийДрайвера     = Неопределено;
	времМодель                     = Неопределено;

	Параметры.Свойство("Порт"                      , времПорт);
	Параметры.Свойство("Скорость"                  , времСкорость);
	Параметры.Свойство("Таймаут"                   , времТаймаут);
	Параметры.Свойство("ПарольПользователя"        , времПарольПользователя);
	Параметры.Свойство("ПарольАдминистратора"      , времПарольАдминистратора);
	Параметры.Свойство("ОтменятьЧекПриПодключении" , времОтменятьЧекПриПодключении);
	Параметры.Свойство("НаименованиеОплаты1"       , времНаименованиеОплаты1);
	Параметры.Свойство("НаименованиеОплаты2"       , времНаименованиеОплаты2);
	Параметры.Свойство("НомерСекции"               , времНомерСекции);
	Параметры.Свойство("КодСимволаЧастичногоОтреза", времКодСимволаЧастичногоОтреза);
	Параметры.Свойство("ЖурналОперацийДрайвера"    , времЖурналОперацийДрайвера);
	Параметры.Свойство("Модель"                    , времМодель);

	Порт                       = ?(времПорт                       = Неопределено,      1, времПорт);
	Скорость                   = ?(времСкорость                   = Неопределено, 115200, времСкорость);
	Таймаут                    = ?(времТаймаут                    = Неопределено,    150, времТаймаут);
	ПарольПользователя         = ?(времПарольПользователя         = Неопределено,    "1", времПарольПользователя);
	ПарольАдминистратора       = ?(времПарольАдминистратора       = Неопределено,   "30", времПарольАдминистратора);
	ОтменятьЧекПриПодключении  = ?(времОтменятьЧекПриПодключении  = Неопределено,   ЛОЖЬ, времОтменятьЧекПриПодключении);
	НаименованиеОплаты1        = ?(времНаименованиеОплаты1        = Неопределено,     "", времНаименованиеОплаты1);
	НаименованиеОплаты2        = ?(времНаименованиеОплаты2        = Неопределено,     "", времНаименованиеОплаты2);
	НомерСекции                = ?(времНомерСекции                = Неопределено,      0, времНомерСекции);
	КодСимволаЧастичногоОтреза = ?(времКодСимволаЧастичногоОтреза = Неопределено,     22, времКодСимволаЧастичногоОтреза);
	ЖурналОперацийДрайвера     = ?(времЖурналОперацийДрайвера     = Неопределено,   ЛОЖЬ, времЖурналОперацийДрайвера);
	Модель                     = ?(времМодель                     = Неопределено, Элементы.Модель.СписокВыбора[0], времМодель);

	Элементы.ТестУстройства.Видимость    = (ПараметрыСеанса.РабочееМестоКлиента
	                                        = Идентификатор.РабочееМесто);
	Элементы.УстановитьДрайвер.Видимость = (ПараметрыСеанса.РабочееМестоКлиента
	                                        = Идентификатор.РабочееМесто);

КонецПроцедуры

&НаКлиенте
Процедура ТестУстройства(Команда)

	РезультатТеста    = Неопределено;

	ВходныеПараметры  = Неопределено;
	ВыходныеПараметры = Неопределено;

	времПараметрыУстройства = Новый Структура();
	времПараметрыУстройства.Вставить("Порт"                      , Порт);
	времПараметрыУстройства.Вставить("Скорость"                  , Скорость);
	времПараметрыУстройства.Вставить("Таймаут"                   , Таймаут);
	времПараметрыУстройства.Вставить("ПарольПользователя"        , ПарольПользователя);
	времПараметрыУстройства.Вставить("ПарольАдминистратора"      , ПарольАдминистратора);
	времПараметрыУстройства.Вставить("ОтменятьЧекПриПодключении" , ОтменятьЧекПриПодключении);
	времПараметрыУстройства.Вставить("НаименованиеОплаты1"       , НаименованиеОплаты1);
	времПараметрыУстройства.Вставить("НаименованиеОплаты2"       , НаименованиеОплаты2);
	времПараметрыУстройства.Вставить("НомерСекции"               , НомерСекции);
	времПараметрыУстройства.Вставить("КодСимволаЧастичногоОтреза", КодСимволаЧастичногоОтреза);
	времПараметрыУстройства.Вставить("ЖурналОперацийДрайвера"    , ЖурналОперацийДрайвера);
	времПараметрыУстройства.Вставить("Модель"                    , Модель);

	Результат = МенеджерОборудованияКлиент.ВыполнитьДополнительнуюКоманду("CheckHealth",
	                                                                      ВходныеПараметры,
	                                                                      ВыходныеПараметры,
	                                                                      Идентификатор,
	                                                                      времПараметрыУстройства);

	ДополнительноеОписание = ?(ТипЗнч(ВыходныеПараметры) = Тип("Массив")
	                           И ВыходныеПараметры.Количество(),
	                           НСтр("ru = 'Дополнительное описание:'") + " " + ВыходныеПараметры[1],
	                           "");
	Если Результат Тогда
		ТекстСообщения = НСтр("ru = 'Тест успешно выполнен.%ПереводСтроки%%ДополнительноеОписание%'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ПереводСтроки%", ?(ПустаяСтрока(ДополнительноеОписание),
		                                                                  "",
		                                                                  Символы.ПС));
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ДополнительноеОписание%", ?(ПустаяСтрока(ДополнительноеОписание),
		                                                                           "",
		                                                                           ДополнительноеОписание));
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
	Иначе
		ТекстСообщения = НСтр("ru = 'Тест не пройден.%ПереводСтроки%%ДополнительноеОписание%'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ПереводСтроки%", ?(ПустаяСтрока(ДополнительноеОписание),
		                                                                  "",
		                                                                  Символы.ПС));
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ДополнительноеОписание%", ?(ПустаяСтрока(ДополнительноеОписание),
		                                                                           "",
		                                                                           ДополнительноеОписание));
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьДрайвер(Команда)

	МенеджерОборудованияКлиент.УстановитьДрайвер(Идентификатор);

	ОбновитьИнформациюОДрайвере();

КонецПроцедуры



