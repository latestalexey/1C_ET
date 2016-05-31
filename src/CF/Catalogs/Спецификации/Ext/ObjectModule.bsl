﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza151210-2315 про
// sza140805-1917 ввод на осн компл
// sza140413-0028
// sza140409-1715
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Номенклатура") Тогда
		Наименование = ДанныеЗаполнения.Наименование;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Комплектация") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;

		Для Каждого ТекСтрокаДополнительныеРасходы Из ДанныеЗаполнения.ДополнительныеРасходы Цикл
			НоваяСтрока = ДополнительныеРасходы.Добавить();
			НоваяСтрока.Валюта = ТекСтрокаДополнительныеРасходы.Валюта;
			НоваяСтрока.НеРаспределятьНаСтоимость = ТекСтрокаДополнительныеРасходы.НеРаспределятьНаСтоимость;
			НоваяСтрока.ОСтроке = ТекСтрокаДополнительныеРасходы.ОСтроке;
			НоваяСтрока.Статья = ТекСтрокаДополнительныеРасходы.Статья;
			НоваяСтрока.Сумма = ТекСтрокаДополнительныеРасходы.Сумма;

		КонецЦикла;

		Для Каждого ТекСтрокаЗадействованныеСредства Из ДанныеЗаполнения.ЗадействованныеСредства Цикл
			НоваяСтрока = ЗадействованныеСредства.Добавить();
			НоваяСтрока.Коэффициент = ТекСтрокаЗадействованныеСредства.Коэффициент;
			НоваяСтрока.ОСтроке = ТекСтрокаЗадействованныеСредства.ОСтроке;
			НоваяСтрока.Средство = ТекСтрокаЗадействованныеСредства.Средство;

		КонецЦикла;

		Для Каждого ТекСтрокаМатериалы Из ДанныеЗаполнения.Материалы Цикл
			НоваяСтрока = Материалы.Добавить();
			НоваяСтрока.Количество = ТекСтрокаМатериалы.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаМатериалы.Номенклатура;
			НоваяСтрока.ОСтроке = ТекСтрокаМатериалы.ОСтроке;

		КонецЦикла;

		Для Каждого ТекСтрокаРаботы Из ДанныеЗаполнения.Работы Цикл
			НоваяСтрока = Работы.Добавить();
			НоваяСтрока.ВремяВыполнения = ТекСтрокаРаботы.ВремяВыполнения;
			НоваяСтрока.Количество = ТекСтрокаРаботы.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаРаботы.Номенклатура;
			НоваяСтрока.ОСтроке = ТекСтрокаРаботы.ОСтроке;

		КонецЦикла;

		Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
			НоваяСтрока = Товары.Добавить();
			НоваяСтрока.ЕдиницаИзмерения = ТекСтрокаТовара.ЕдиницаИзмерения;
			НоваяСтрока.Количество = ТекСтрокаТовара.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаТовара.Номенклатура;
			НоваяСтрока.ОСтроке = ТекСтрокаТовара.ОСтроке;

		КонецЦикла;

	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ПоступленияТовара") Тогда
		Для Каждого ТекСтрокаДополнительныеРасходы Из ДанныеЗаполнения.ДополнительныеРасходы Цикл
			НоваяСтрока = ДополнительныеРасходы.Добавить();
			НоваяСтрока.Валюта  = ТекСтрокаДополнительныеРасходы.Валюта;
			НоваяСтрока.НеРаспределятьНаСтоимость = ТекСтрокаДополнительныеРасходы.НеРаспределятьНаСтоимость;
			НоваяСтрока.ОСтроке = ТекСтрокаДополнительныеРасходы.ОСтроке;
			НоваяСтрока.Статья  = ТекСтрокаДополнительныеРасходы.Статья;
			НоваяСтрока.Сумма   = ТекСтрокаДополнительныеРасходы.Сумма;

		КонецЦикла;

		Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
			НоваяСтрока = Материалы.Добавить();
			НоваяСтрока.Количество 	 = ТекСтрокаТовара.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаТовара.Номенклатура;
			НоваяСтрока.ОСтроке 	 = ТекСтрокаТовара.ОСтроке;

		КонецЦикла;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ПеремещенияТовара") Тогда

		Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
			НоваяСтрока = Материалы.Добавить();
			НоваяСтрока.Количество 	 = ТекСтрокаТовара.Количество;
			НоваяСтрока.Номенклатура = ТекСтрокаТовара.Номенклатура;
			НоваяСтрока.ОСтроке 	 = ТекСтрокаТовара.ОСтроке;

		КонецЦикла;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ВыполненияРабот") Тогда
		Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
			НоваяСтрока = Работы.Добавить();
			НоваяСтрока.Количество  = ТекСтрокаТовара.Количество;
			НоваяСтрока.ОСтроке 	= ТекСтрокаТовара.ОСтроке;

		КонецЦикла;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Договора") Тогда
		Дата = ДанныеЗаполнения.ДатаЗаключения;
		Наименование = ДанныеЗаполнения.НомерДоговора;

		Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
			НоваяСтрока = Товары.Добавить();
			НоваяСтрока.ЕдиницаИзмерения = ТекСтрокаТовара.ЕдиницаИзмерения;
			НоваяСтрока.ОСтроке 		 = ТекСтрокаТовара.Комментарий;
			НоваяСтрока.Номенклатура 	 = ТекСтрокаТовара.Номенклатура;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ЭтоГруппа
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА)
		И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда

		ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, , , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("продуктов"));
		ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "Материалы", , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("материалов"));
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Комментарий = "";
КонецПроцедуры

#КонецЕсли
