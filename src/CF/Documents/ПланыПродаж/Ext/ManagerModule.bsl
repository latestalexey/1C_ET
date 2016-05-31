﻿// sza131117-0253
// sza131003-2249 :

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура Печать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "ДокПланПродаж" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;

	ДокументДляПечати.Очистить();
	СсылкаНаОбъектПечати = Ссылка[0];
	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);

	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Документы.ПланыПродаж.ПолучитьМакет("Печать");

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	ПланыПродаж.Дата,
		|	ПланыПродаж.ДатаНачала,
		|	ПланыПродаж.ДатаОкончания,
		|	ПланыПродаж.ДатаРедакции,
		|	ВЫРАЗИТЬ(ПланыПродаж.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	ПланыПродаж.Номер,
		|	ПланыПродаж.Ответственный,
		|	ПланыПродаж.ПланНеАктуален,
		|	ПланыПродаж.ТовараВКоличестве,
		|	ПланыПродаж.ТовараНаСумму,
		|	ПланыПродаж.Товары.(
		|		НомерСтроки,
		|		НоменклатураИлиГруппа,
		|		Количество,
		|		Сумма
		|	),
		|	ПланыПродаж.Склад,
		|	ПланыПродаж.Регион
		|ИЗ Документ.ПланыПродаж КАК ПланыПродаж
		|ГДЕ ПланыПродаж.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		Шапка 			 = Макет.ПолучитьОбласть("Шапка");
		ОбластьТоварыШапка = Макет.ПолучитьОбласть("ТоварыШапка");
		ОбластьТовары 	 = Макет.ПолучитьОбласть("Товары");
		Подвал 			 = Макет.ПолучитьОбласть("Подвал");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Шапка.Параметры.Заполнить(Выборка);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьТоварыШапка);
			ДокументДляПечати.Вывести(ОбластьТоварыШапка);
			ВыборкаТовары = Выборка.Товары.Выбрать();

			Пока ВыборкаТовары.Следующий() Цикл
				ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьТовары);
				ДокументДляПечати.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());

			КонецЦикла;

			Подвал.Параметры.Заполнить(Выборка);
			Подвал.Параметры.Влюта = ОбщийМодульПовтор.ЗначениеПредопределенного("Справочники.Валюты.ОсновнаяВалюта");
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Подвал);
			ДокументДляПечати.Вывести(Подвал);
			ВставлятьРазделительСтраниц = ИСТИНА;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
