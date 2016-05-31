﻿// sza140509-0107
// sza131005-0216 :

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю
	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                     // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);

КонецПроцедуры

Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("001700", ЭтаФорма, Отказ, );
	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ОбщийМодульСервисСервер.ОформитьФорматКоличества(Элементы.ТовараВКоличестве, , ИСТИНА);
		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
