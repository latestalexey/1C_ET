﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza151210-2227 про
// sza140411-1656 :
// sza131121-1527
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Организации") Тогда
		ВидЦенРеализацииСЭтогоСклада = ДанныеЗаполнения.ВидЦен;
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ОтветственныйСотрудник = ДанныеЗаполнения.Сотрудник;
		ХранилищеДенег = ДанныеЗаполнения.ХранилищеДенег;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Сотрудники") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ОтветственныйСотрудник = ДанныеЗаполнения.Ссылка;
		ХранилищеДенег = ДанныеЗаполнения.ХранилищеДенег;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.ХранилищаДенег") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ОтветственныйСотрудник = ДанныеЗаполнения.ОтветственныйСотрудник;
		ХранилищеДенег = ДанныеЗаполнения.Ссылка;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ПометкаУдаления
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		Отказ = ОбщийМодульСервер.ПроверитьУникальностьЗначенияРеквизита(Отказ, "Склады", Наименование, Ссылка);
		ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(Наименование, Ссылка, , Отказ);
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
			ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "ЗакрепленныеСотрудники", "Сотрудник", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("закрепленных сотрудников"));
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Комментарий = "";
КонецПроцедуры

#КонецЕсли
