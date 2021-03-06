﻿// sza140104-0216 :
// sza131010-1842

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)

	Если ОбщийМодульПовтор.ВывестиНаименованияНаДругомЯзыке() Тогда
		ВозможноеПредставление = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(Данные.Ссылка, , ИСТИНА);
		Если НЕ ВозможноеПредставление = Неопределено Тогда
			Представление = ВозможноеПредставление;
			СтандартнаяОбработка = ЛОЖЬ;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура Печать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "Сотрудник" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();
	СсылкаНаОбъектПечати = Ссылка[0];
	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);

	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Справочники.Сотрудники.ПолучитьМакет("Печать");
		Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ Сотрудники.Адрес,
		|	Сотрудники.ДанныеПаспорта,
		|	Сотрудники.ДатаРождения,
		|	ВЫРАЗИТЬ(Сотрудники.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	Сотрудники.Наименование,
		|	Сотрудники.Телефон,
		|	Сотрудники.ЭлектроннаяПочта,
		|	Сотрудники.РасчетЗарплаты.(
		|		НомерСтроки,
		|		ВидНачисления,
		|		ДатаНачала,
		|		ДатаОкончания,
		|		Размер,
		|		Валюта,
		|		Количество
		|	),
		|	Сотрудники.Должность,
		|	Сотрудники.Телефон2,
		|	Сотрудники.Телефон3,
		|	Сотрудники.Телефон4,
		|	Сотрудники.ОКПО,
		|	Сотрудники.ИНН,
		|	Сотрудники.Телефон5
		|ИЗ Справочник.Сотрудники КАК Сотрудники
		|ГДЕ Сотрудники.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ЭлементСправочника = Ссылка;
		ОбластьЗаголовок 			= Макет.ПолучитьОбласть("Заголовок");
		Шапка 						= Макет.ПолучитьОбласть("Шапка");
		ОбластьРасчетЗарплатыШапка 	= Макет.ПолучитьОбласть("РасчетЗарплатыШапка");
		ОбластьРасчетЗарплаты 		= Макет.ПолучитьОбласть("РасчетЗарплаты");
		Подвал 						= Макет.ПолучитьОбласть("Подвал");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Шапка.Параметры.Заполнить(Выборка);
			ПолныйНомерТелефона = ОбщийМодульСервер.СоставитьТелефон(ЭлементСправочника, ИСТИНА);
			ОКПОТекст = "";
			ОКПОЗначение = "";

			Если НЕ ПустаяСтрока(ЭлементСправочника.ОКПО) Тогда
				ОКПОТекст 	 = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("ОКПО");
				ОКПОЗначение = ЭлементСправочника.ОКПО;
			КонецЕсли;

			Если НЕ ПустаяСтрока(ЭлементСправочника.ИНН) Тогда
				ОКПОТекст 	 = ?(ОКПОТекст = "", "", ", ") + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("ИНН");
				ОКПОЗначение = ?(ОКПОЗначение = "", "", ", ") + ЭлементСправочника.ИНН;
			КонецЕсли;

			Шапка.Параметры.ОКПОТекст = ОКПОТекст;
			Шапка.Параметры.ОКПОЗначение = ОКПОЗначение;
			Шапка.Параметры.Телефон = ПолныйНомерТелефона;
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьРасчетЗарплатыШапка);
			ДокументДляПечати.Вывести(ОбластьРасчетЗарплатыШапка);
			ВыборкаРасчетЗарплаты = Выборка.РасчетЗарплаты.Выбрать();

			Пока ВыборкаРасчетЗарплаты.Следующий() Цикл
				ОбластьРасчетЗарплаты.Параметры.Заполнить(ВыборкаРасчетЗарплаты);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьРасчетЗарплаты);
				ДокументДляПечати.Вывести(ОбластьРасчетЗарплаты, ВыборкаРасчетЗарплаты.Уровень());

			КонецЦикла;

			Подвал.Параметры.Заполнить(Выборка);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Подвал);
			ДокументДляПечати.Вывести(Подвал);
			ВставлятьРазделительСтраниц = ИСТИНА;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
