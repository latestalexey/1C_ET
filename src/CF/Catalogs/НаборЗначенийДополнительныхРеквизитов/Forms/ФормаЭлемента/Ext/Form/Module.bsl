﻿// sza150116-1944
// sza141017-1443
// sza140330-1441
// sza140320-1554

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	ОбновитьВидимостьДопПараметров();
КонецПроцедуры

&НаСервереБезКонтекста
Функция   ИспользуютсяДополнительныеПараметры(Знач Владелец)

	Возврат ЗначениеЗаполнено(Владелец) И Владелец.ИспользуютсяДополнительныеПараметрыЗначений;

КонецФункции

&НаКлиенте
Процедура ОбновитьВидимостьДопПараметров()

	Элементы.ГруппаДополнительныхПараметров.Видимость = ИспользуютсяДополнительныеПараметры(Объект.Владелец);

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = ИСТИНА;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, ИСТИНА);
	ОбновитьВидимостьДопПараметров();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		Если ЗначениеЗаполнено(Параметры.Владелец)
			И НЕ ЗначениеЗаполнено(Объект.Владелец) Тогда

			Объект.Владелец = Параметры.Владелец;
		КонецЕсли;

		Если Параметры.Свойство("ВладелецЗначений")
			И ЗначениеЗаполнено(Параметры.ВладелецЗначений)
			И НЕ ЗначениеЗаполнено(Объект.Владелец) Тогда

   			Объект.Владелец = Параметры.ВладелецЗначений;
		КонецЕсли;

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПараметрыЗначенийДополнительныхРеквизитовДатыПредставлятьВГодах") Тогда
			Элементы.ПараметрДатаНачала.ФорматРедактирования = "ДФ=гггг";
			Элементы.ПараметрДатаОкончания.ФорматРедактирования = "ДФ=гггг";
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры
