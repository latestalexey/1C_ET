﻿//sza131205-0350 SZA: 
//sza130915-1233 : 

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если НЕ ЗначениеЗаполнено(ПериодДляОтчета) Тогда
		ПериодДляОтчета.Вариант = ВариантСтандартногоПериода.ЭтотМесяц;
		ДатаНачала = ПериодДляОтчета.ДатаНачала;
		ДатаОкончания = ПериодДляОтчета.ДатаОкончания;		
	КонецЕсли;	
	ЗаданиеПараметровИКомпоновкаОтчета();
	
	ПериодДляОтчета.ДатаНачала = ДатаНачала;
	ПериодДляОтчета.ДатаОкончания = ДатаОкончания;
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодДляОтчетаПриИзменении(Элемент)
	ДатаНачала = ПериодДляОтчета.ДатаНачала;
	ДатаОкончания = ПериодДляОтчета.ДатаОкончания;
	ЗаданиеПараметровИКомпоновкаОтчета();
КонецПроцедуры

Процедура ЗаданиеПараметровИКомпоновкаОтчета() //Экспорт	
	
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ДатаНачала", ПериодДляОтчета.ДатаНачала);
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ДатаОкончания", ПериодДляОтчета.ДатаОкончания);
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ОтборПоФормеОплаты", ЗначениеЗаполнено(ОтборПоФормеОплаты));
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ФормаОплаты", ОтборПоФормеОплаты);
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ОтборПоХранилищуДенег", ЗначениеЗаполнено(ОтборПоХранилищуДенег));
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ХранилищеДенег", ОтборПоХранилищуДенег);
	
	Если НЕ ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ДляУскоренияРаботыСБазойДанныхНеВыводитьДополнительныхДанных") Тогда
	Попытка 
		#Если Клиент Тогда
			Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Формируется отчет.."), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ждите.."), БиблиотекаКартинок.ОжиданиеСиниеСтрелки);
		#КонецЕсли
		ЭтаФорма.СкомпоноватьРезультат();
		Результат.показатьуровеньгруппировокстрок(1);
		ПроверитьНеобходимостьДобавитьДату();
		
	Исключение 	
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Произошла ошибка:") + " " + ОписаниеОшибки();
		Сообщение.Сообщить();
		
	КонецПопытки; 	
				  КонецЕсли;
КонецПроцедуры //СменаПериода

&НаКлиенте
Процедура ДатаНачалаПриИзменении(Элемент)
	ПериодДляОтчета.ДатаНачала = ДатаНачала;
	Если ДатаОкончания < ДатаНачала Тогда
		ДатаОкончания = ДатаНачала;
		ПериодДляОтчета.ДатаОкончания = КонецДня(ДатаОкончания);
	КонецЕсли;
	ЗаданиеПараметровИКомпоновкаОтчета();
КонецПроцедуры

&НаКлиенте
Процедура ДатаОкончанияПриИзменении(Элемент)
	ПериодДляОтчета.ДатаОкончания = ДатаОкончания;
	Если ДатаОкончания < ДатаНачала Тогда
		ДатаНачала = ДатаОкончания;
		ПериодДляОтчета.ДатаНачала = НачалоДня(ДатаНачала);
	КонецЕсли;
	ЗаданиеПараметровИКомпоновкаОтчета();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоФормеОплатыПриИзменении(Элемент)
	ЗаданиеПараметровИКомпоновкаОтчета();
КонецПроцедуры

&НаСервере
Процедура ПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(ПериодДляОтчета) Тогда
        ПериодДляОтчета.Вариант = ВариантСтандартногоПериода.Вчера;
		ДатаНачала = ПериодДляОтчета.ДатаНачала;
		ДатаОкончания = ПериодДляОтчета.ДатаОкончания;		
	КонецЕсли;	
	
	Если ЗначениеЗаполнено(ДатаНачала) Тогда
		ЗаданиеПараметровИКомпоновкаОтчета();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
процедура ПроверитьНеобходимостьДобавитьДату()
	
	Если ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ДобавлятьТекущуюДатуИВремяВоВсеПечатныеФормы") Тогда
		МакетДатыВремени = ПолучитьОбщийМакет("МакетДатыВремени");
		ТаблицаТекущейДатыВремени = МакетДатыВремени.ПолучитьОбласть("Ш");
		ТаблицаТекущейДатыВремени.Параметры.ТекущаяДатаИВремя = ОбщийМодульСервисСервер.ПользователяТекущаяДата();
		результат.Вывести(ТаблицаТекущейДатыВремени);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоХранилищуДенегПриИзменении(Элемент)
	ЗаданиеПараметровИКомпоновкаОтчета();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УчитыватьДеньгиВНесколькихХранилищах 	= ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("УчитыватьДеньгиВНесколькихХранилищах");
	Элементы.ОтборПоФормеОплаты.Видимость 	= НЕ УчитыватьДеньгиВНесколькихХранилищах;	
	
КонецПроцедуры
