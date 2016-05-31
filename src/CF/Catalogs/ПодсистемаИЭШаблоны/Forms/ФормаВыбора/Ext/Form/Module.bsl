﻿// sza140420-2101
// sza131119-2321
// sza110204-1141
// sza110131-0109
// sza110128-1517
// sza101110-1754
//

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

	// ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	// ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Предопределенный");
	// ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	// ЭлементОтбора.Использование = ИСТИНА;
	// ЭлементОтбора.ПравоеЗначение = ЛОЖЬ;

	Если Параметры.ИспользоватьОтбор = "Э" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьТолькоДляИмпорта");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.Использование = ИСТИНА;
		ЭлементОтбора.ПравоеЗначение = Параметры.ИспользоватьТолькоДляИмпорта;
	ИначеЕсли Параметры.ИспользоватьОтбор = "И" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьТолькоДляЭкспорта");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.Использование = ИСТИНА;
		ЭлементОтбора.ПравоеЗначение = Параметры.ИспользоватьТолькоДляЭкспорта;
	КонецЕсли;

	Если Параметры.ИспользоватьОтборПоВиду = "С" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляСпискаЭлементовСправочникаИлиДокументов);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	ИначеЕсли Параметры.ИспользоватьОтборПоВиду = "К" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляКарточкиСправочникаИлиШапкиДокумента);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	ИначеЕсли Параметры.ИспользоватьОтборПоВиду = "Б" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляОбменаСБанком);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	ИначеЕсли Параметры.ИспользоватьОтборПоВиду = "З" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляТаблицыТовары);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	КонецЕсли;

	Попытка
		Если ЗначениеЗаполнено(Параметры.Клиент) Тогда

			ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
			ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ОтборДляКлиента");
			ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
			ЭлементОтбора.Использование = ИСТИНА;
			ОбъектУсловия = Новый СписокЗначений;
			ОбъектУсловия.Добавить(Справочники.Клиенты.ПустаяСсылка());
			ОбъектУсловия.Добавить(Параметры.Клиент);
			ЭлементОтбора.ПравоеЗначение = ОбъектУсловия;
		Иначе
			ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
			ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ОтборДляКлиента");
			ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
			ЭлементОтбора.Использование = ИСТИНА;
			ОбъектУсловия = Новый СписокЗначений;
			ОбъектУсловия.Добавить(Справочники.Клиенты.ПустаяСсылка());
			ЭлементОтбора.ПравоеЗначение = ОбъектУсловия;
		КонецЕсли;

	Исключение
	КонецПопытки;
	// Попытка
	// 	Если ЗначениеЗаполнено(Параметры.Организация) Тогда

	// 		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	// 		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ОтборДляОрганизации");
	// 		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	// 		ЭлементОтбора.Использование = ИСТИНА;
	// 		ОбъектУсловия = Новый СписокЗначений;
	// 		ОбъектУсловия.Добавить(Справочники.Организации.ПустаяСсылка());
	// 		ОбъектУсловия.Добавить(Параметры.Организация);
	// 		ЭлементОтбора.ПравоеЗначение = ОбъектУсловия;
	//
	// 	Иначе
	// 		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	// 		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ОтборДляОрганизации");
	// 		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	// 		ЭлементОтбора.Использование = ИСТИНА;
	// 		ОбъектУсловия = Новый СписокЗначений;
	// 		ОбъектУсловия.Добавить(Справочники.Организации.ПустаяСсылка());
	// 		ЭлементОтбора.ПравоеЗначение = ОбъектУсловия;
	// 	КонецЕсли;

	//
	// Исключение
	// КонецПопытки;
		  ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
