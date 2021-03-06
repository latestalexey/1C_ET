﻿// sza140420-0439  
// sza131110-1901 : 
&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(Список.Отбор, "ЗакрытаяПартия", ЛОЖЬ,,,);
	
	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю
	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("001200", ЭтаФорма, Отказ, );
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
		КонецЕсли;
		
	ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);

КонецПроцедуры

&НаКлиенте
Процедура ТолькоНезакрытыеПриИзменении(Элемент)
	
	ОбщийМодульКлиент.УстановитьЭлементОтбора(Список.Отбор, "ЗакрытаяПартия", ЛОЖЬ,,,)
	
КонецПроцедуры
