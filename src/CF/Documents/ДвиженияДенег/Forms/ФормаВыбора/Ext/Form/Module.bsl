﻿// sza140420-0459
// sza131005-0215 :

&НаКлиенте
Процедура ПриЗакрытии()                                             // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                        // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000890", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		Элементы.КромеДокументовОбменаВалют.Видимость = ПараметрыСеанса.ВестиУчетВалютВСеансе;
		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
