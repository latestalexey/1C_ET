﻿//sza140117-0236 : 
//sza131021-1701

&НаКлиенте
Процедура ПриОткрытии(Отказ)       // ПРИ ОТКРЫТИИ
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если ЗначениеЗаполнено(Параметры.ДокументСсылка) Тогда
		Документ = Параметры.ДокументСсылка;
		формироватьотчетподвижениям();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Документ) Тогда
		формироватьотчетподвижениям();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()            // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура формироватьотчетподвижениям()
	
	сформироватьНаСервере();
	
	Результат.ОтображатьСетку = Ложь;
	Результат.Защита          = Истина;
	Результат.ТолькоПросмотр      = Ложь;
	Результат.ОтображатьЗаголовки = Ложь;
	
КонецПроцедуры

&НаСервере
процедура сформироватьНаСервере()
	
	результат.Очистить();
	Результат.НачатьАвтогруппировкуСтрок();
	
	МетаданныеДокумента = документ.Метаданные();
	
	Макет = отчеты.ДвиженияДокумента.ПолучитьМакет("Макет");
	
	Шапка = Макет.ПолучитьОбласть("Ш");
	Шапка.Параметры.Дата  = Документ.дата;
	Шапка.Параметры.Номер = Документ.номер;
	Шапка.Параметры.НаименованиеДокумента = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(МетаданныеДокумента.ПредставлениеОбъекта);
	Результат.Вывести(Шапка, 0);
	
	СтрокаПараметра = Макет.ПолучитьОбласть("СП");    	
	
	для каждого РеквизитДокумента из МетаданныеДокумента.Реквизиты Цикл
		ЗначениеПараметра = документ[РеквизитДокумента.имя];
		Если ЗначениеЗаполнено(ЗначениеПараметра) Тогда
			СтрокаПараметра.Параметры.НаименованиеПараметра = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(РеквизитДокумента.синоним) + ":";
			СтрокаПараметра.Параметры.ЗначениеПараметра = документ[РеквизитДокумента.имя];
			
			Результат.Вывести(СтрокаПараметра, 1);	
		КонецЕсли;
	КонецЦикла;
	
	ШапкаДвижений  = Макет.ПолучитьОбласть("ШД");
	СтрокаДвижения = Макет.ПолучитьОбласть("СД");
	ШапкаСтрокиДвижений = Макет.ПолучитьОбласть("ШСД");
	
	для каждого видДвиженияДокумента из МетаданныеДокумента.Движения цикл    		
		
		Обороты = сокрлп(видДвиженияДокумента.ВидРегистра) = "Обороты";
		
			ШапкаДвижений.параметры.НаименованиеРегистра = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(видДвиженияДокумента.Представление());
		
		Результат.Вывести(ШапкаДвижений, 0);
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ";
		
		для каждого измерение из видДвиженияДокумента.Измерения цикл
			Запрос.Текст = Запрос.Текст + "	РН." + Измерение.Имя + " КАК " + Измерение.Имя + ", ";
		КонецЦикла;
		для каждого ресурс из видДвиженияДокумента.Ресурсы цикл
			Запрос.Текст = Запрос.Текст + "	РН." + ресурс.Имя + " КАК " + ресурс.Имя + ", ";
		КонецЦикла;
		для каждого реквизит из видДвиженияДокумента.реквизиты цикл
			Запрос.Текст = Запрос.Текст + "	РН." + реквизит.Имя + " КАК " + реквизит.Имя + ", ";
		КонецЦикла;
		
		Если Обороты Тогда
			Запрос.Текст = Запрос.Текст + " ""Обороты"" КАК ВидДвижения ИЗ РегистрНакопления." + видДвиженияДокумента.Имя + " КАК РН ГДЕ РН.Регистратор = &Регистратор";	
		Иначе
			Запрос.Текст = Запрос.Текст + " РН.ВидДвижения ИЗ РегистрНакопления." + видДвиженияДокумента.Имя + " КАК РН ГДЕ РН.Регистратор = &Регистратор";	
		КонецЕсли;
		
		Запрос.УстановитьПараметр("Регистратор", документ);
		
		РезультатЗапроса = Запрос.Выполнить();
		если не РезультатЗапроса.Пустой() тогда
			
			Результат.Вывести(ШапкаСтрокиДвижений, 1);
			
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				
				Если Обороты Тогда
					ВидДвижения = неопределено;
				Иначе
					ВидДвижения = ВыборкаДетальныеЗаписи.ВидДвижения;
				КонецЕсли;
				
				Измерения  = "";
				измерениеР = неопределено;
				
				для каждого измерение из видДвиженияДокумента.Измерения цикл
					ЗначениеТут = ВыборкаДетальныеЗаписи[Измерение.Имя];
					Если ЗначениеЗаполнено(ЗначениеТут) Тогда
						Измерения 	= Измерения + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(Измерение.Синоним) + ": " + ЗначениеТут + символы.ПС;
						измерениеР 	= ЗначениеТут;		
					КонецЕсли;
				КонецЦикла;
				
				ресурсы = "";
				для каждого ресурс из видДвиженияДокумента.ресурсы цикл
					ЗначениеТут = ВыборкаДетальныеЗаписи[ресурс.Имя];
					Если ЗначениеЗаполнено(ЗначениеТут) Тогда
						ресурсы = ресурсы + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(ресурс.Синоним) + ": " + ЗначениеТут + символы.ПС;	
					КонецЕсли;
				КонецЦикла;
				
				реквизиты = "";
				реквизитР = Неопределено;
				для каждого реквизит из видДвиженияДокумента.реквизиты цикл
					ЗначениеТут = ВыборкаДетальныеЗаписи[реквизит.Имя];
					Если ЗначениеЗаполнено(ЗначениеТут) Тогда
						реквизиты = реквизиты + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(реквизит.Синоним) + ": " + ЗначениеТут + символы.ПС;
						реквизитР = ЗначениеТут;	
					КонецЕсли;
				КонецЦикла;
				
				реквизиты = сред(реквизиты,0, стрдлина(реквизиты) - 1 );
				ресурсы   = сред(ресурсы,0, стрдлина(ресурсы) - 1 );
				Измерения = сред(Измерения,0, стрдлина(Измерения) - 1 );
				
				Если Обороты Тогда
					СтрокаДвижения.Параметры.виддвижения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обороты");	
				Иначе
					СтрокаДвижения.Параметры.виддвижения = ВидДвижения;	
				КонецЕсли;
				СтрокаДвижения.параметры.реквизиты 	= реквизиты;		
				СтрокаДвижения.параметры.измерения 	= измерения;
				СтрокаДвижения.параметры.измерениеР = измерениеР;
				СтрокаДвижения.параметры.реквизитР 	= реквизитР;
				СтрокаДвижения.параметры.ресурсы 	= ресурсы;
				
				Результат.Вывести(СтрокаДвижения, 1);
			КонецЦикла;
		КонецЕсли;		
	КонецЦикла;                        		
	
	Результат.ЗакончитьАвтогруппировкуСтрок();
	ПроверитьНеобходимостьДобавитьДату();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОтчет(Команда)
	формироватьотчетподвижениям();
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
