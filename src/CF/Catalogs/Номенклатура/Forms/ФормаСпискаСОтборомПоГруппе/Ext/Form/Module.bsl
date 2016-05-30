﻿//sza140110-2302 : 
//sza130918-1600 : 

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если ИспользоватьПодключаемоеОборудование 
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда
		
		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		Если Не МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка:") + " " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
	
	Элементы.СписокСложнаяЦенаПроцентСкидки.Видимость = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВключитьВозможностьУказыватьПроцентСкидкиДляНоменклатуры");
	УстановитьОтборПоИерархииНоменклатурыОбработчикОжидания();
	
	если не ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("СопровождатьНоменклатуруИзображениями")
		и ИспользуютсяИзображения тогда
		
		ИспользуютсяИзображения = Ложь;	
	КонецЕсли;
	Элементы.ГруппаИзображения.Видимость = ИспользуютсяИзображения;
	
КонецПроцедуры

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
Процедура ИерархияНоменклатурыПриАктивизацииСтроки(Элемент)
	ПодключитьОбработчикОжидания("УстановитьОтборПоИерархииНоменклатурыОбработчикОжидания", 0.2, Истина);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоИерархииНоменклатурыОбработчикОжидания()
	
	СменуПроизвелилева = истина;
	ТекущиеДанныеНавигации = Элементы.ИерархияНоменклатуры.ТекущиеДанные;
	
	ЗначениеОтбора = ?(ТекущиеДанныеНавигации <> Неопределено, ТекущиеДанныеНавигации.Ссылка, ПредопределенноеЗначение("Справочник.Номенклатура.ПустаяСсылка"));
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Родитель",
	ЗначениеОтбора,
	ВидСравненияКомпоновкиДанных.Равно,
	,
	Истина
	);
	
	Если ТекущиеДанныеНавигации <> Неопределено Тогда
		Элементы.СписокСложнаяЦенаНаименование.Заголовок = значениеотбора;
	Иначе
		Элементы.СписокСложнаяЦенаНаименование.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Наименование");
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
			
			Если Не ОбработатьПолученныйШКНаКлиенте(ТекКод) Тогда
				СообщитьОбОшибке(ТекКод)
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НайтиПоТочномуСоответствиюПриИзменении(Элемент)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	ИспользоватьСложныйМеханизмЦен 			 = ОбщийМодульПовтор.ПолучитьПараметрСеанса("ИспользоватьСложныйМеханизмЦенПС") ;
	ИспользоватьПодключаемоеОборудование 	 = ПодключаемоеОборудованиеДСервер.ИспользоватьПодключаемоеОборудование();
	Элементы.КоличествоПоУмолчанию.Видимость = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("РегулироватьКоличествоНоменклатурыПоУмолчаниюДляУпаковок");
	
	ВидЦен = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВидЦенРасходованияПоУмолчанию");
	Если НЕ ЗначениеЗаполнено(ВидЦен) Тогда
		ВидЦен = ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВидЦенПриходованияТовараПоУмолчанию");
		Если НЕ ЗначениеЗаполнено(ВидЦен) Тогда
			ВидЦен = ПредопределенноеЗначение("Справочник.ВидыЦен.ОсновнойВидЦен");
		КонецЕсли;
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("ДатаОстатка", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
	Список.Параметры.УстановитьЗначениеПараметра("ИспользоватьСложныйМеханизмЦен", ИспользоватьСложныйМеханизмЦен);
	Список.Параметры.УстановитьЗначениеПараметра("ВидЦен", ВидЦен);
	
	ИзменитьВидЦен();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ   	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
	
	Если ИспользоватьПодключаемоеОборудование Тогда
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Функция   ОбработатьПолученныйШКНаСервере(ТекКод)
	
	КодЭлемента = ОбщийМодульТоварСервер.ПолучитьНоменклатуруПоШтрихКоду(ТекКод, ложь);
	Если ЗначениеЗаполнено(КодЭлемента) Тогда
		Результат = КодЭлемента;
	Иначе
		Результат = Неопределено;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция   ОбработатьПолученныйШКНаКлиенте(ТекКод)
	
	Результат 	= Истина;
	КодЭлемента = ОбработатьПолученныйШКНаСервере(ТекКод);
	
	Если КодЭлемента <> Неопределено Тогда
		
		ПараметрыОткрытия = Новый Структура("Ключ", КодЭлемента);
		ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаЭлемента", ПараметрыОткрытия);
	Иначе
		Результат = Ложь;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура СообщитьОбОшибке(ТекКод)
	
	ТекстПредупреждения 	= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Позиция номенклатуры не найдена!");
	ЗаголовокПредупреждения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поиск по ШтрихКоду");
	Предупреждение(ТекстПредупреждения, 10, ЗаголовокПредупреждения);
	
КонецПроцедуры

&НаКлиенте
Процедура Поиск(Команда)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ВидЦенПриИзменении(Элемент)
	
	ИзменитьВидЦен();
	ОбновитьИнтерфейс();
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьВидЦен()
	
	Список.Параметры.УстановитьЗначениеПараметра("ВидЦен", ВидЦен);	
	
	СтруктураОтвета = ОбновитьДанныеОбОбщемКоличествеНаСервере(ИспользоватьСложныйМеханизмЦен, ВидЦен);
	НаСумму 		= СтруктураОтвета.НаСумму;
	ОбщееКоличество = СтруктураОтвета.ОбщееКоличество;
	
КонецПроцедуры

&НаКлиенте
Процедура ВводШтрихКода(Команда)
	
	ТекКод = "";
	Если ВвестиШтрихКод(ТекКод) Тогда
		Результат = ОбработатьПолученныйШКНаСервере(ТекКод);
		если Результат = Неопределено тогда
			ОбщийМодульКлиент.ВыдатьСигнал(текКод);
		Иначе
			открытьзначение(Результат);
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

&НаСервереБезКонтекста
Функция   ОбновитьДанныеОбОбщемКоличествеНаСервере(ИспользоватьСложныйМеханизмЦен, ВидЦен = Неопределено)
	
	СтруктураОтвета = Новый Структура;
	
	Запрос = Новый Запрос;
	
	Если ИспользоватьСложныйМеханизмЦен Тогда
		Запрос.Текст = "ВЫБРАТЬ
		               |	ТоварыОстатки.КоличествоОстаток,
		               |	ТоварыОстатки.СуммаОстаток
		               |ИЗ
		               |	РегистрНакопления.Товары.Остатки(&Дата, ) КАК ТоварыОстатки";
	иначе
		
		Запрос.Текст = "ВЫБРАТЬ
		               |	ТоварыОстатки.КоличествоОстаток,
		               |	ТоварыОстатки.КоличествоОстаток * ЕСТЬNULL(ВложенныйЗапрос.Цена, ТоварыОстатки.Номенклатура.Цена) КАК СуммаОстаток
		               |ИЗ
		               |	РегистрНакопления.Товары.Остатки(&Дата, ) КАК ТоварыОстатки
		               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
		               |			ЦеныСрезПоследних.Цена КАК Цена,
		               |			ЦеныСрезПоследних.Номенклатура КАК НоменклатураЦены
		               |		ИЗ
		               |			РегистрСведений.Цены.СрезПоследних КАК ЦеныСрезПоследних
		               |		ГДЕ
		               |			ЦеныСрезПоследних.ВидЦен = &ВидЦен) КАК ВложенныйЗапрос
		               |		ПО ТоварыОстатки.Номенклатура = ВложенныйЗапрос.НоменклатураЦены";
		Запрос.УстановитьПараметр("ВидЦен", ВидЦен);
	КонецЕсли;
	Запрос.УстановитьПараметр("Дата", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
	
	ОбщееКоличество = 0;
	НаСумму 		= 0;
	РезультатЗапроса = Запрос.Выполнить();
	Если не РезультатЗапроса.Пустой() Тогда
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			ОбщееКоличество = ОбщееКоличество + ВыборкаДетальныеЗаписи.КоличествоОстаток;
			НаСумму = НаСумму + ВыборкаДетальныеЗаписи.СуммаОстаток;
		КонецЦикла;                            	
	КонецЕсли;
	
	СтруктураОтвета.Вставить("НаСумму", наСумму);
	СтруктураОтвета.Вставить("ОбщееКоличество", ОбщееКоличество);
	
	Возврат СтруктураОтвета;
	
КонецФункции

&НаКлиенте
Процедура ОбщееКоличествоНажатие(Элемент, СтандартнаяОбработка)
	
	СтруктураОтвета = ОбновитьДанныеОбОбщемКоличествеНаСервере(ИспользоватьСложныйМеханизмЦен, ВидЦен);
	НаСумму 		= СтруктураОтвета.НаСумму;
	ОбщееКоличество = СтруктураОтвета.ОбщееКоличество;
	
КонецПроцедуры

&НаКлиенте
Процедура НаСумму1ПриИзменении(Элемент)
	
	СтруктураОтвета = ОбновитьДанныеОбОбщемКоличествеНаСервере(ИспользоватьСложныйМеханизмЦен, ВидЦен);
	НаСумму 		= СтруктураОтвета.НаСумму;
	ОбщееКоличество = СтруктураОтвета.ОбщееКоличество;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеОбОбщемКоличестве(Команда)
	
	СтруктураОтвета = ОбновитьДанныеОбОбщемКоличествеНаСервере(ИспользоватьСложныйМеханизмЦен, ВидЦен);
	НаСумму 		= СтруктураОтвета.НаСумму;
	ОбщееКоличество = СтруктураОтвета.ОбщееКоличество;
	
КонецПроцедуры

&НаКлиенте
Процедура КопироватьСЦеной(Команда)
	
	ТекущийОбъект = элементы.Список.ТекущаяСтрока;
	
	Если ЗначениеЗаполнено(ТекущийОбъект) Тогда
		СкопированныйОбъект = ОбщийМодульТоварСервер.ПолучитьССылкуНаСкопированныйОбъект(ТекущийОбъект);
		если не СкопированныйОбъект = Неопределено тогда
			ОткрытьЗначение(СкопированныйОбъект);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	Если ИспользуютсяИзображения Тогда
		ПодСсылку = "";
		
		ТекущийЭлементСписка = Элементы.Список.ТекущаяСтрока;
		Если ЗначениеЗаполнено(ТекущийЭлементСписка) Тогда
			
			ОсновноеИзображениеОбъекта = ОбщийМодульПовтор.ПолучитьОсновноеИзображениеОбъекта(ТекущийЭлементСписка);
			
			Если ЗначениеЗаполнено(ОсновноеИзображениеОбъекта) Тогда				
				
				СтруктураИзображения = ОбщийМодульСервер.ПолучитьСтруктуруИзображения(ОсновноеИзображениеОбъекта);
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
			
		КонецЕсли;	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользуютсяИзображенияПриИзменении(Элемент)
	Элементы.ГруппаИзображения.Видимость = ИспользуютсяИзображения;
КонецПроцедуры
