﻿// sza141015-1654 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ОбновитьВидимостьКнопок();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимостьКнопок()
	
	Если ЗначениеЗаполнено(Запись.КлючУчета) Тогда		
		ТипДополнительногоРеквизита = ОбщийМодульКлиент.ПолучитьЗначениеРеквизита(Запись.КлючУчета, "ТипДополнительногоРеквизита");
		
		Если ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.ЗначениеИзСправочника")
			ИЛИ ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.СсылкаНаЭлементСправочника")
			ИЛИ ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.СсылкаНаДокумент") Тогда
			
			Элементы.ЗначениеКлючаУчета.КнопкаВыбора  = ИСТИНА;
			Элементы.ЗначениеКлючаУчета.КнопкаОчистки = ИСТИНА;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000300", ЭтаФорма, Отказ);
	
	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Запись.КлючУчета) Тогда
			Запись.КлючУчета = Параметры.КлючУчета;	
			Запись.ЗначениеКлючаУчета = Запись.КлючУчета.ЗначениеПоУмолчанию;
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Запись.Номенклатура) Тогда
			Запись.Номенклатура = Параметры.Номенклатура;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КлючУчетаПриИзменении(Элемент)
	ОбновитьВидимостьКнопок();
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаОчистка(Элемент, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Запись.КлючУчета) Тогда
		ТипДополнительногоРеквизита = ОбщийМодульКлиент.получитьЗначениеРеквизита(Запись.КлючУчета, "ТипДополнительногоРеквизита");
		
		Если ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.СсылкаНаЭлементСправочника")
			ИЛИ ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.СсылкаНаДокумент") Тогда
			
			СтандартнаяОбработка = ЛОЖЬ;			
			Запись.ЗначениеКлючаУчета = Неопределено;		
		КонецЕсли;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(Запись.КлючУчета) Тогда
		
		ТипДополнительногоРеквизита = ОбщийМодульКлиент.получитьЗначениеРеквизита(Запись.КлючУчета, "ТипДополнительногоРеквизита");
		
		Если ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.СсылкаНаЭлементСправочника") Тогда
			СтандартнаяОбработка = ЛОЖЬ;
			
			Если Запись.ЗначениеКлючаУчета = Неопределено Тогда
				ТипРеквизита = Неопределено;

				ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ЗначениеКлючаУчетаНачалоВыбораЗавершение3", ЭтаФорма, Новый Структура("ТипДополнительногоРеквизита", ТипДополнительногоРеквизита)), ОбщийМодульКлиент.ПолучитьСписокИзМетаданных(ИСТИНА));
                Возврат;
			КонецЕсли;
			ЗначениеКлючаУчетаНачалоВыбораФрагмент1();
			
		ИначеЕсли ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.СсылкаНаДокумент") Тогда
			СтандартнаяОбработка = ЛОЖЬ;
			
			Если Запись.ЗначениеКлючаУчета = Неопределено Тогда
				ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ЗначениеКлючаУчетаНачалоВыбораЗавершение1", ЭтаФорма, Новый Структура("ТипДополнительногоРеквизита", ТипДополнительногоРеквизита)), ОбщийМодульКлиент.ПолучитьСписокИзМетаданных(ЛОЖЬ));
                Возврат;
			КонецЕсли;
			ЗначениеКлючаУчетаНачалоВыбораФрагмент();
			
		ИначеЕсли ТипДополнительногоРеквизита = ПредопределенноеЗначение("Перечисление.ТипыДополнительныхРеквизитов.ЗначениеИзСправочника") Тогда
			СтандартнаяОбработка = ЛОЖЬ;
			
			Запись.ЗначениеКлючаУчета = ПредопределенноеЗначение("Справочник.НаборЗначенийДополнительныхРеквизитов.ПустаяСсылка");
			ПараметрыФормы = Новый Структура("Владелец", Запись.КлючУчета);
			ФормаВыбора = ПолучитьФорму("Справочник.НаборЗначенийДополнительныхРеквизитов.Форма.ФормаВыбора", ПараметрыФормы, ЭтаФорма);
			ФормаВыбора.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите значение") + ": ";
			Запись.ЗначениеКлючаУчета = ФормаВыбора.ОткрытьМодально();
			
		КонецЕсли; 	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбораЗавершение3(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	
	ТипДополнительногоРеквизита = ДополнительныеПараметры.ТипДополнительногоРеквизита;	
	
	ТипРеквизита = ВыбранныйЭлемент;
	Если НЕ ТипРеквизита = Неопределено Тогда
		Запись.ЗначениеКлючаУчета = ПредопределенноеЗначение("Справочник." + ТипРеквизита.Значение + ".ПустаяСсылка");	
	КонецЕсли;
	
	ЗначениеКлючаУчетаНачалоВыбораФрагмент1();

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбораФрагмент1()
	
	ПоказатьВводЗначения(Новый ОписаниеОповещения("ЗначениеКлючаУчетаНачалоВыбораЗавершение2", ЭтаФорма, Новый Структура("Запись", Запись)), Запись.ЗначениеКлючаУчета, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите значение") + ": ");

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбораЗавершение2(Значение, ДополнительныеПараметры) Экспорт
	
	Запись = ?(Значение = Неопределено, ДополнительныеПараметры.Запись, Значение);	

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбораЗавершение1(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	
	ТипДополнительногоРеквизита = ДополнительныеПараметры.ТипДополнительногоРеквизита;	
	
	ТипРеквизита = ВыбранныйЭлемент;
	Если НЕ ТипРеквизита = Неопределено Тогда
		Запись.ЗначениеКлючаУчета = ПредопределенноеЗначение("Документ." + ТипРеквизита.Значение + ".ПустаяСсылка");	
	КонецЕсли;
	
	ЗначениеКлючаУчетаНачалоВыбораФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбораФрагмент()
	
	ПоказатьВводЗначения(Новый ОписаниеОповещения("ЗначениеКлючаУчетаНачалоВыбораЗавершение", ЭтаФорма, Новый Структура("Запись", Запись)), Запись.ЗначениеКлючаУчета, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите значение") + ": ");

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеКлючаУчетаНачалоВыбораЗавершение(Значение, ДополнительныеПараметры) Экспорт
	
	Запись = ?(Значение = Неопределено, ДополнительныеПараметры.Запись, Значение);
	
КонецПроцедуры
