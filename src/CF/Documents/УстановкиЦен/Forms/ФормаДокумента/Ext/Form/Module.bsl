﻿//sza140119-0056 
//sza130920-1546 : 

&НаКлиенте
Процедура ДобавитьНоменклатуруДругогоДокумента(Команда)
	
	СписокТиповДокументов = Новый СписокЗначений;
	СписокТиповДокументов.Добавить("Корректировки И Регистрация Остатков");
	СписокТиповДокументов.Добавить("Инвентаризации");
	СписокТиповДокументов.Добавить("Расходы Товара");
	СписокТиповДокументов.Добавить("Поступления Товара");
	СписокТиповДокументов.Добавить("Перемещения Товара");
	СписокТиповДокументов.Добавить("Установки Цен");
	СписокТиповДокументов.Добавить("Планы продаж");
	
	ТипДокументаДляДобавления = ВыбратьИзСписка(СписокТиповДокументов, , СписокТиповДокументов[0]);
	
	если не ТипДокументаДляДобавления = Неопределено тогда
		ТипДокументаДляДобавления = стрзаменить(ТипДокументаДляДобавления, " ", "");
		
		ФормаВыбораДокумента = ПолучитьФорму("Документ." + ТипДокументаДляДобавления + ".ФормаВыбора");
		
		ФормаВыбораДокумента.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите Документ для добавления его номенклатуры в Установку цен: ");
		ДругойДокумент = ФормаВыбораДокумента.ОткрытьМодально();
		Если ЗначениеЗаполнено(ДругойДокумент) Тогда
			Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
			ДобавитьНоменклатуруДругогоДокументаНаСервере();      	
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	Если ОбщийМодульПовтор.ПолучитьПараметрСеанса("НеМожетМенятьЦены") тогда
		отказ = истина;
	КонецЕсли;
	
	ИспользоватьПодключаемоеОборудование  = ПодключаемоеОборудованиеДСервер.ИспользоватьПодключаемоеОборудование();
	ИспользоватьСложныйМеханизмЦен 		  = ОбщийМодульПовтор.ПолучитьПараметрСеанса("ИспользоватьСложныйМеханизмЦенПС");	
	СопровождатьНоменклатуруИзображениями = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("СопровождатьНоменклатуруИзображениями") ;
	ПоказыватьИзображения = СопровождатьНоменклатуруИзображениями;
	
	Элементы.ТоварыВводСКоличеством.Видимость = не ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("НеПоказыватьКомандуДобавленияНоменклатурыСКоличеством") ;
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Если НЕ ЗначениеЗаполнено(Объект.ВидЦен) Тогда
			Объект.ВидЦен = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВидЦенРасходованияПоУмолчанию") ;
		КонецЕсли;		
		
		Если ЗначениеЗаполнено(Объект.ВидЦен)
			и объект.ВидЦен.Зависимая Тогда
			
			объект.ВидЦен = ОбщийМодульПовтор.ЗначениеПредопределенного("Справочники.ВидыЦен.ПустаяСсылка()");
		КонецЕсли;
		
		Объект.Дата = ОбщийМодульСервисСервер.ПользователяТекущаяДата();
		
	КонецЕсли;	
	    
	проверитьЗависимостьВидаЦен();
	
	Элементы.ТоварыПодборНоменклатуры.Видимость = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВключитьМеханизмПодбораНоменклатуры");
	
КонецПроцедуры

