﻿//sza140104-0204 : 
//sza131005-0202 : 

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, истина);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = Истина;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПоддержкаДругихЯзыков = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ПоддерживатьИныеЯзыкиКромеРусского") 
	И ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского", Истина);
	
	если ПоддержкаДругихЯзыков 
		и ЗначениеЗаполнено(Объект.Ссылка) тогда
		
		Наименование = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(объект.Ссылка);
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗначенияНаДругихЯзыках.Язык,
		|	ЗначенияНаДругихЯзыках.НаЯзыке,
		|	ЗначенияНаДругихЯзыках.Поле
		|ИЗ
		|	РегистрСведений.ЗначенияНаДругихЯзыках КАК ЗначенияНаДругихЯзыках
		|ГДЕ
		|	ЗначенияНаДругихЯзыках.ОбъектБазыДанных = &ОбъектБазыДанных";
		
		Запрос.УстановитьПараметр("ОбъектБазыДанных", Объект.Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		если не РезультатЗапроса.Пустой() тогда
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				Если ВыборкаДетальныеЗаписи.Поле = "Наименование" Тогда
					СтрокаЯзыка = НаименованияНаДругихЯзыках.Добавить();
					СтрокаЯзыка.Язык 	= ВыборкаДетальныеЗаписи.Язык;
					СтрокаЯзыка.НаЯзыке = ВыборкаДетальныеЗаписи.НаЯзыке;	
				КонецЕсли;
			КонецЦикла;
			
		КонецЕсли;
		
	иначе
		Наименование = объект.Наименование;
		
	КонецЕсли;	
	

КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
		
	объект.Наименование = Наименование;
	НаименованиеИзменяли = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеНаДругихЯзыках(Команда)
	Элементы.НаименованияНаДругихЯзыках.Видимость  = НЕ Элементы.НаименованияНаДругихЯзыках.Видимость;
КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахНаЯзыкеПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = Истина;
КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = Истина;
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	если ПоддержкаДругихЯзыков тогда
		если НаименованиеИзменяли тогда
			ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, Наименование);
		КонецЕсли;
		
		Если БылиИзмененияЗначенияПолейНаЯзыках Тогда
			Для Каждого СтрокаЯзыка Из НаименованияНаДругихЯзыках Цикл
				ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, СтрокаЯзыка.НаЯзыке, "Наименование", СтрокаЯзыка.Язык);	
			КонецЦикла;
			ОбновитьПовторноИспользуемыеЗначения();
		КонецЕсли;
	
	конецесли;

КонецПроцедуры

&НаКлиенте
Процедура ИзображенияПриАктивизацииСтроки(Элемент)
	
	ТекущийЭлементСписка = Элементы.Изображения.ТекущаяСтрока;
	Если ЗначениеЗаполнено(ТекущийЭлементСписка) Тогда
		 СтруктураИзображения = ОбщийМодульСервер.ПолучитьСтруктуруИзображения(ТекущийЭлементСписка);
		 ПодСсылку = СтруктураИзображения.ПодСсылку;
		 
		 элементы.СсылкаНаИзображение.Видимость    = не СтруктураИзображения.ИзображениеВБазеДанных;
		 элементы.ИзображениеВБазеДанных.Видимость = СтруктураИзображения.ИзображениеВБазеДанных;
		 
		 если СтруктураИзображения.РазмерПриОтображении = 1 тогда
			 элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.АвтоРазмер
		 иначеесли СтруктураИзображения.РазмерПриОтображении = 2 тогда
			 элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.Пропорционально
		 иначеесли СтруктураИзображения.РазмерПриОтображении = 3 тогда
			 элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.Растянуть
		 иначеесли СтруктураИзображения.РазмерПриОтображении = 4 тогда
			 элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.РеальныйРазмер
		 иначеесли СтруктураИзображения.РазмерПриОтображении = 5 тогда
			 элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.Черепица
		 конецесли; 		 
		 
	 КонецЕсли;
	 
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображение(Команда)
	
	Если НЕ ЗначениеЗаполнено(объект.Ссылка) 
		и Вопрос(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Сначала следует записать этот элемент. Записать?"), РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда
		
		Записать();			
	КонецЕсли;
		
	Если ЗначениеЗаполнено(объект.Ссылка) Тогда
		ПараметрыФормы = Новый Структура("СвязанныйОбъект", объект.Ссылка);
		формаИзображения = ПолучитьФорму("Справочник.Изображения.ФормаОбъекта", ПараметрыФормы);	
		формаИзображения.Открыть();
	КонецЕсли;
	
КонецПроцедуры
