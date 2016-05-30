﻿//sza140104-0200 : 
//sza130905-1706 : 

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Если НЕ ЗначениеЗаполнено(Объект.ПравовойСтатус) Тогда
			Объект.ПравовойСтатус = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ПравовойСтатусПоУмолчанию");
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Объект.Регион ) Тогда
			Объект.Регион = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("РегионПоУмолчанию");
		КонецЕсли;		
		ЭтаФорма.Элементы.ГруппаВзаиморасчеты.видимость = ложь;
		ЭтаФорма.Элементы.ДокументыПоставщика.Видимость = ложь;
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.Родитель)
		и ЗначениеЗаполнено(Объект.Родитель.ВидЦен) Тогда
		
		Элементы.ВидЦен.ТолькоПросмотр = Истина;
		Элементы.ВидЦен.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Вид цен Группы Поставщиков:");
		Если не Объект.ВидЦен = Объект.Родитель.ВидЦен Тогда
			Объект.ВидЦен = Объект.Родитель.ВидЦен;
		КонецЕсли;			
	КонецЕсли;
	
	ДокументыПоставщика.Параметры.УстановитьЗначениеПараметра("Поставщик", Объект.Ссылка);	
	ДокументыПоставщика.Параметры.УстановитьЗначениеПараметра("Видприход", ВидДвиженияНакопления.Приход);	
	ЗаказыПоставщику.Параметры.УстановитьЗначениеПараметра("КлиентПоставщик", Объект.Ссылка);	
	ЗаказыПоставщику.Параметры.УстановитьЗначениеПараметра("Дата", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
	ДоговораПоставщика.Параметры.УстановитьЗначениеПараметра("КлиентПоставщик", Объект.Ссылка);	
	Изображения.Параметры.УстановитьЗначениеПараметра("Владелец", Объект.Ссылка);
	
	элементы.ДоговораПоставщика.Видимость 	= ПараметрыСеанса.ВестиУчетОтдельныхДоговоровСИКонтрагентамиПС И НЕ ОбщийМодульСервер.ЧислоДоговоровСКонтрагентом(Объект.Ссылка) = 0;
	элементы.ЗаказыПоставщику.Видимость 	= ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВестиУчетЗаказовПоставщикам");
	Элементы.СоздатьНовыйДоговор.Видимость  = ПараметрыСеанса.ВестиУчетОтдельныхДоговоровСИКонтрагентамиПС И ЗначениеЗаполнено(Объект.Ссылка);
	
	НаименованиеОсновнойВалюты = Справочники.Валюты.ОсновнаяВалюта.Наименование ;
	
	ОбновитьДаныеОДолгеНаСервере();

	ПоддержкаДругихЯзыков = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ПоддерживатьИныеЯзыкиКромеРусского") 
	И ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского", Истина);
	
	если ПоддержкаДругихЯзыков 
		и ЗначениеЗаполнено(Объект.Ссылка) тогда
		
		Наименование = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(объект.Ссылка);
		НаименованиеДляПечати = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(объект.Ссылка, "НаименованиеДляПечати");
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ ЗначенияНаДругихЯзыках.Язык,
		|	ЗначенияНаДругихЯзыках.НаЯзыке,
		|	ЗначенияНаДругихЯзыках.Поле
		|ИЗ РегистрСведений.ЗначенияНаДругихЯзыках КАК ЗначенияНаДругихЯзыках
		|ГДЕ ЗначенияНаДругихЯзыках.ОбъектБазыДанных = &ОбъектБазыДанных";
		
		Запрос.УстановитьПараметр("ОбъектБазыДанных", Объект.Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		если не РезультатЗапроса.Пустой() тогда
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				Если ВыборкаДетальныеЗаписи.Поле = "Наименование" Тогда
					СтрокаЯзыка = НаименованияНаДругихЯзыках.Добавить();
					СтрокаЯзыка.Язык 	= ВыборкаДетальныеЗаписи.Язык;
					СтрокаЯзыка.НаЯзыке = ВыборкаДетальныеЗаписи.НаЯзыке;	
					
				ИначеЕсли ВыборкаДетальныеЗаписи.Поле = "НаименованиеДляПечати" Тогда
					СтрокаЯзыка = НаименованияДляПечатиНаДругихЯзыках.Добавить();
					СтрокаЯзыка.Язык 	= ВыборкаДетальныеЗаписи.Язык;
					СтрокаЯзыка.НаЯзыке = ВыборкаДетальныеЗаписи.НаЯзыке;
					
				КонецЕсли;
			КонецЦикла;
			
		КонецЕсли;
		
	иначе
		Наименование = объект.Наименование;
		НаименованиеДляПечати = Объект.НаименованиеДляПечати;
		
	КонецЕсли;	

КонецПроцедуры

&НаКлиенте
Процедура ЭлектроннаяПочтаПриИзменении(Элемент) 	
	Объект.ЭлектроннаяПочта = СокрЛП(Объект.ЭлектроннаяПочта);	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыКлиентаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(элемент.текущиеданные.регистратор) Тогда
		ОткрытьЗначение(элемент.текущиеданные.регистратор);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, истина);
	
	если не ЗначениеЗаполнено(объект.Ссылка) Тогда
		ЭтаФорма.ТекущийЭлемент = Элементы.Наименование;	
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СтраницаПанели)Тогда
		
		СтраницыПанели  = Элементы.ГруппаСтраницСправа.ПодчиненныеЭлементы;
		ТекущаяСтраница = СтраницыПанели.получить(СтраницаПанели);
		элементы.ГруппаСтраницСправа.ТекущаяСтраница = ТекущаяСтраница;
	КонецЕсли;	
	
	ВидимостьТаблицСправа();	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура РодительПриИзменении(Элемент)
	РодительПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура РодительПриИзмененииНаСервере()
	
	Если ЗначениеЗаполнено(Объект.Родитель)
		и ЗначениеЗаполнено(Объект.Родитель.ВидЦен) Тогда
		
		Объект.ВидЦен = Объект.Родитель.ВидЦен;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДаныеОДолге(Команда)
	ОбновитьДаныеОДолгеНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбновитьДаныеОДолгеНаСервере()
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	ЕСТЬNULL(РасчетыСПоставщикамиОстаткиИОбороты.СуммаПриход, 0) КАК Продано,
		|	ЕСТЬNULL(РасчетыСПоставщикамиОстаткиИОбороты.СуммаРасход, 0) КАК Оплачено,
		|	ЕСТЬNULL(РасчетыСПоставщикамиОстаткиИОбороты.СуммаКонечныйОстаток, 0) КАК ТекущийДолг
		|ИЗ РегистрНакопления.РасчетыСПоставщиками.ОстаткиИОбороты(&ДатаНачала, &ДатаОкончания, , , Поставщик = &Поставщик) КАК РасчетыСПоставщикамиОстаткиИОбороты";
		
		Запрос.УстановитьПараметр("ДатаНачала", '00010101000000');
		Запрос.УстановитьПараметр("ДатаОкончания", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
		Запрос.УстановитьПараметр("Поставщик", Объект.Ссылка);
		
		ТекущийДолг = 0;
		продано 	= 0;
		оплачено 	= 0;
		РезультатЗапроса = Запрос.Выполнить();
		Если НЕ РезультатЗапроса.Пустой() тогда
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				продано 	= продано + ВыборкаДетальныеЗаписи.Продано;
				оплачено 	= оплачено + ВыборкаДетальныеЗаписи.оплачено;
				ТекущийДолг = ТекущийДолг + ВыборкаДетальныеЗаписи.ТекущийДолг;
			КонецЦикла;	
		КонецЕсли;
		элементы.ТекущийДолг.Видимость 	= не ТекущийДолг = 0;
		элементы.НаименованиеОсновнойВалюты1.Видимость = не ТекущийДолг = 0;
		элементы.Продано.Видимость 		= не Продано = 0;
		элементы.Оплачено.Видимость 	= не Оплачено = 0;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если НЕ ЗначениеЗаполнено(Объект.Наименование) 
		и ЗначениеЗаполнено(Объект.НаименованиеДляПечати) Тогда
		
		Объект.Наименование = Объект.НаименованиеДляПечати;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовыйДоговор(Команда)
	
	ПараметрыДляФормы = Новый Структура("КлиентПоставщик", Объект.Ссылка);
	ФормаДоговора = ПолучитьФорму("Справочник.Договора.ФормаОбъекта", ПараметрыДляФормы);
	ФормаДоговора.отКрыть();
	
	элементы.ДоговораПоставщика.Видимость = ОбщийМодульПовтор.ПолучитьПараметрСеанса("ВестиУчетОтдельныхДоговоровСИКонтрагентамиПС") И НЕ ОбщийМодульСервер.ЧислоДоговоровСКонтрагентом(Объект.Ссылка) = 0;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	элементы.ДоговораПоставщика.Видимость = ОбщийМодульПовтор.ПолучитьПараметрСеанса("ВестиУчетОтдельныхДоговоровСИКонтрагентамиПС") И НЕ ОбщийМодульСервер.ЧислоДоговоровСКонтрагентом(Объект.Ссылка) = 0;
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СменитьВидОкна(Команда)
	
	НеПоказыватьТаблицыСправа = НЕ НеПоказыватьТаблицыСправа;
	ВидимостьТаблицСправа();
	
КонецПроцедуры

&НаКлиенте
Процедура ВидимостьТаблицСправа()
	Элементы.ГруппаСправа.Видимость = НЕ НеПоказыватьТаблицыСправа;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовыйЗаказ(Команда)
	
	ПараметрыДляФормы = Новый Структура("КлиентПоставщик", Объект.Ссылка);
	ПараметрыДляФормы.Вставить("ЭтоЗаказ", Истина);
	ФормаДоговора = ПолучитьФорму("Документ.ПоступленияТовара.ФормаОбъекта", ПараметрыДляФормы);
	ФормаДоговора.отКрыть();
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	если ПоддержкаДругихЯзыков тогда
		если НаименованиеИзменяли тогда
			ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, Наименование);
			ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, НаименованиеДляПечати, "НаименованиеДляПечати");
		КонецЕсли;
		
		Если БылиИзмененияЗначенияПолейНаЯзыках Тогда
			Для Каждого СтрокаЯзыка Из НаименованияНаДругихЯзыках Цикл
				ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, СтрокаЯзыка.НаЯзыке, "Наименование", СтрокаЯзыка.Язык);	
			КонецЦикла;
			Для Каждого СтрокаЯзыка Из НаименованияДляПечатиНаДругихЯзыках Цикл
				ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, СтрокаЯзыка.НаЯзыке, "НаименованиеДляПечати", СтрокаЯзыка.Язык);	
			КонецЦикла;
		КонецЕсли;
	
	конецесли;
	
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
Процедура НаименованияНаДругихЯзыкахПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = Истина;
КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахНаЯзыкеПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = Истина;
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеДляПечатиНаДругихЯзыках(Команда)
	Элементы.НаименованияДляПечатиНаДругихЯзыках.Видимость = НЕ Элементы.НаименованияДляПечатиНаДругихЯзыках.Видимость;
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеДляПечатиПриИзменении(Элемент)
	
	объект.НаименованиеДляПечати = НаименованиеДляПечати;
	НаименованиеИзменяли = Истина;

КонецПроцедуры

&НаКлиенте
Процедура НаименованияДляПечатиНаДругихЯзыкахПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = Истина;
КонецПроцедуры

&НаКлиенте
Процедура НаименованияДляПечатиНаДругихЯзыкахНаЯзыкеПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	ТекущаяСтраница = Элементы.ГруппаСтраницСправа.ТекущаяСтраница;
	СтраницыПанели  = Элементы.ГруппаСтраницСправа.ПодчиненныеЭлементы;
	СтраницаПанели  = СтраницыПанели.Индекс(ТекущаяСтраница);
	
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
