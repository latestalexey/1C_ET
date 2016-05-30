﻿//sza140119-1600 
//sza131014-1519

&НаКлиенте
Процедура Готово(Команда)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Номенклатура", Номенклатура);
	СтруктураПараметров.Вставить("СерияНоменклатуры", СерияНоменклатуры);
	Если НЕ БлокВидаЦенИЦены Тогда
		СтруктураПараметров.Вставить("Цена", Цена);
	КонецЕсли;
	
	СтруктураПараметров.Вставить("Количество", Количество);	
	СтруктураПараметров.Вставить("ВидЦен", ВидЦен);
	
	Если НЕ ЗначениеЗаполнено(Номенклатура) Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Номенклатура не указана");
		Сообщение.Поле 	= "Номенклатура";
		Сообщение.Сообщить();
		
	ИначеЕсли ОбщийМодульПовтор.ТоварВедетсяПоСериям(Номенклатура)
		и НЕ ЗначениеЗаполнено(СерияНоменклатуры) Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Серия номенклатуры не указана");
		Сообщение.Поле 	= "СерияНоменклатуры";
		Сообщение.Сообщить();
		
	Иначе
		Закрыть(СтруктураПараметров);
		глПроверятьСообщения = Истина;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если ИспользоватьШтрихКоды тогда 		
		ЭтаФорма.ТекущийЭлемент = Элементы.ШтрихКод;
		
		Если ИспользоватьПодключаемоеОборудование И 
			МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда
			
			ОписаниеОшибки = "" ;
			ПоддерживаемыеТипыВО = Новый Массив();
			ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
			
			Если Не МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
				ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке( "При подключении оборудования произошла ошибка:") + ОписаниеОшибки ;
				ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
			КонецЕсли;
		КонецЕсли;
		
	Иначе
		ЭтаФорма.ТекущийЭлемент = Элементы.Номенклатура;
	КонецЕсли;
	
	элементы.ВидЦен.ТолькоПросмотр = ИспользоватьСложныйМеханизмЦен И БлокВидаЦенИЦены;
	элементы.Цена.ТолькоПросмотр   = БлокВидаЦенИЦены;
	элементы.Сумма.ТолькоПросмотр  = БлокВидаЦенИЦены;
	
	ОбновитьДанныеПоОстаткам();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
	
	Если ИспользоватьПодключаемоеОборудование Тогда
		ПоддерживаемыеТипыВО = Новый Массив ();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть(Неопределено);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	ИспользоватьПодключаемоеОборудование = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ИспользоватьПодключаемоеОборудование");
	ИспользоватьСложныйМеханизмЦен 		 = ОбщийМодульПовтор.ПолучитьПараметрСеанса("ИспользоватьСложныйМеханизмЦенПС");
	ИспользоватьШтрихКоды 				 = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ИспользоватьШтрихКоды") ;
	ВызовИзРасходаТовара 				 = параметры.ВызовИзРасходаТовара;
	
	ВидЦен = Параметры.ВидЦен;      			
	если НЕ ЗначениеЗаполнено(ВидЦен) Тогда
		ВидЦен = ОбщийМодульПовтор.ЗначениеПредопределенного("Справочники.ВидыЦен.ОсновнойВидЦен");	
	КонецЕсли;
	
	Дата = Параметры.Дата;
	Если дата = '00010101000000'  Тогда
		дата = ОбщийМодульСервисСервер.ПользователяТекущаяДата();
	КонецЕсли;
	
	БлокВидаЦенИЦены 	= Параметры.БлокВидаЦенИЦены или ОбщийМодульПовтор.ПолучитьПараметрСеанса("НеМожетМенятьЦены");	
	Количество 			= 1;	
	УчетПоСкладам 		= ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоСкладам") ;
	
	Если не параметры.БезКоличества тогда
		если ЗначениеЗаполнено(Параметры.Склад) Тогда
			Склад = Параметры.Склад;
		иначе
			Склад = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("СкладПоУмолчанию") ;
		КонецЕсли;
		
	иначе
		элементы.Склад.Видимость = Ложь;
	КонецЕсли;	
	
	БезКоличества = параметры.БезКоличества;
	
	если параметры.БезКоличества Тогда
		
		элементы.Количество.Видимость 	= Ложь;
		элементы.Склад.Видимость 		= Ложь;
		элементы.ОстатокПосле.Видимость = Ложь;
		
	ИначеЕсли параметры.ЭтоДобавка Тогда
		элементы.ОстатокПосле.Видимость = Ложь;
		
	КонецЕсли;      	
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДанныеПоОстаткам()
	
	артикул  = Номенклатура.артикул;
	ШтрихКод = Номенклатура.ОсновнойШтрихКод;
	
	Если УчетПоСкладам 
		и ЗначениеЗаполнено(склад)
		и ЗначениеЗаполнено(номенклатура) Тогда
		
		ОстатокНаСкладе = ОбщийМодульСервер.ПолучитьОстатокТовара(номенклатура, Склад, Дата, Истина);  		
		ОстатокПосле 	= ОстатокНаСкладе - Количество;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда
		
		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[ 1 ] = Неопределено Тогда
				ШтрихКод = Параметр[ 0 ];
			Иначе
				ШтрихКод = Параметр[ 1 ][ 1 ];
			КонецЕсли;
			
			ОбработатьПолученныйШКНаСервере(ШтрихКод);
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьПолученныйШКНаСервере(ТекКод)
	
	Если Не ТекКод = "" тогда
		
		РезультатОбработки = ОбщийМодульТоварСервер.ПолучитьНоменклатуруПоШтрихКоду(ТекКод, Истина);
		
		Если ЗначениеЗаполнено(РезультатОбработки) Тогда
			ДобавитьПозициюНоменклатуры(РезультатОбработки);			
		Иначе
			ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Товар по Штрих-Коду не найден(") + ТекКод + ").");
		КонецЕсли;               	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьПозициюНоменклатуры(РезультатОбработки)
	
	Если ТипЗнч(РезультатОбработки) = Тип("СправочникСсылка.Номенклатура") Тогда
		Номенклатура 	  = РезультатОбработки;
	Иначе
		Номенклатура 	  = РезультатОбработки.Номенклатура;
		СерияНоменклатуры = РезультатОбработки.СерияНоменклатуры;
	КонецЕсли;
	
	Артикул	= Номенклатура.Артикул;
	ПересчетЦены();	
	ОбновитьДанныеПоОстаткам();
	
