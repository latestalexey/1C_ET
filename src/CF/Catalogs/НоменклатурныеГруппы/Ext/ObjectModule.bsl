﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza151210-2210 про
// sza140411-1654 :
// sza131023-1603 :
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Производители") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Склады") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ПометкаУдаления Тогда

		Отказ = ОбщийМодульСервер.ПроверитьУникальностьЗначенияРеквизита(Отказ, "НоменклатурныеГруппы", Наименование, Ссылка);
		ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(Наименование, Ссылка, , Отказ);
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
			ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "РеквизитыНоменклатуры", "ДополнительныйРеквизит", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("дополнительных реквизитов"));
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриЗаписи(Отказ)

	Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА)
	И СвязатьОдноименнуюГруппуНоменклатуры Тогда

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1 Номенклатура.Ссылка, Номенклатура.ПометкаУдаления КАК ПометкаУдаления
		|ИЗ Справочник.Номенклатура КАК Номенклатура
		|ГДЕ Номенклатура.ЭтоГруппа = ИСТИНА И Номенклатура.Наименование = &Наименование
		|УПОРЯДОЧИТЬ ПО ПометкаУдаления";
		Запрос.УстановитьПараметр("Наименование", Наименование);

		РезультатЗапроса = Запрос.Выполнить();

		Если НЕ РезультатЗапроса.Пустой() Тогда
			// 			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			// 			ВыборкаДетальныеЗаписи.Следующий();

		Иначе
			ОдноименнуюГруппуНоменклатуры = Справочники.Номенклатура.СоздатьГруппу();
			ОдноименнуюГруппуНоменклатуры.Наименование = Наименование;
			ОдноименнуюГруппуНоменклатуры.Записать();
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Комментарий = "";
КонецПроцедуры

#КонецЕсли
