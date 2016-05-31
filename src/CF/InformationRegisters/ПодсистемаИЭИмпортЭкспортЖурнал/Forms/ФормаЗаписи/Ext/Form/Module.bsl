﻿// sza131005-0245 :

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
	КонецЕсли;

	Если ПараметрыСеанса.ВерсияПриложения < 803050000
			ИЛИ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВместоТумблеровПоказыватьГалочки") Тогда

		Если НЕ ПараметрыСеанса.ВерсияПриложения < 803050000 Тогда
					Выполнить(" Элементы.ИмпортНеЭкспорт.ВидФлажка = ВидФлажка.Флажок; ");
																						  КонецЕсли;

		Элементы.ИмпортНеЭкспорт.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Это ИМПОРТ");
		Элементы.ИмпортНеЭкспорт.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Лево;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
