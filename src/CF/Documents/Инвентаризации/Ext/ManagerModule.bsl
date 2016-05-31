﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza131127-2144
// sza130909-2145 :
Процедура Печать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "ДокИнвентаризация" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();
	СсылкаНаОбъектПечати = Ссылка[0];

	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Документы.Инвентаризации.ПолучитьМакет("Печать");
		Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	Инвентаризации.ВыбылоДенег,
		|	Инвентаризации.Дата,
		|	ВЫРАЗИТЬ(Инвентаризации.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	Инвентаризации.ПоступилоДенег,
		|	Инвентаризации.Склад,
		|	Инвентаризации.ТовараВКоличестве,
		|	Инвентаризации.ТовараНаСумму,
		|	Инвентаризации.Товары.(
		|		Номенклатура,
		|		КоличествоУчет,
		|		КоличествоРазница,
		|		КоличествоНеучтенныйВозврат + КоличествоПоФакту КАК КоличествоПоФакту,
		|		Цена,
		|		СуммаРазница,
		|		СерияНоменклатуры
		|	),
		|	Инвентаризации.ВидЦен,
		|	Инвентаризации.Валюта,
		|	Инвентаризации.ХранилищеДенег,
		|	Инвентаризации.Номер
		|ИЗ Документ.Инвентаризации КАК Инвентаризации
		|ГДЕ Инвентаризации.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ОбластьЗаголовок 	= Макет.ПолучитьОбласть("Заголовок");
		Шапка 				= Макет.ПолучитьОбласть("Шапка");
		ОбластьТоварыШапка 	= Макет.ПолучитьОбласть("ТоварыШапка");
		ОбластьТовары 		= Макет.ПолучитьОбласть("Товары");
		Подвал 				= Макет.ПолучитьОбласть("Подвал");
		ВестиУчетПоСериямНоменклатуры = ОбщийМодульПовтор.ПолучитьПараметрСеанса("ВестиУчетПоСериямНоменклатуры")
		ИЛИ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетСерийНоменклатурыТолькоПриПоступлении");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Шапка.Параметры.Заполнить(Выборка);
			СтруктураДополнительныхПараметровМакета = ОбщийМодульСервер.ПолучитьСтруктуруДополнительныхПараметровМакетаПечати();
			Шапка.Параметры.ТекстВШапкеДокументовПриПечати   = СтруктураДополнительныхПараметровМакета.ТекстВШапкеДокументовПриПечати;
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьТоварыШапка);
			ДокументДляПечати.Вывести(ОбластьТоварыШапка);
			ВыборкаТовары = Выборка.Товары.Выбрать();

			Пока ВыборкаТовары.Следующий() Цикл
				ОбластьТовары.Параметры.Заполнить(ВыборкаТовары);
				ОбластьТовары.Параметры.НоменклатураНаименование = ОбщийМодульТекстСервер.ПолучитьОбщееНаименование(ВыборкаТовары.Номенклатура);

				Если ВестиУчетПоСериямНоменклатуры
					И ЗначениеЗаполнено(ВыборкаТовары.СерияНоменклатуры) Тогда

					ОбластьТовары.Параметры.НоменклатураНаименование = ОбластьТовары.Параметры.НоменклатураНаименование + " " + ВыборкаТовары.СерияНоменклатуры;
				КонецЕсли;

				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьТовары);
				ДокументДляПечати.Вывести(ОбластьТовары, ВыборкаТовары.Уровень());
			КонецЦикла;

			Подвал.Параметры.Заполнить(Выборка);
			Подвал.Параметры.ТекстВПодвалеДокументовПриПечати = СтруктураДополнительныхПараметровМакета.ТекстВПодвалеДокументовПриПечати;
			ВалютаОсн = ОбщийМодульПовтор.ЗначениеПредопределенного("Справочники.Валюты.ОсновнаяВалюта");
			Подвал.Параметры.Валюта = ?(ЗначениеЗаполнено(Выборка.Валюта), Выборка.Валюта, ВалютаОсн);
			Подвал.Параметры.ВалютаОсн = ВалютаОсн;
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Подвал);
			ДокументДляПечати.Вывести(Подвал);
			ВставлятьРазделительСтраниц = ИСТИНА;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
