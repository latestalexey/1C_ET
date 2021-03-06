﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza140411-1656 :
// sza131118-0056
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Поставщики") Тогда
		Адрес 		 = ДанныеЗаполнения.Адрес;
		Комментарий  = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		Регион 		 = ДанныеЗаполнения.Регион;
		Телефон 	 = ОбщийМодульСервер.ПолучитьТекстТелефонов(ДанныеЗаполнения.Ссылка);
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Сотрудники") Тогда
		Адрес 		 = ДанныеЗаполнения.Адрес;
		Комментарий  = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		Телефон 	 = ОбщийМодульСервер.ПолучитьТекстТелефонов(ДанныеЗаполнения.Ссылка);
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ПометкаУдаления
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		Отказ = ОбщийМодульСервер.ПроверитьУникальностьЗначенияРеквизита(Отказ, "Производители", Наименование, Ссылка);
		ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(Наименование, Ссылка, , Отказ);
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Комментарий = "";
КонецПроцедуры

#КонецЕсли
