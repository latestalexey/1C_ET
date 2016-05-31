﻿// sza131120-1130

&НаКлиенте
Процедура Декорация1Нажатие(Элемент)

	Если КодРазблокирования = КодБлокирования Тогда
		Если НЕ ЭтаФорма.Окно = Неопределено Тогда
				Закрыть();
			КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура КодРазблокированияАвтоПодбор(Элемент, Текст, ДанныеВыбора, Параметры, Ожидание, СтандартнаяОбработка)

	Если КодРазблокирования = КодБлокирования Тогда
		Если НЕ ЭтаФорма.Окно = Неопределено Тогда
				Закрыть();
			КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура КодРазблокированияОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)

	Если КодРазблокирования = КодБлокирования Тогда
		Если НЕ ЭтаФорма.Окно = Неопределено Тогда
				Закрыть();
			КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура КодРазблокированияПриИзменении(Элемент)

	Если КодРазблокирования = КодБлокирования Тогда
		Если НЕ ЭтаФорма.Окно = Неопределено Тогда
				Закрыть();
			КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура КодРазблокированияРегулирование(Элемент, Направление, СтандартнаяОбработка)

	Если КодРазблокирования = КодБлокирования Тогда
		Если НЕ ЭтаФорма.Окно = Неопределено Тогда
				Закрыть();
			КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)

	Если НЕ КодРазблокирования = КодБлокирования Тогда
		Отказ = ИСТИНА;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

	Если НЕ КодРазблокирования = КодБлокирования Тогда
		Отказ = ИСТИНА;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
	КонецЕсли;

	КодБлокирования = Параметры.КодБлокирования;
	ВремяБлокировки = ТекущаяДата();

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
