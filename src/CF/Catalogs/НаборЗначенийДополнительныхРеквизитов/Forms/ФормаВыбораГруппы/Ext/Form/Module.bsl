﻿// sza141017-0018 :

&НаКлиенте
Процедура ДобавитьГруппу(Команда)

	ПараметрыФормы = Новый Структура("Владелец", ВладелецЗначений);
	ОткрытьФорму("Справочник.НаборЗначенийДополнительныхРеквизитов.ФормаГруппы", ПараметрыФормы);

КонецПроцедуры

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

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

	ВладелецЗначений = Параметры.Отбор.Владелец;
	ЗначениеЗаполненоПараметрыВладелец = ЗначениеЗаполнено(ВладелецЗначений);
	Если ЗначениеЗаполненоПараметрыВладелец Тогда
		Список.Параметры.УстановитьЗначениеПараметра("Владелец", ВладелецЗначений);
		Элементы.ВладелецЗначений.Видимость = ИСТИНА;
	Иначе
		Элементы.ВладелецЗначений.Видимость = ЛОЖЬ;
	КонецЕсли;

Список.Параметры.УстановитьЗначениеПараметра("ОтборПоВладельцу", ЗначениеЗаполненоПараметрыВладелец);
КонецЕсли;

КонецПроцедуры
