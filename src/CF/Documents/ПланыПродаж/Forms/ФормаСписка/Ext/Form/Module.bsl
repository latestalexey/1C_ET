﻿// sza140509-0119  
// sza131005-0223 : 
&НаКлиенте
Процедура ПриЗакрытии()                                           // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                      // ПРИ ОТКРЫТИИ
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю
	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002400", ЭтаФорма, Отказ, );
	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
		КонецЕсли;
		
		ОбщийМодульСервисСервер.ОформитьФорматКоличества(Элементы.ТовараВКоличестве, , ИСТИНА);
		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);	
	КонецЕсли;
	
КонецПроцедуры
