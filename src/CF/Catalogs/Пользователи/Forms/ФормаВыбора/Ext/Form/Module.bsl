﻿// sza160307-0518
// sza131017-1819 :

&НаКлиенте
Процедура ПриЗакрытии()                     // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаСервере
Процедура ДополнитьСписокПоДаннымКонфигуратораНаСервере()

	МассивПользователей = ПользователиИнформационнойБазы.ПолучитьПользователей();
	Для Каждого ПользовательИзКонфигуратора Из МассивПользователей Цикл
		ОбщийМодульСерверПривилегия.ОпределитьПользователя(ПользовательИзКонфигуратора);
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ДополнитьСписокПоДаннымКонфигуратора(Команда)
	ДополнитьСписокПоДаннымКонфигуратораНаСервере();
КонецПроцедуры