&НаСервере
Процедура проверитьЗависимостьВидаЦен()
	
	Если ЗначениеЗаполнено(Объект.ВидЦен) Тогда
		ЭтоЗависимаяЦена = Объект.ВидЦен.Зависимая;
	Иначе
		ЭтоЗависимаяЦена = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьНоменклатуруДругогоДокументаНаСервере()
	
	Если ЗначениеЗаполнено(ДругойДокумент) Тогда		
		Объект.Товары.Загрузить(ДругойДокумент.Товары.Выгрузить());		
		Для Каждого СтрокаТовара Из Объект.Товары Цикл
			СтрокаТовара.СтараяЦена = СтрокаТовара.Цена;	
		Конеццикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент)
	ПриИзмененииНоменклатуры() 	;	
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииНоменклатуры(СтрокаТовара = Неопределено) 	
	
	Если СтрокаТовара = Неопределено Тогда
		СтрокаТовара = Элементы.Товары.ТекущиеДанные;	
	КонецЕсли;

	СтрокаТовара.СтараяЦена  = ОбщийМодульСервер.ПолучитьСложнуюЦену(СтрокаТовара.Номенклатура, Объект.ВидЦен, Объект.Дата - 1, Ложь );
	СтрокаТовара.Цена 		 = ОбщийМодульСервер.РассчитатьНовуюЦену(СтрокаТовара.Номенклатура, СтрокаТовара.СтараяЦена, Объект.ВидЦен, Объект.Дата, объект.Ссылка);
	СтрокаТовара.РазницаЦены = СтрокаТовара.Цена - СтрокаТовара.СтараяЦена;
	
	ПоказатьТовар();
	
КонецПроцедуры

&НаСервере
Функция   ВыяснитьЦенуВсехСоставляющихНабора(Номенклатура)
	
	Сумма = 0;
	
	для каждого строкасоставанабора из номенклатура.состав цикл
		Если строкасоставанабора.номенклатура.этонабор = ИСТИНА Тогда
			сумма = сумма + ВыяснитьЦенуВсехСоставляющихНабора(строкасоставанабора.номенклатура);
		Иначе
			сумма = сумма + (ОбщийМодульСервер.ПолучитьЦенуНаСервере(строкасоставанабора.номенклатура, объект.ВидЦен, объект.Дата -1, истина, , , , , Объект.Ссылка) * строкасоставанабора.количество);
		КонецЕсли;
	КонецЦикла;	
	
	Возврат Сумма;
	
КонецФункции //ВыяснитьЦенуВсехСоставляющихНабора

&НаКлиенте
Процедура ВидЦенПриИзменении(Элемент)
	
	проверитьЗависимостьВидаЦен();
	ПроверитьВидЦенЗависимый();
	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
	ВидЦенПриИзмененииНаСервере();
	
КонецПроцедуры

