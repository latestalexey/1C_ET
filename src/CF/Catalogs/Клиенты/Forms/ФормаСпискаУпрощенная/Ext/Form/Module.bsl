﻿//sza131211-1551 SZA: 
//sza130905-1654 : 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	ИспользоватьМагнитныеКартыКлиентов 		= ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ИспользоватьМагнитныеКартыКлиентов");
	ИспользоватьПодключаемоеОборудование 	= ПодключаемоеОборудованиеДСервер.ИспользоватьПодключаемоеОборудование();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если ИспользоватьПодключаемоеОборудование 
		и ИспользоватьМагнитныеКартыКлиентов
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда
		
		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
		
		Если Не МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка:") + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
	
	Элементы.ПроцентСкидки.Видимость = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВключитьВозможностьУказыватьПроцентСкидкиДляКлиентов");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ   	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
	
	Если ИспользоватьПодключаемоеОборудование 
		и ИспользоватьМагнитныеКартыКлиентов Тогда
		
		ПоддерживаемыеТипыВО = Новый Массив ();
		ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИспользоватьМагнитныеКартыКлиентов
		и Источник = "ПодключаемоеОборудование"
		И ВводДоступен () Тогда
		
		Если ИмяСобытия = "TracksData" Тогда
			ПолученКодИзСМК(Параметр);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолученКодИзСМК(Параметр)
	
	Если Параметр[1][3] <> Неопределено Тогда
		МКод = Параметр[1][3][0].ДанныеДорожек[0].ЗначениеПоля;
	Иначе
		МКод = Параметр[0];
	КонецЕсли;
	ПолучитьКлиента(МКод);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьКлиента(МКод)
	
	Клиент = ПолучитьКлиентаНаСервере(МКод);
	Если Клиент <> Неопределено Тогда
		ОткрытьЗначение(Клиент);
	конецесли;
	
КонецПроцедуры

&НаСервере
Функция   ПолучитьКлиентаНаСервере(МКод)
	
	Клиент = ПодключаемоеОборудованиеДСервер.НайтиКлиентаПоМК(МКод);
	Если Клиент <> Неопределено Тогда
		Возврат Клиент;
		
	Иначе
		ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Карта не найдена.");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		Возврат Неопределено;
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура СтрокаПоискаАвтоПодбор(Элемент, Текст, ДанныеВыбора, Параметры, Ожидание, СтандартнаяОбработка)	
	ОбщийМодульКлиент.АвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка);	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоискНаКлиенте()
	
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Наименование",
	СтрокаПоиска,
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	,
	ЗначениеЗаполнено(СтрокаПоиска)
	);
	
	Элементы.Список.Обновить();
	
	Если ЗначениеЗаполнено(СтрокаПоиска) Тогда
		Если НетНичего() Тогда
			
			СтрокаПоискаРус = ОбщийМодульКлиент.ПеревестиТекстНаЯзык(СтрокаПоиска, 0);  
			ОбщийМодульКлиент.УстановитьЭлементОтбора(
			Список.Отбор,
			"Наименование",
			СтрокаПоискаРус,
			?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
			,
			ЗначениеЗаполнено(СтрокаПоиска)
			);
			
			Элементы.Список.Обновить();
			
			Если НетНичего() Тогда
				
				СтрокаПоискаАнгл = ОбщийМодульКлиент.ПеревестиТекстНаЯзык(СтрокаПоиска, 1);  
				ОбщийМодульКлиент.УстановитьЭлементОтбора(
				Список.Отбор,
				"Наименование",
				СтрокаПоискаАнгл,
				?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
				,
				ЗначениеЗаполнено(СтрокаПоиска)
				);
				
				Элементы.Список.Обновить();
				
				если не НетНичего() Тогда
					СтрокаПоиска = СтрокаПоискаАнгл;
				КонецЕсли;
				
			Иначе
				СтрокаПоиска = СтрокаПоискаРус;
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция   НетНичего()	
	Возврат Элементы.Список.ТекущиеДанные = Неопределено;	
КонецФункции //НетНичего

&НаКлиенте
Процедура НайтиПоТочномуСоответствиюПриИзменении(Элемент)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры
