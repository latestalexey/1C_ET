﻿// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиентеНаСервереБезКонтекста
Функция КонецПериода(Дата)

	Возврат КонецДня(КонецМесяца(Дата));

КонецФункции

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ
&НаКлиенте
Процедура ОК(Команда)

	РезультатВыбора = Новый Структура("ПериодДляРегистровНакопления, ПериодДляРегистровБухгалтерии");
	ЗаполнитьЗначенияСвойств(РезультатВыбора, ЭтаФорма);
	ОповеститьОВыборе(РезультатВыбора);

КонецПроцедуры

&НаКлиенте
Процедура ПериодДляРегистровБухгалтерииПриИзменении(Элемент)

	ПериодДляРегистровБухгалтерии = КонецПериода(ПериодДляРегистровБухгалтерии);

КонецПроцедуры

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ
&НаКлиенте
Процедура ПериодДляРегистровНакопленияПриИзменении(Элемент)

	ПериодДляРегистровНакопления = КонецПериода(ПериодДляРегистровНакопления);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

	ПериодДляРегистровНакопления = КонецПериода(ДобавитьМесяц(ТекущаяДатаСеанса(), -1));
	ПериодДляРегистровБухгалтерии = КонецПериода(ТекущаяДатаСеанса());
	Элементы.ПериодДляРегистровБухгалтерии.Доступность  = Параметры.РегБухгалтерии;
	Элементы.ПериодДляРегистровНакопления.Доступность = Параметры.РегНакопления;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