&НаСервере
процедура ВидЦенПриИзмененииНаСервере()
	
	Если НЕ ДокументЗаблокирован 
		и ЗначениеЗаполнено(Объект.ВидЦен) Тогда
		
		Для Каждого СтрокаТовара из Объект.Товары Цикл
			СтрокаТовара.СтараяЦена 	= ОбщийМодульСервер.ПолучитьСложнуюЦену(СтрокаТовара.Номенклатура, Объект.ВидЦен, Объект.Дата - 1, Ложь );
			СтрокаТовара.Цена 			= ОбщийМодульСервер.РассчитатьНовуюЦену(СтрокаТовара.Номенклатура, СтрокаТовара.СтараяЦена, Объект.ВидЦен, Объект.Дата, Объект.Ссылка);
			СтрокаТовара.РазницаЦены 	= СтрокаТовара.Цена - СтрокаТовара.СтараяЦена;	
		КонецЦикла;                       	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТаблицу(Команда)
	
	Если Вопрос(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Вы готовы очистить таблицу документа?"), РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда
		ОчиститьТаблицуНаСервере();	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОчиститьТаблицуНаСервере()
	
	Объект.Товары.Очистить();
	Попытка 
		Объект.ТовараВКоличестве = 0;
		Объект.ТовараНаСумму 	 = 0;
	Исключение 	
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПоПроизводителю(Команда)
	
	ФормаВыбораПроизводителя = ПолучитьФорму("Справочник.Производители.ФормаВыбора");
	ФормаВыбораПроизводителя.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите Производителя для добавления его номенклатуры в установку цен: ");
	Производитель = ФормаВыбораПроизводителя.ОткрытьМодально();
	Если ЗначениеЗаполнено(Производитель) Тогда
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
		ДобавитьПоПроизводителюНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьПоПроизводителюНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Номенклатура.Ссылка,
	|	Номенклатура.Цена
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.Производитель = &Производитель";
	
	Запрос.УстановитьПараметр("Производитель", Производитель);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СтруктураОтбора = Новый Структура;
			СтруктураОтбора.Вставить("Номенклатура", ВыборкаДетальныеЗаписи.ссылка);
			если Объект.Товары.НайтиСтроки(СтруктураОтбора).Количество() = 0 Тогда
				НоваяСтрока = Объект.Товары.Добавить();
				НоваяСтрока.номенклатура = ВыборкаДетальныеЗаписи.Ссылка;
				
				Если ИспользоватьСложныйМеханизмЦен Тогда
					НоваяСтрока.СтараяЦена = ОбщийМодульСервер.ПолучитьСложнуюЦену(НоваяСтрока.номенклатура, Объект.ВидЦен, Объект.Дата, Ложь);
				иначе
					НоваяСтрока.СтараяЦена = ВыборкаДетальныеЗаписи.Цена;
				КонецЕсли;
				ПересчитатьСтрокуНаСервере(НоваяСтрока);		
			КонецЕсли;
		КонецЦикла;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПоГруппеНоменклатуры(Команда)
	
	ФормаВыбораГруппыНоменклатуры = ПолучитьФорму("Справочник.Номенклатура.ФормаВыбораГруппы");
	ФормаВыбораГруппыНоменклатуры.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите Группу номенклатуры для добавления в установку цен: ");
	ГруппаНоменклатуры = ФормаВыбораГруппыНоменклатуры.ОткрытьМодально();
	Если ЗначениеЗаполнено(ГруппаНоменклатуры) Тогда
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
		ДобавитьПогруппеНоменклатурыНаСервере();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьПоГруппеНоменклатурыНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Номенклатура.Ссылка,
	|	Номенклатура.Цена
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.Родитель = &Родитель
	|	И Номенклатура.ЭтоГруппа = Ложь";
	
	Запрос.УстановитьПараметр("Родитель", ГруппаНоменклатуры);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СтруктураОтбора = Новый Структура;
			СтруктураОтбора.Вставить("Номенклатура", ВыборкаДетальныеЗаписи.ссылка);
			если Объект.Товары.НайтиСтроки(СтруктураОтбора).Количество() = 0 Тогда
				НоваяСтрока = Объект.Товары.Добавить();
				НоваяСтрока.номенклатура = ВыборкаДетальныеЗаписи.Ссылка;
				
				Если ИспользоватьСложныйМеханизмЦен Тогда
					НоваяСтрока.СтараяЦена = ОбщийМодульСервер.ПолучитьСложнуюЦену(НоваяСтрока.номенклатура, Объект.ВидЦен, Объект.Дата - 1, Ложь);
				иначе
					НоваяСтрока.СтараяЦена = ВыборкаДетальныеЗаписи.Цена;
				КонецЕсли;
				ПересчитатьСтрокуНаСервере(НоваяСтрока);		
			КонецЕсли;
		КонецЦикла;           	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПоНоменклатурнойГруппе(Команда)
	
	ФормаНоменклатурнойГруппы = ПолучитьФорму("Справочник.НоменклатурныеГруппы.ФормаВыбора");
	ФормаНоменклатурнойГруппы.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Укажите Номенклатурную Группу для добавления её номенклатуры в установку цен: ");
	НоменклатурнаяГруппа = ФормаНоменклатурнойГруппы.ОткрытьМодально();
	
	Если ЗначениеЗаполнено(НоменклатурнаяГруппа) Тогда
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
		ДобавитьПоНоменклатурнойГруппеНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьПоНоменклатурнойГруппеНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Номенклатура.Ссылка,
	|	Номенклатура.Цена
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.НоменклатурнаяГруппа = &НоменклатурнаяГруппа";
	
	Запрос.УстановитьПараметр("НоменклатурнаяГруппа", НоменклатурнаяГруппа);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда	
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СтруктураОтбора = Новый Структура;
			СтруктураОтбора.Вставить("Номенклатура", ВыборкаДетальныеЗаписи.ссылка);
			если Объект.Товары.НайтиСтроки(СтруктураОтбора).Количество() = 0 Тогда
				НоваяСтрока = Объект.Товары.Добавить();
				НоваяСтрока.номенклатура = ВыборкаДетальныеЗаписи.Ссылка;
				
				Если ИспользоватьСложныйМеханизмЦен Тогда
					НоваяСтрока.СтараяЦена = ОбщийМодульСервер.ПолучитьСложнуюЦену(НоваяСтрока.номенклатура, Объект.ВидЦен, Объект.Дата - 1, Ложь);
				иначе
					НоваяСтрока.СтараяЦена = ВыборкаДетальныеЗаписи.Цена;
				КонецЕсли;
				
				ПересчитатьСтрокуНаСервере(НоваяСтрока);		
			КонецЕсли;
		КонецЦикла;     	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
процедура ПересчитатьСтрокуНаСервере(СтрокаТовара)
	
	СтрокаТовара.Цена 			= ОбщийМодульСервер.РассчитатьНовуюЦену(СтрокаТовара.Номенклатура, СтрокаТовара.СтараяЦена, Объект.ВидЦен, Объект.Дата, Объект.Ссылка);
	СтрокаТовара.РазницаЦены 	= СтрокаТовара.Цена - СтрокаТовара.СтараяЦена;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	СтрокаТовара = Элементы.Товары.ТекущиеДанные;
	СтрокаТовара.РазницаЦены = СтрокаТовара.Цена - СтрокаТовара.СтараяЦена;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыРазницаЦеныПриИзменении(Элемент)
	
	СтрокаТовара = Элементы.Товары.ТекущиеДанные;
	СтрокаТовара.Цена = СтрокаТовара.СтараяЦена + СтрокаТовара.РазницаЦены;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВсюНоменклатуру(Команда)
	
	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
	ДобавитьВсюНоменклатуруНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьВсюНоменклатуруНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Номенклатура.Ссылка,
	|	Номенклатура.Цена
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.ЭтоГруппа = Ложь";
	
	Запрос.УстановитьПараметр("НоменклатурнаяГруппа", НоменклатурнаяГруппа);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СтруктураОтбора = Новый Структура;
			СтруктураОтбора.Вставить("Номенклатура", ВыборкаДетальныеЗаписи.ссылка);
			если Объект.Товары.НайтиСтроки(СтруктураОтбора).Количество() = 0 Тогда
				НоваяСтрока = Объект.Товары.Добавить();
				НоваяСтрока.номенклатура = ВыборкаДетальныеЗаписи.Ссылка;
				Если ИспользоватьСложныйМеханизмЦен Тогда
					НоваяСтрока.СтараяЦена = ОбщийМодульСервер.ПолучитьСложнуюЦену(НоваяСтрока.номенклатура, Объект.ВидЦен, Объект.Дата -1 , Ложь);
				иначе
					НоваяСтрока.СтараяЦена = ВыборкаДетальныеЗаписи.Цена;
				КонецЕсли;
				
				ПересчитатьСтрокуНаСервере(НоваяСтрока);		
			КонецЕсли;
		КонецЦикла;   	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьУчетнымиДанными(Команда)
	
	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
	ЗаполнитьУчетнымиДаннымиНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьУчетнымиДаннымиНаСервере()
	
	Объект.Товары.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТоварыОстатки.СуммаОстаток,
	|	ТоварыОстатки.КоличествоОстаток,
	|	ТоварыОстатки.Склад,
	|	ТоварыОстатки.Номенклатура
	|ИЗ
	|	РегистрНакопления.Товары.Остатки(&ДатаОстатка, ) КАК ТоварыОстатки ";
	
	Запрос.УстановитьПараметр("ДатаОстатка", Объект.Дата);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			строкатовары = Объект.Товары.Добавить();
			строкатовары.Номенклатура 	= ВыборкаДетальныеЗаписи.номенклатура;
			строкатовары.СтараяЦена 	= ОбщийМодульСервер.ПолучитьЦенуНаСервере(строкатовары.Номенклатура, Объект.ВидЦен, Объект.Дата - 1, Истина, , , , , Объект.Ссылка);
			ПересчитатьСтрокуНаСервере(строкатовары);
		КонецЦикла;   	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВводШтрихКода(Команда)
	
	ТекКод = "";
	Если ВвестиШтрихКод(ТекКод) Тогда
		если не ОбработатьПолученныйШКНаСервере(ТекКод) тогда
			ОбщийМодульКлиент.ВыдатьСигнал(ТекКод); 
		конецесли;		
	КонецЕсли;                              	
	
КонецПроцедуры

&НаКлиенте
Функция   ВвестиШтрихКод(ШтрихКод, ТекстЗаголовка = "") Экспорт
	
	Результат = Ложь;
	
	Если НЕ ЗначениеЗаполнено(ТекстЗаголовка) Тогда
		ТекстЗаголовка = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Введите ШтрихКод");
	КонецЕсли;
	
	ШтрихКод = "";
	Если ВвестиЗначение(ШтрихКод, ТекстЗаголовка) Тогда
		Если Не ПустаяСтрока(ШтрихКод) Тогда
			Результат = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция   ОбработатьПолученныйШКНаСервере(ТекКод, Количество = 1)
	
	Результат = Истина;
	
	РезультатОбработки = ОбщийМодульТоварСервер.ПолучитьНоменклатуруПоШтрихКоду(ТекКод);
	Если ЗначениеЗаполнено(РезультатОбработки) Тогда
		ДобавитьПозициюНоменклатуры(РезультатОбработки);
	Иначе
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Товар по Штрих-Коду не найден(") + ТекКод + ").");
		Результат = Ложь;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ДобавитьПозициюНоменклатуры(НоменклатураВх)
	
	Если ТипЗнч(НоменклатураВх) = Тип("СправочникСсылка.Номенклатура") Тогда  		
		Номенклатура = НоменклатураВх;
		Цена = 0;
		ЦенаЕсть = Ложь;
		
	Иначе
		Номенклатура = НоменклатураВх.Номенклатура;
		Цена = 0;
		ЦенаЕсть = НоменклатураВх.Свойство("Цена", Цена);
		
	КонецЕсли; 
	
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("Номенклатура", Номенклатура);
	
	СтрокаТовара = Объект.Товары.НайтиСтроки(ПараметрыОтбора);
	если не ДокументЗаблокирован Тогда
		
		Если СтрокаТовара.Количество() = 0 Тогда
			СтрокаТовара = Объект.Товары.Добавить();	
			СтрокаТовара.СтараяЦена = ОбщийМодульСервер.ПолучитьЦенуНаСервере(строкатовара.Номенклатура, Объект.ВидЦен, Объект.Дата - 1, Истина, , , , , Объект.Ссылка);
		иначе
			СтрокаТовара = СтрокаТовара[0];
		КонецЕсли;
		
		СтрокаТовара.Номенклатура = Номенклатура;
		Если ЦенаЕсть Тогда
			СтрокаТовара.Цена = Цена;
		конецесли;
		
		Элементы.Товары.ТекущаяСтрока = СтрокаТовара.ПолучитьИдентификатор();
		Элементы.Товары.ТекущийЭлемент = элементы.ТоварыЦена;
		
	иначеЕсли НЕ СтрокаТовара.Количество() = 0 Тогда //Встать на строку
		СтрокаТовара = СтрокаТовара[0];
		Элементы.Товары.ТекущаяСтрока = СтрокаТовара.ПолучитьИдентификатор();
		Элементы.Товары.ТекущийЭлемент = элементы.ТоварыЦена;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	если НЕ ПараметрыЗаписи.режимзаписи = РежимЗаписиДокумента.Запись тогда
		ОбработатьБлокировку();                                                	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
процедура ОбработатьБлокировку(ПриСозданииФормы = ложь)
	
	Если ОбщийМодульСервер.ОбработатьБлокировку(Объект, ЭтаФорма, ПриСозданииФормы) Тогда			
		Элементы.ОбработкаТаблицы.Доступность 				= Ложь;
		Элементы.ТоварыВводШтрихКода.Доступность 			= Ложь;
		Элементы.ТоварыВводСКоличеством.Доступность 		= Ложь;
		Элементы.ТоварыСоздатьТоварИДобавить.Доступность 	= Ложь;
		
	Иначе
		Элементы.ОбработкаТаблицы.Доступность 				= Истина;
		Элементы.ТоварыВводШтрихКода.Доступность 			= Истина;
		Элементы.ТоварыВводСКоличеством.Доступность 		= истина;
		Элементы.ТоварыСоздатьТоварИДобавить.Доступность 	= Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, истина);
	Если НЕ ЗначениеЗаполнено(объект.ссылка) Тогда
		ПроверитьВидЦенЗависимый();  	
	Иначе
		ОбработатьБлокировку(Истина);
	КонецЕсли;
	
	Если ИспользоватьПодключаемоеОборудование И 
		МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда
		
		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		Если Не МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке( "При подключении оборудования произошла ошибка:") + " " + Описаниеошибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВидЦенЗависимый()
	
	Если ЭтоЗависимаяЦена
		И Вопрос(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Этот Вид Цен - Зависимый.") + символы.ПС + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Рекомендуется устанавливать только базовые.") + символы.ПС + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Все равно использовать?"), РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Нет Тогда
		
		ОчиститьВидЦен();
	КонецЕсли;
	
