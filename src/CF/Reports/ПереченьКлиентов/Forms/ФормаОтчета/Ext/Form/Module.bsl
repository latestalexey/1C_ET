﻿//sza130927-1553 : 

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	Если НЕ ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ДляУскоренияРаботыСБазойДанныхНеВыводитьДополнительныхДанных") Тогда
	Попытка 
		#Если Клиент Тогда
			Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Формируется отчет.."), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ждите.."), БиблиотекаКартинок.ОжиданиеСиниеСтрелки);
		#КонецЕсли
		
	Исключение 	
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Произошла ошибка:") + " " + ОписаниеОшибки();
		Сообщение.Сообщить();
		
	КонецПопытки;	
				 КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаСервере
Процедура ПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ЭтаФорма.СкомпоноватьРезультат();
		ПроверитьНеобходимостьДобавитьДату();
	
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
