﻿// sza150112-0221
// sza141216-0234
// sza140710-1855  локац
// sza140507-1152
// sza131117-0119

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура НаПечать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "Организация" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();

	СсылкаНаОбъектПечати = Ссылка[0];
	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Справочники.Организации.ПолучитьМакет("НаПечать");
		Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ Организации.Адрес,
		|	Организации.ВидДеятельностиПоОКДП,
		|	Организации.ВидЦен,
		|	Организации.ГлавныйБухгалтер,
		|	Организации.ДатаРедакции,
		|	Организации.ДатаСоздания,
		|	Организации.ДолжностьРуководителя,
		|	ВЫРАЗИТЬ(Организации.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	Организации.МФО,
		|	Организации.НаименованиеБанка,
		|	Организации.НаименованиеДляПечати,
		|	Организации.НомерСвидетельстваПлательщикаНалогаНаДобавочнуюСтоимость,
		|	Организации.НомерСчета,
		|	Организации.ОКПО,
		|	Организации.ОсновнойШтрихКод,
		|	Организации.Ответственный,
		|	Организации.ПоследнийНомерНалоговойНакладной,
		|	Организации.ПравовойСтатус,
		|	Организации.Регион,
		|	Организации.Руководитель,
		|	Организации.Склад,
		|	Организации.Сотрудник,
		|	Организации.СтавкаНДС,
		|	Организации.Телефон,
		|	Организации.ФормаВзаиморасчетовПоУмолчанию,
		|	Организации.ХранилищеДенег,
		|	Организации.ЭлектроннаяПочта,
		|	Организации.ИНН,
		|	Организации.Локация,
		|	Организации.ЮридическийАдрес
		|ИЗ Справочник.Организации КАК Организации
		|ГДЕ Организации.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ЭлементСправочника = Ссылка;
		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		Шапка = Макет.ПолучитьОбласть("Шапка");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Шапка.Параметры.Заполнить(Выборка);
			ПолныйНомерТелефона = ПолныйНомерТелефона = ОбщийМодульСервер.СоставитьТелефон(ЭлементСправочника, ЛОЖЬ);
			Шапка.Параметры.Телефон = ПолныйНомерТелефона;

			Если НЕ ЗначениеЗаполнено(Выборка.НаименованиеДляПечати) Тогда
				Шапка.Параметры.НаименованиеДляПечати = Выборка.Наименование;
			КонецЕсли;

			ВыборкаАдрес = СокрЛП(Выборка.адрес);

			Если Найти(ВыборкаАдрес, "" + СокрЛП(Выборка.регион)) = 0 Тогда
				Адрес = "" + СокрЛП(Выборка.Регион) + ?(ЗначениеЗаполнено(Выборка.Локация), ", " + СокрЛП(Выборка.Локация), "") + ", " + ВыборкаАдрес;
			Иначе
				Адрес = ВыборкаАдрес;
			КонецЕсли;

			Если НЕ ПустаяСтрока(Выборка.ЮридическийАдрес)
				И НЕ ВыборкаАдрес = СокрЛП(Выборка.ЮридическийАдрес) Тогда

				Адрес = Адрес + ", " + Выборка.ЮридическийАдрес;
			КонецЕсли;

			Шапка.Параметры.РегионАдрес = Адрес;
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
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

Процедура ШапкаДокументов(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.Очистить();
	ОбщийМодульСервер.ДобавитьШапкуОрганизации(ДокументДляПечати, Ссылка);

КонецПроцедуры

#КонецЕсли
