﻿// sza140710-1201  локация
// sza131005-0203 :

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                             // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

	ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);

	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьРегионыДляУчетаСтранАЛокацииГородов") Тогда
		Элементы.ФормаВыбрать.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выбрать Город");
		Элементы.ФормаСоздать.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Создать Город");
		Элементы.Наименование.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Наименование Городов");
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
