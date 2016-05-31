﻿// sza140726-1915
// sza140420-1435
// sza131120-1125

&НаКлиенте
Процедура НовыйДокументВзаимозачетаКонтрагентов(Команда)

	ПараметрыФормы = Новый Структура;
	ОткрытьФорму("Документ.КорректировкиИРегистрацияОстатков.Форма.ФормаДокументаВзаимоЗачетаДолгаКонтрагентов", ПараметрыФормы);

КонецПроцедуры

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю

	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                 // ПРИ ЗАКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                            // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000657", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список, "Взаимозачет");
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка=ЛОЖЬ;
   ОткрытьФорму("Документ.КорректировкиИРегистрацияОстатков.Форма.ФормаДокументаВзаимоЗачетаДолгаКонтрагентов",Новый Структура("Ключ",ВыбраннаяСтрока));

КонецПроцедуры
