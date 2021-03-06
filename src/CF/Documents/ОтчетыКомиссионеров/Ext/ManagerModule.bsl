﻿// sza140613-0146

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура НаПечать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "ДокОтчетКомиссионеров" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();
	СсылкаНаОбъектПечати = Ссылка[0];

	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Документы.ОтчетыКомиссионеров.ПолучитьМакет("НаПечать");
		Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ОтчетыКомиссионеров.ВидЦен,
		|	ОтчетыКомиссионеров.Дата,
		|	ОтчетыКомиссионеров.ДатаВозврата,
		|	ОтчетыКомиссионеров.ДатаРедакции,
		|	ОтчетыКомиссионеров.ДатаСоздания,
		|	ОтчетыКомиссионеров.Договор,
		|	ОтчетыКомиссионеров.Клиент,
		|	ВЫРАЗИТЬ(ОтчетыКомиссионеров.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	ОтчетыКомиссионеров.Номер,
		|	ОтчетыКомиссионеров.ОбщийПроцентКомиссионногоВознаграждения,
		|	ОтчетыКомиссионеров.Ответственный,
		|	ОтчетыКомиссионеров.Склад,
		|	ОтчетыКомиссионеров.Сотрудник,
		|	ОтчетыКомиссионеров.СпособДоставки,
		|	ОтчетыКомиссионеров.ТалонТрек,
		|	ОтчетыКомиссионеров.ТовараВКоличестве,
		|	ОтчетыКомиссионеров.ТовараНаСумму,
		|	ОтчетыКомиссионеров.Товары.(
		|		НомерСтроки,
		|		Номенклатура,
		|		СерияНоменклатуры,
		|		ЕдиницаИзмерения,
		|		Количество,
		|		Цена,
		|		Сумма,
		|		ЧастныйПроцентКомиссионногоВознаграждения,
		|		СуммаКомиссионногоВознаграждения,
		|		ОСтроке
		|	),
		|	ОтчетыКомиссионеров.ДеньгиЗаТовар.(
		|		НомерСтроки,
		|		ДатаОплаты,
		|		ХранилищеДенег,
		|		ФормаОплаты,
		|		Сумма,
		|		Валюта,
		|		Курс,
		|		ОСтроке
		|	),
		|	ОтчетыКомиссионеров.КомиссионноеВознаграждение.(
		|		НомерСтроки,
		|		ДатаОплаты,
		|		ХранилищеДенег,
		|		ФормаОплаты,
		|		Сумма,
		|		Валюта,
		|		Курс,
		|		ОСтроке
		|	),
		|	ОтчетыКомиссионеров.ВозвратНепроданногоТовара.(
		|		НомерСтроки,
		|		Номенклатура,
		|		СерияНоменклатуры,
		|		ЕдиницаИзмерения,
		|		Количество,
		|		Цена,
		|		Сумма,
		|		ОСтроке
		|	)
		|ИЗ Документ.ОтчетыКомиссионеров КАК ОтчетыКомиссионеров
		|ГДЕ ОтчетыКомиссионеров.Ссылка В (&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ОбластьЗаголовок 						= Макет.ПолучитьОбласть("Заголовок");
		Шапка 									= Макет.ПолучитьОбласть("Шапка");
		ОбластьТоварыШапка 						= Макет.ПолучитьОбласть("ТоварыШапка");
		ОбластьТовары 							= Макет.ПолучитьОбласть("Товары");
		ОбластьДеньгиЗаТоварШапка 				= Макет.ПолучитьОбласть("ДеньгиЗаТоварШапка");
		ОбластьДеньгиЗаТовар 					= Макет.ПолучитьОбласть("ДеньгиЗаТовар");
		ОбластьКомиссионноеВознаграждениеШапка 	= Макет.ПолучитьОбласть("КомиссионноеВознаграждениеШапка");
		ОбластьКомиссионноеВознаграждение 		= Макет.ПолучитьОбласть("КомиссионноеВознаграждение");
		ОбластьВозвратНепроданногоТовараШапка 	= Макет.ПолучитьОбласть("ВозвратНепроданногоТовараШапка");
		ОбластьВозвратНепроданногоТовара 		= Макет.ПолучитьОбласть("ВозвратНепроданногоТовара");
		Подвал 									= Макет.ПолучитьОбласть("Подвал");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Клиент = Выборка.Клиент;
			Шапка.Параметры.Заполнить(Выборка);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
			ВыборкаТовары = Выборка.Товары.Выбрать();

			Если НЕ ВыборкаТовары.Количество() = 0 Тогда
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьТоварыШапка);
				ДокументДляПечати.Вывести(ОбластьТоварыШапка);
				Пока ВыборкаТовары.Следующий() Цикл
					ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
					ОбластьТовары.Параметры.ПредставлениеНоменклатуры = ОбщийМодульТекстСервер.ПолучитьОбщееНаименование(ВыборкаТовары.Номенклатура, , Клиент);
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьТовары);
					ДокументДляПечати.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());

				КонецЦикла;
			КонецЕсли;

			ВыборкаДеньгиЗаТовар = Выборка.ДеньгиЗаТовар.Выбрать();

			Если НЕ ВыборкаДеньгиЗаТовар.Количество() = 0 Тогда
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьДеньгиЗаТоварШапка);
				ДокументДляПечати.Вывести(ОбластьДеньгиЗаТоварШапка);
				Пока ВыборкаДеньгиЗаТовар.Следующий() Цикл
					ОбластьДеньгиЗаТовар.Параметры.Заполнить(ВыборкаДеньгиЗаТовар);
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьДеньгиЗаТовар);
					ДокументДляПечати.Вывести(ОбластьДеньгиЗаТовар, ВыборкаДеньгиЗаТовар.Уровень());

				КонецЦикла;
			КонецЕсли;

			ВыборкаКомиссионноеВознаграждение = Выборка.КомиссионноеВознаграждение.Выбрать();

			Если НЕ ВыборкаКомиссионноеВознаграждение.Количество() = 0 Тогда
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьКомиссионноеВознаграждениеШапка);
				ДокументДляПечати.Вывести(ОбластьКомиссионноеВознаграждениеШапка);
				Пока ВыборкаКомиссионноеВознаграждение.Следующий() Цикл
					ОбластьКомиссионноеВознаграждение.Параметры.Заполнить(ВыборкаКомиссионноеВознаграждение);
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьКомиссионноеВознаграждение);
					ДокументДляПечати.Вывести(ОбластьКомиссионноеВознаграждение, ВыборкаКомиссионноеВознаграждение.Уровень());

				КонецЦикла;
			КонецЕсли;

			ВыборкаВозвратНепроданногоТовара = Выборка.ВозвратНепроданногоТовара.Выбрать();

			Если НЕ ВыборкаВозвратНепроданногоТовара.Количество() = 0 Тогда
				ОбластьВозвратНепроданногоТовара.Параметры.Заполнить(Выборка);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьВозвратНепроданногоТовараШапка);
				ДокументДляПечати.Вывести(ОбластьВозвратНепроданногоТовараШапка);

				Пока ВыборкаВозвратНепроданногоТовара.Следующий() Цикл
					ОбластьВозвратНепроданногоТовара.Параметры.Заполнить(ВыборкаВозвратНепроданногоТовара);
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьВозвратНепроданногоТовара);
					ДокументДляПечати.Вывести(ОбластьВозвратНепроданногоТовара, ВыборкаВозвратНепроданногоТовара.Уровень());

				КонецЦикла;
			КонецЕсли;

			Подвал.Параметры.Заполнить(Выборка);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Подвал);
			ДокументДляПечати.Вывести(Подвал);
			ВставлятьРазделительСтраниц = ИСТИНА;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
