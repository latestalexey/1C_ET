﻿// sza141223-2105
// sza140509-0122
// sza131007-1636

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю
	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                           // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

	Если ЗначениеЗаполнено(Параметры.Валюта) Тогда
		ОбщийМодульКлиент.УстановитьЭлементОтбора(
		Список.Отбор,
		"Валюта",
		Параметры.Валюта,
		ВидСравненияКомпоновкиДанных.равно,
		,
		ИСТИНА
		);
	КонецЕсли;

	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000170", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СписокПослеУдаления(Элемент)
	СписокПослеУдаленияНаСервере();
КонецПроцедуры

&НаСервере
Процедура СписокПослеУдаленияНаСервере()
	ОбновитьПовторноИспользуемыеЗначения();
КонецПроцедуры