КонецПроцедуры	

&НаСервере
Процедура ОчиститьВидЦен()	
	Объект.ВидЦен = Справочники.ВидыЦен.ПустаяСсылка() ;	
КонецПроцедуры //ОчиститьВидЦен

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ   	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
	
	Если ИспользоватьПодключаемоеОборудование Тогда
		ПоддерживаемыеТипыВО = Новый Массив ();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда
		
		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[ 1 ] = Неопределено Тогда
				ТекКод = Параметр[ 0 ];
			Иначе
				ТекКод = Параметр[ 1 ][ 1 ];
			КонецЕсли;
			
			ОбработатьПолученныйШКНаКлиенте(ТекКод);
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьПолученныйШКНаклиенте(ТекКод)
	
	если не ОбработатьПолученныйШКНаСервере(ТекКод) тогда
		ОбщийМодульКлиент.ВыдатьСигнал();
	Иначе
		ПересчитатьДокументНаКлиенте();
	конецесли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьДокументНаКлиенте()
	
	Объект.ТовараНаСумму 		= Объект.Товары.Итог("Сумма");
	Объект.ТовараВКоличестве 	= Объект.Товары.Итог("Количество");
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНоменклатураОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	ОбщийМодульКлиент.ПоискОшибкиКодировки("Номенклатура", ДанныеВыбора, Текст, Элементы.Товары.ТекущиеДанные.Номенклатура);
	
	Если ЗначениеЗаполнено(ДанныеВыбора) Тогда
		ПриИзмененииНоменклатуры() 	;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНовуюЦенуПоСтарой(Команда)
	
	Коэффициент = 1;
	ВвестиЧисло(Коэффициент, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Введите коэффициент для новой цены относительно старой (1 - равенство)?"), 12, 4);
	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
	ПересчитатьЦенуПоКоэффициенту(Коэффициент);
	
КонецПроцедуры

&НаСервере
Процедура ПересчитатьЦенуПоКоэффициенту(Коэффициент)
	
	Для Каждого СтрокаЦен из Объект.Товары Цикл
		СтрокаЦен.Цена = СтрокаЦен.СтараяЦена * Коэффициент;
		СтрокаЦен.РазницаЦены = СтрокаЦен.Цена - СтрокаЦен.СтараяЦена;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	если НЕ Объект.Товары.Количество() = 0 
		и Вопрос(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Пересчитать цены на эту дату?"), РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда
		
		проверитьЗависимостьВидаЦен();
		ПроверитьВидЦенЗависимый();
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка и заполнение таблицы товаров.."));
		ВидЦенПриИзмененииНаСервере();              	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыНоменклатураНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	Если ИспользоватьСложныйМеханизмЦен
		и ЗначениеЗаполнено(Объект.ВидЦен) Тогда
		ПараметрыФормы.Вставить("ВидЦен", Объект.ВидЦен);
	КонецЕсли;	
	ПараметрыФормы.Вставить("ТекущаяСтрока", Элементы.Товары.ТекущиеДанные.Номенклатура);
	ФормаВыбора = ПолучитьФорму("Справочник.Номенклатура.ФормаВыбора", ПараметрыФормы);
	
	Номенклатура = ФормаВыбора.ОткрытьМодально();
	Если ЗначениеЗаполнено(Номенклатура) Тогда
		Элементы.Товары.ТекущиеДанные.Номенклатура = Номенклатура;	
		
		ПриИзмененииНоменклатуры() ;
		элементы.Товары.ЗакончитьРедактированиеСтроки(лОЖЬ);
		Элементы.Товары.ТекущийЭлемент = элементы.ТоварыЦена;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВводСКоличеством(Команда)
	
	Если ИспользоватьПодключаемоеОборудование Тогда
		ПоддерживаемыеТипыВО = Новый Массив ();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;
	
	СтруктураДляВВода = Новый Структура;
	СтруктураДляВВода.Вставить("Дата", Объект.Дата);
	СтруктураДляВВода.Вставить("ВидЦен", Объект.ВидЦен);
	СтруктураДляВВода.Вставить("ЭтоДобавка", Истина);
	СтруктураДляВВода.Вставить("БезКоличества", Истина);
	СтруктураДляВВода.Вставить("БлокВидаЦенИЦены", Ложь);
	
	СтруктураПараметров = ОбщийМодульКлиент.ВвестиНоменклатуруИКоличество(СтруктураДляВВода);	
	
	Если НЕ СтруктураПараметров = Неопределено Тогда
		ДобавитьПозициюНоменклатуры(СтруктураПараметров);
		ПересчитатьДокументНаКлиенте();	
		ЭтаФорма.ТекущийЭлемент = Элементы.Товары;
	КонецЕсли;
	
	Если ИспользоватьПодключаемоеОборудование И 
		МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда
		
		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		Если Не МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке( "При подключении оборудования произошла ошибка:") + " " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьТаблицуНаборамиИРасчитатьИмЦены(Команда)
	ЗаполнитьТаблицуНаборамиИРасчитатьИмЦеныНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуНаборамиИРасчитатьИмЦеныНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Номенклатура.Ссылка
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.ЭтоГруппа = ЛОЖЬ
	|	И Номенклатура.ЭтоНабор = ИСТИНА
	|	И Номенклатура.ПометкаУдаления = ЛОЖЬ
	|
	|УПОРЯДОЧИТЬ ПО
	|	Номенклатура.Наименование";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если НЕ РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СтрокаТовара = объект.Товары.Добавить();
			СтрокаТовара.Номенклатура 	= ВыборкаДетальныеЗаписи.ССылка;
			СтрокаТовара.СтараяЦена 	= ОбщийМодульСервер.ПолучитьЦенуНаСервере(строкатовара.Номенклатура, Объект.ВидЦен, Объект.Дата - 1, Истина, , , , , Объект.Ссылка);
			
			СтрокаТовара.Цена 			= ВыяснитьЦенуВсехСоставляющихНабора(СтрокаТовара.Номенклатура);
			
			СтрокаТовара.РазницаЦены 	= СтрокаТовара.Цена - СтрокаТовара.СтараяЦена;
			
		КонецЦикла;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Запись документа.."));
	глПроверятьСообщения = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьТоварИДобавить(Команда)
	
	ФормаЭлемента = получитьФорму("Справочник.Номенклатура.ФормаОбъекта");
	ФормаЭлемента.ОткрытьМодально();
	Если ЗначениеЗаполнено(ФормаЭлемента.Объект.ссылка) Тогда
		СоздатьТоварИДобавитьНаСервере(ФормаЭлемента.Объект.ссылка);
		Этаформа.ТекущийЭлемент = Элементы.Товары;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьТоварИДобавитьНаСервере(ЭлементСправочника)
	
	Если ЗначениеЗаполнено(ЭлементСправочника) Тогда
		СтрокаТовара = объект.Товары.Добавить();
		СтрокаТовара.номенклатура 		= ЭлементСправочника.ссылка;
		СтрокаТовара.цена 				= ЭлементСправочника.Цена;
		Элементы.Товары.ТекущаяСтрока 	= СтрокаТовара.ПолучитьИдентификатор();
		элементы.Товары.ТекущийЭлемент 	= элементы.ТоварыКоличество;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СвязанныеИзображения(Команда)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) 
		и Вопрос(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Сначала следует записать этот элемент. Записать?"), РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда
			
		Записать();
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПараметрыФормы = Новый Структура("СвязанныйОбъект", Объект.Ссылка);
		ОткрытьФорму("Справочник.Изображения.ФормаСписка", ПараметрыФормы);	
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

&НаКлиенте
Процедура ТоварыПриАктивизацииСтроки(Элемент)	
	ПоказатьТовар();	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьТовар()
	
	Если ПоказыватьИзображения
		И СопровождатьНоменклатуруИзображениями Тогда
		
		СтрокаТовара = Элементы.Товары.ТекущиеДанные;	
		
		Если Не СтрокаТовара = Неопределено Тогда
			Номенклатура = СтрокаТовара.Номенклатура;
			Если ЗначениеЗаполнено(Номенклатура) ТОгда
				Если не Номенклатура = НоменклатураИзображения Тогда
					НоменклатураИзображения = Номенклатура;
					ЕстьЧтоПоказать = ПоказатьИзображениеРеквизита(Номенклатура);	
				КонецЕсли;
			КонецЕсли;			                     	
		КонецЕсли;
		
		Если НоменклатураИзображения = Неопределено Тогда
			элементы.СсылкаНаИзображение.Видимость     = Ложь;
			элементы.ИзображениеВБазеДанных.Видимость  = Ложь;
		КонецЕсли;
		
	КонецЕсли;	
	
КонецПроцедуры

Функция   ПоказатьИзображениеРеквизита(ЭлементСИзображением)
			
	ОсновноеИзображениеОбъекта = ОбщийМодульПовтор.ПолучитьОсновноеИзображениеОбъекта(ЭлементСИзображением);
	Результат = Ложь;
	
	Если ЗначениеЗаполнено(ОсновноеИзображениеОбъекта) Тогда				
		
		СтруктураИзображения = ОбщийМодульСервер.ПолучитьСтруктуруИзображения(ОсновноеИзображениеОбъекта);
		ПодСсылку = СтруктураИзображения.ПодСсылку;
		
		Если СтруктураИзображения.ИзображениеВБазеДанных ТОгда
			элементы.СсылкаНаИзображение.Видимость     = Ложь;
			элементы.ИзображениеВБазеДанных.Видимость  = Истина;
			
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
			
		иначе
			элементы.СсылкаНаИзображение.Видимость     = Истина;
			элементы.ИзображениеВБазеДанных.Видимость  = Ложь;
		КонецЕсли; 		
		
		Результат = Истина;
		
	КонецЕсли;	
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ОтключитьИзображения(Команда)
	
	ПоказыватьИзображения = не ПоказыватьИзображения;
	если не ПоказыватьИзображения Тогда
		элементы.СсылкаНаИзображение.Видимость     = Ложь;
		элементы.ИзображениеВБазеДанных.Видимость  = Ложь;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПодборНоменклатуры(Команда)
	
	ПараметрыФормы = Новый Структура("Дата", Объект.Дата);
	ПараметрыФормы.Вставить("Документ", Объект.Ссылка);
	ПараметрыФормы.Вставить("ВидЦен", Объект.ВидЦен);
	ПараметрыФормы.Вставить("Добавление", Истина);
//	ПараметрыФормы.Вставить("Договор", Объект.Договор);
//	ПараметрыФормы.Вставить("Склад", Объект.Склад);
	ПараметрыФормы.Вставить("Товары", Объект.Товары);

	ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаПодбора", ПараметрыФормы, Элементы.Товары);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
		Объект.Товары.Очистить();
		Для каждого Подбор Из ВыбранноеЗначение Цикл
			
		Строка = Объект.Товары.Добавить();
		Строка.номенклатура      = Подбор.номенклатура;
		Строка.СтараяЦена		 = Подбор.Цена;
		
		ПриИзмененииНоменклатуры(Строка);
		
	КонецЦикла;	
			   КонецЕсли;
	
КонецПроцедуры   