КонецПроцедуры

&НаКлиенте
Процедура ШтрихКодПриИзменении(Элемент)
	
	ОбработатьПолученныйШКНаСервере(ШтрихКод);
	НоменклатураВыбрана();
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураПриИзменении(Элемент)
	НоменклатураВыбрана();	
КонецПроцедуры

&НаСервере
Процедура ПересчетЦены()
	
	Цена 	   = ОбщийМодульСервер.ПолучитьЦенуНаСервере(Номенклатура, ВидЦен, Дата, Истина);
	Количество = ОбщийМодульСервер.ПолучитьКоличествоПоУмолчанию(Номенклатура);
	Сумма 	   = Цена * Количество;
	
КонецПроцедуры

&НаКлиенте
Процедура ВидЦенПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(номенклатура) Тогда 		
		ПересчетЦены();
		
		Если не цена = 0 Тогда
			ЭтаФорма.ТекущийЭлемент = Элементы.Количество;	
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЦенаПриИзменении(Элемент)
	
	Сумма = Цена * Количество;
	
	Если БезКоличества Тогда
		этаформа.ТекущийЭлемент = элементы.готово;	
	иначе
		этаформа.ТекущийЭлемент = элементы.Количество;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоПриИзменении(Элемент)
	
	ОстатокПосле = ОстатокНаСкладе - Количество;	
	Сумма 		 = Цена * Количество;
	
	Если НЕ Количество = 0
		и не цена = 0 
		и ЗначениеЗаполнено(Номенклатура) Тогда
		
		ЭтаФорма.ТекущийЭлемент = Элементы.Готово;
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СуммаПриИзменении(Элемент)
	
	если НЕ Количество = 0 тогда
		Цена = Сумма / Количество;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ШтрихКодОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ложь;
	
	ОбработатьПолученныйШКНаСервере(ШтрихКод);
	НоменклатураВыбрана();
	
