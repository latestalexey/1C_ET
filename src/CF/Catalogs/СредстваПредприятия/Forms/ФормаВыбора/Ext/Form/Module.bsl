﻿// sza151218-1558 
// sza140710-1901  локац
// sza140420-0453  
// sza140120-1707 
&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("001600", ЭтаФорма, Отказ, );
	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
		КонецЕсли;
		
		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьРегионыДляУчетаСтранАЛокацииГородов") Тогда
			Элементы.Регион.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Страна");
			Элементы.Локация.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Город");
		КонецЕсли;         		
		
		Элементы.ПроЗакрепленныеСотрудники.Видимость = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетЗарплатыСотрудников") И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков");
	КонецЕсли;
	
КонецПроцедуры
