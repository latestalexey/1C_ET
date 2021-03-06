﻿// sza160324-0456

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Сч = 0;
	Для Каждого РеквизитСписка Из Параметры.МассивНаименований Цикл
		Элементы.ТаблицаСопоставленийОписаниеРеквизита.СписокВыбора.Добавить(РеквизитСписка, Параметры.МассивОписаний[Сч]);
		Сч = Сч + 1;
	КонецЦикла;

	Сч = 1;
	Для Каждого КолонкаТаблицы Из Параметры.МассивКолонок Цикл
		СтрокаТаблицы = ТаблицаСопоставлений.Добавить();
		СтрокаТаблицы.НаименованиеРеквизита = "";
		СтрокаТаблицы.ОписаниеРеквизита = "";
		СтрокаТаблицы.НомерКолонкиВТаблицеДанных = Сч;
		СтрокаТаблицы.ЗаголовокВТаблице = КолонкаТаблицы;
		СтрокаТаблицы.ПримерЗначенияВТаблице = Параметры.МассивПримеров[Сч -1];
		Сч = Сч + 1;
	КонецЦикла;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСопоставленийОписаниеРеквизитаПриИзменении(Элемент)

	ТекущиеДанные = Элементы.ТаблицаСопоставлений.ТекущиеДанные;
	ТекущиеДанные.НаименованиеРеквизита = ТекущиеДанные.ОписаниеРеквизита;

КонецПроцедуры

&НаКлиенте
Процедура ПрименитьЭтиОпределенияКолонок(Команда)

	МассивКолонок = Новый Массив;
	МассивНомеров = Новый Массив;

	Сч = 0;
	СтруктураПолей = Новый Структура;
	Для Каждого СтрокаТаблицы Из ТаблицаСопоставлений Цикл
		Если ЗначениеЗаполнено(СтрокаТаблицы.НаименованиеРеквизита) Тогда
			МассивНомеров.Добавить(Сч);
			МассивКолонок.Добавить(СтрокаТаблицы.НаименованиеРеквизита);
		КонецЕсли;
		Сч = Сч + 1;
	КонецЦикла;

	ЭтаФорма.Закрыть(Новый Структура("МассивНомеров, МассивКолонок", МассивНомеров, МассивКолонок));

КонецПроцедуры
