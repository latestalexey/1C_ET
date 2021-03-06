﻿// sza160229-0341

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)

		Если ОбщийМодульПовтор.ВывестиНаименованияНаДругомЯзыке() Тогда
			ВозможноеПредставление = ОбщийМодульПовтор.ПолучитьПредставлениеНаЯзыке(Данные.Ссылка, , ИСТИНА);
			Если НЕ ВозможноеПредставление = Неопределено Тогда
				Представление = ВозможноеПредставление;
				СтандартнаяОбработка = ЛОЖЬ;
			КонецЕсли;
		КонецЕсли;

	КонецПроцедуры

	Процедура Печать(ДокументДляПечати, Ссылка) Экспорт

		ДокументДляПечати.ИмяПараметровПечати  = "ЗаметкиИНапоминания" + СокрЛП(ИмяКомпьютера());
		ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
		ДокументДляПечати.Очистить();
		СсылкаНаОбъектПечати = Ссылка[0];
		РазрядМетаданных = ""; ИмяМетаданных = "";
		ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);

		Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
			ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
		Иначе
			Макет = Справочники.ЗаметкиИНапоминания.ПолучитьМакет("Печать");
			Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

			Запрос = Новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ ЗаметкиИНапоминания.Дата,
			|	ЗаметкиИНапоминания.ДатаРедакции,
			|	ЗаметкиИНапоминания.ДатаСоздания,
			|	ВЫРАЗИТЬ(ЗаметкиИНапоминания.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
			|	ЗаметкиИНапоминания.Наименование,
			|	ЗаметкиИНапоминания.Ответственный,
			|	ЗаметкиИНапоминания.ПовторятьКаждыеЧислоЧасов,
			|	ЗаметкиИНапоминания.Причина,
			|	ЗаметкиИНапоминания.СвязаноС,
			|	ЗаметкиИНапоминания.ТекстЗаметки,
			|	ЗаметкиИНапоминания.ТипЗаметки,
			|	ЗаметкиИНапоминания.ВыполняемыеЗадачи.(
			|		ТипЗадачи,
			|		КодИмяОтчета,
			|		Адрес,
			|		Комментарий	)
			|ИЗ Справочник.ЗаметкиИНапоминания КАК ЗаметкиИНапоминания
			|ГДЕ ЗаметкиИНапоминания.Ссылка В (&Ссылка)";
			Запрос.Параметры.Вставить("Ссылка", Ссылка);

			Выборка = Запрос.Выполнить().Выбрать();
			ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
			Шапка = Макет.ПолучитьОбласть("Шапка");
			ОбластьВыполняемыеЗадачиШапка = Макет.ПолучитьОбласть("ВыполняемыеЗадачиШапка");
			ОбластьВыполняемыеЗадачи = Макет.ПолучитьОбласть("ВыполняемыеЗадачи");
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
				ВыборкаВыполняемыеЗадачи = Выборка.ВыполняемыеЗадачи.Выбрать();

				Если НЕ ВыборкаВыполняемыеЗадачи.Количество() = 0 Тогда
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьВыполняемыеЗадачиШапка);
					ДокументДляПечати.Вывести(ОбластьВыполняемыеЗадачиШапка);
					Пока ВыборкаВыполняемыеЗадачи.Следующий() Цикл
						ОбластьВыполняемыеЗадачи.Параметры.Заполнить(ВыборкаВыполняемыеЗадачи);
						ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьВыполняемыеЗадачи);
						ДокументДляПечати.Вывести(ОбластьВыполняемыеЗадачи, ВыборкаВыполняемыеЗадачи.Уровень());

					КонецЦикла;
				КонецЕсли;

				ВставлятьРазделительСтраниц = ИСТИНА;

			КонецЦикла;
		КонецЕсли;

	КонецПроцедуры

#КонецЕсли