КонецПроцедуры

&НаКлиенте
Процедура АртикулПриИзменении(Элемент)
	
	АртикулПриИзмененииНаСервере();
	НоменклатураВыбрана();
	
КонецПроцедуры

&НаСервере
Процедура АртикулПриИзмененииНаСервере()
	
	Если не артикул = "" Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1 Номенклатура.Ссылка
		|ИЗ Справочник.Номенклатура КАК Номенклатура
		|ГДЕ Номенклатура.Артикул ПОДОБНО &Артикул";
		
		Запрос.УстановитьПараметр("Артикул", Артикул);
		
		РезультатЗапроса = Запрос.Выполнить();
		если не результатзапроса.Пустой() тогда
			
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				ДобавитьПозициюНоменклатуры(ВыборкаДетальныеЗаписи.ссылка);
			КонецЦикла;
			
		иначе
			ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Товар по Артикулу не найден(") + Артикул + ").");		 	
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	ОбщийМодульКлиент.ПоискОшибкиКодировки("Номенклатура", ДанныеВыбора, Текст, Номенклатура);
	
	Если ЗначениеЗаполнено(ДанныеВыбора) Тогда
		НоменклатураВыбрана();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураВыбрана()
	
	если ЗначениеЗаполнено(Номенклатура) тогда		
		
		ОбновитьДанныеПоОстаткам();
		ПересчетЦены();
		
		если не цена = 0 Тогда
			
			если БезКоличества тогда
				ЭтаФорма.ТекущийЭлемент = элементы.Готово;				
			иначе
				ЭтаФорма.ТекущийЭлемент = Элементы.Количество;	
			КонецЕсли;
			
		иначе
			ЭтаФорма.ТекущийЭлемент = Элементы.Цена;	
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура АртикулОткрытие(Элемент, СтандартнаяОбработка)
	
	АртикулПриИзмененииНаСервере();
	НоменклатураВыбрана();
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка 	= Ложь;    	
	ПараметрыФормы 			= Новый Структура;
	
	Если ИспользоватьСложныйМеханизмЦен
		и ЗначениеЗаполнено(ВидЦен) Тогда
		
		ПараметрыФормы.Вставить("ВидЦен", ВидЦен);
	КонецЕсли;	
	
	Если УчетПоСкладам
		и ЗначениеЗаполнено(Склад) Тогда
		
		ПараметрыФормы.Вставить("ОтборПоСкладу", Склад);
	КонецЕсли;	
	
	ПараметрыФормы.Вставить("ОтборПоДате", Дата);
	ПараметрыФормы.Вставить("ОтборПоДате", Дата);
	ПараметрыФормы.Вставить("ИзПеремещения", ИзПеремещения);
	ПараметрыФормы.Вставить("ВызовИзРасходаТовара", ВызовИзРасходаТовара);
	ПараметрыФормы.Вставить("ТекущаяСтрока", Номенклатура);
	
	ФормаВыбора = ПолучитьФорму("Справочник.Номенклатура.ФормаВыбора", ПараметрыФормы);
	
	НоменклатураОтвет = ФормаВыбора.ОткрытьМодально();
	Если ЗначениеЗаполнено(НоменклатураОтвет) Тогда
		Номенклатура = НоменклатураОтвет;	
		
		НоменклатураВыбрана();
	КонецЕсли;
	
КонецПроцедуры
