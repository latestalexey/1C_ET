﻿//sza131203-0152 SZA: 
//sza131121-1527 SZA: 

Процедура ПриКопировании(ОбъектКопирования)
	ЭтотОбъект.комментарий = "";
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	Отказ = ОбщийМодульСервер.ПроверитьУникальностьНаименование(Отказ, "Склады", ЭтотОбъект.Наименование, ЭтотОбъект.Ссылка);
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	//{{__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Организации") Тогда
		// Заполнение шапки
		ВидЦенРеализацииСЭтогоСклада = ДанныеЗаполнения.ВидЦен;
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ОтветственныйСотрудник = ДанныеЗаполнения.Сотрудник;
		ХранилищеДенег = ДанныеЗаполнения.ХранилищеДенег;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Сотрудники") Тогда
		// Заполнение шапки
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ОтветственныйСотрудник = ДанныеЗаполнения.Ссылка;
		ХранилищеДенег = ДанныеЗаполнения.ХранилищеДенег;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.ХранилищаДенег") Тогда
		// Заполнение шапки
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ОтветственныйСотрудник = ДанныеЗаполнения.ОтветственныйСотрудник;
		ХранилищеДенег = ДанныеЗаполнения.Ссылка;
	КонецЕсли;
	//}}__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
КонецПроцедуры
