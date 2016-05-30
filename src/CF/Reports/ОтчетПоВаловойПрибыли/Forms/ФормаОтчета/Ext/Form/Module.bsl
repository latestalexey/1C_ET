﻿//sza140125-0055 
//sza130915-1233 : 

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если НЕ ЗначениеЗаполнено(ПериодДляОтчета) Тогда
		ПериодДляОтчета.Вариант = ВариантСтандартногоПериода.ЭтотГод;
		ДатаНачала = ПериодДляОтчета.ДатаНачала;
		ДатаОкончания = ПериодДляОтчета.ДатаОкончания;		
	КонецЕсли;	
	ЗаданиеПараметровИКомпоновкаОтчета();
	
	// ПодключаемоеОборудование
	Если ОбщийМодульКлиент.ИспользоватьПодключаемоеОборудование() И 
		МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда
		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		Если Не МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке( "При подключении оборудования произошла ошибка:") + ОписаниеОшибки ;
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
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
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("ОтборПоНоменклатуре", ЗначениеЗаполнено(ОтборПоНоменклатуре));
	отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра("Номенклатура", ОтборПоНоменклатуре);
	
	Если НЕ ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ДляУскоренияРаботыСБазойДанныхНеВыводитьДополнительныхДанных") Тогда
	Попытка 
		#Если Клиент Тогда
			Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Формируется отчет.."), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ждите.."), БиблиотекаКартинок.ОжиданиеСиниеСтрелки);
		#КонецЕсли
		ЭтаФорма.СкомпоноватьРезультат();
		Результат.показатьуровеньгруппировокстрок(0);
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
	
	// ПодключаемоеОборудование	
	Если ОбщийМодульКлиент.ИспользоватьПодключаемоеОборудование() Тогда
		ПоддерживаемыеТипыВО = Новый Массив ();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;
	// Конец ПодключаемоеОборудование
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоНоменклатуреПриИзменении(Элемент)
	ЗаданиеПараметровИКомпоновкаОтчета();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоНоменклатуреОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	ОбщийМодульКлиент.ПоискОшибкиКодировки("Номенклатура", ДанныеВыбора, Текст, ОтборПоНоменклатуре);
	ЗаданиеПараметровИКомпоновкаОтчета();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда
		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[ 1 ] = Неопределено Тогда
				ШтрихКод = Параметр[ 0 ];
			Иначе
				ШтрихКод = Параметр[ 1 ][ 1 ];
			КонецЕсли;
			Если ОбработатьПолученныйШКНаСервере(ШтрихКод) Тогда
				ЗаданиеПараметровИКомпоновкаОтчета();
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаСервере
Функция   ОбработатьПолученныйШКНаСервере(ТекКод)
	
	Если Не ТекКод = "" тогда
		РезультатОбработки = ОбщийМодульТоварСервер.ПолучитьНоменклатуруПоШтрихКоду(ТекКод);
		Если ЗначениеЗаполнено(РезультатОбработки) Тогда
			ОтборПоНоменклатуре = РезультатОбработки;
			Возврат Истина;
		Иначе
			ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Товар по Штрих-Коду не найден(") + ТекКод + ").");
			Возврат Ложь;
		КонецЕсли;       
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(ПериодДляОтчета) Тогда
        ПериодДляОтчета.Вариант = ВариантСтандартногоПериода.Вчера;
		ДатаНачала = ПериодДляОтчета.ДатаНачала;
		ДатаОкончания = конецдня(ОбщийМодульСервисСервер.ПользователяТекущаяДата());		
		ПериодДляОтчета.ДатаОкончания = ДатаОкончания;
	КонецЕсли;	
	
	Если ЗначениеЗаполнено(датаокончания) Тогда
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
