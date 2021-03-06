﻿// sza140524-0205
// sza140506-1818

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура НаПечать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "Подразделение" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();

	СсылкаНаОбъектПечати = Ссылка[0];
	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Справочники.Подразделения.ПолучитьМакет("НаПечать");
		Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ Подразделения.Адрес,
		|	Подразделения.ДатаРедакции,
		|	Подразделения.ДатаСоздания,
		|	Подразделения.ДатаФормирования,
		|	Подразделения.Код,
		|	ВЫРАЗИТЬ(Подразделения.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	Подразделения.НаименованиеДляПечати,
		|	Подразделения.Организация,
		|	Подразделения.Ответственный,
		|	Подразделения.Регион,
		|	Подразделения.Руководитель,
		|	Подразделения.Склад,
		|	Подразделения.РабочийГрафик.(
		|		НомерСтроки,
		|		НачалоРаботы,
		|		КонецРаботы,
		|		ОСтроке
		|	),
		|	Подразделения.Состав.(
		|		НомерСтроки,
		|		Сотрудник,
		|		Должность,
		|		НачалоРаботы,
		|		КонецРаботы,
		|		ОСтроке
		|	),
		|	Подразделения.Телефон,
		|	Подразделения.Локация
		|ИЗ Справочник.Подразделения КАК Подразделения
		|ГДЕ Подразделения.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		Шапка = Макет.ПолучитьОбласть("Шапка");
		ОбластьРабочийГрафикШапка = Макет.ПолучитьОбласть("РабочийГрафикШапка");
		ОбластьРабочийГрафик = Макет.ПолучитьОбласть("РабочийГрафик");
		ОбластьСоставШапка = Макет.ПолучитьОбласть("СоставШапка");
		ОбластьСостав = Макет.ПолучитьОбласть("Состав");
		Подвал = Макет.ПолучитьОбласть("Подвал");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Шапка.Параметры.Заполнить(Выборка);
			Если НЕ ЗначениеЗаполнено(Выборка.НаименованиеДляПечати) Тогда
				ОбластьСостав.Параметры.НаименованиеДляПечати = Выборка.Наименование;
			КонецЕсли;

			Если Найти(Выборка.адрес, "" + Выборка.регион) = 0 Тогда
				Шапка.Параметры.РегионАдрес = "" + Выборка.Регион + ?(ЗначениеЗаполнено(Выборка.Локация), ", " + Выборка.Локация, "") + ", " + Выборка.Адрес;
			Иначе
				Шапка.Параметры.РегионАдрес = Выборка.Адрес;
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьРабочийГрафикШапка);
			ДокументДляПечати.Вывести(ОбластьРабочийГрафикШапка);
			ВыборкаРабочийГрафик = Выборка.РабочийГрафик.Выбрать();

			Пока ВыборкаРабочийГрафик.Следующий() Цикл
				ОбластьРабочийГрафик.Параметры.Заполнить(ВыборкаРабочийГрафик);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьРабочийГрафик);
				ДокументДляПечати.Вывести(ОбластьРабочийГрафик, ВыборкаРабочийГрафик.Уровень());

			КонецЦикла;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьСоставШапка);
			ДокументДляПечати.Вывести(ОбластьСоставШапка);
			ВыборкаСостав = Выборка.Состав.Выбрать();
			Пока ВыборкаСостав.Следующий() Цикл
				ОбластьСостав.Параметры.Заполнить(ВыборкаСостав);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьСостав);
				ДокументДляПечати.Вывести(ОбластьСостав, ВыборкаСостав.Уровень());

			КонецЦикла;

			Подвал.Параметры.Заполнить(Выборка);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Подвал);
			ДокументДляПечати.Вывести(Подвал);
			ВставлятьРазделительСтраниц = ИСТИНА;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)

	Если ОбщийМодульПовтор.ВывестиНаименованияНаДругомЯзыке() Тогда
		ВозможноеПредставление = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(Данные.ссылка, , ИСТИНА);
		Если НЕ ВозможноеПредставление = Неопределено Тогда
			Представление = ВозможноеПредставление;
			СтандартнаяОбработка = ЛОЖЬ;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
