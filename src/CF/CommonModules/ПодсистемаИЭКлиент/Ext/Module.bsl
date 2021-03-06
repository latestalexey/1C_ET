﻿// sza110913-0101 sz: чистка
// sza110309-1521
// sza110302-1931 ку
// sza110301-1909
// sza110228-1828
// sza110225-1145
// sza110225-0047 ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора
// sza110213-0049 ШаблонФайлаДляГрупповойзагрузки
// sza110131-0105
// sza110128-1506
// sza101207-1418
// sza101206-1615
// sza101205-2155
// sza101204-2122
// sza101204-0348
// sza101117-1404

// Процедура подготовки и запуска импортно-экспортных операций
//
Процедура ИмпортЭкспортОбработкаОбмена(СтруктураИмпортаЭкспорта) Экспорт

	ОбъектОперации = СтруктураИмпортаЭкспорта.ОбъектОперации;
	ШаблонФайла    = СтруктураИмпортаЭкспорта.ШаблонФайла;
	Если ШаблонФайла = Неопределено Тогда
		ШаблонФайла = ПодсистемаИЭ.ОдинШаблонФайлаЗагрузки(СтруктураИмпортаЭкспорта.Экспортер);

		Если ШаблонФайла = Неопределено  Тогда
			ПараметрыФормы = Новый Структура("ИспользоватьТолькоДляИмпорта", ЛОЖЬ);
			ПараметрыФормы.Вставить("ИспользоватьОтбор", ?(СтруктураИмпортаЭкспорта.Экспортер, "Э", "И"));
			ПараметрыФормы.Вставить("ИспользоватьОтборПоВиду", СтруктураИмпортаЭкспорта.ВидДляОтбора);
			Попытка
				ПараметрыФормы.Вставить("Клиент", СтруктураИмпортаЭкспорта.Клиент);
			Исключение
			КонецПопытки;
			Попытка
				ПараметрыФормы.Вставить("Организация", СтруктураИмпортаЭкспорта.Организация);
			Исключение
			КонецПопытки;
			ПодсистемаИЭЗагрузкаТоваровИзФайлаФормаВыбора = ПолучитьФорму("Справочник.ПодсистемаИЭШаблоны.ФормаВыбора", ПараметрыФормы);
			ПодсистемаИЭЗагрузкаТоваровИзФайлаПолученоЗначение = ПодсистемаИЭЗагрузкаТоваровИзФайлаФормаВыбора.ОткрытьМодально();

			Если ЗначениеЗаполнено(ПодсистемаИЭЗагрузкаТоваровИзФайлаПолученоЗначение) Тогда
				ШаблонФайла = ПодсистемаИЭЗагрузкаТоваровИзФайлаПолученоЗначение;
			КонецЕсли;  // элемент выбран
		КонецЕсли;
	КонецЕсли;

	Если НЕ ШаблонФайла = Неопределено Тогда
		ПериодДляДокументов = СтруктураИмпортаЭкспорта.ПериодДляДокументов;

		Если (ПериодДляДокументов = ""
			И СтруктураИмпортаЭкспорта.ЭтоВыборкаДокументов )
			И ПодсистемаИЭ.ШаблонФайлаВыдаватьЗапросДляИнтервалаДокументов(ШаблонФайла) Тогда

			ПериодДляДокументовДиалог		= Новый ДиалогРедактированияСтандартногоПериода;
			СтандартныйПериодДляДокументов 	= Новый СтандартныйПериод;
			СтандартныйПериодДляДокументов.ДатаНачала 	 = начАЛОмесяца(ТекущаяДата());
			СтандартныйПериодДляДокументов.ДатаОкончания = КонецДня(ТекущаяДата());
			ПериодДляДокументовДиалог.Период 			 = СтандартныйПериодДляДокументов;
			ПериодДляДокументовДиалог.Редактировать();
			СтандартныйПериодДляДокументов = ПериодДляДокументовДиалог.Период;
			ПериодДляДокументов = Новый Структура;
			ПериодДляДокументов.Вставить("ДатаНачала", СтандартныйПериодДляДокументов.ДатаНачала);
			ПериодДляДокументов.Вставить("ДатаОкончания", СтандартныйПериодДляДокументов.ДатаОкончания);
			СтруктураИмпортаЭкспорта.ПериодДляДокументов = ПериодДляДокументов;
		КонецЕсли;

		АдресФайла = СтруктураИмпортаЭкспорта.АдресФайла;

		Если АдресФайла = "" Тогда
			АдресФайла = ПодсистемаИЭ.ШаблонФайлаАдресФайлаБезВыбора(ШаблонФайла);
		КонецЕсли;

		Если АдресФайла = "" Тогда
			ШаблонФайлаДляГрупповойзагрузки = ПодсистемаИЭ.ШаблонФайлаДляГрупповойзагрузки(ШаблонФайла);
			ДиалогВыбораФайла 	= Новый ДиалогВыбораФайла(?(СтруктураИмпортаЭкспорта.Экспортер, РежимДиалогаВыбораФайла.Сохранение,
			?(ШаблонФайлаДляГрупповойзагрузки, РежимДиалогаВыбораФайла.ВыборКаталога, РежимДиалогаВыбораФайла.Открытие)));
			СтруктураДиалогФильтр = ПодсистемаИЭ.СтруктураДиалогФильтр(ШаблонФайла);
			ДиалогРасширение = СтруктураДиалогФильтр.ДиалогРасширение;
			ДиалогФильтр = СтруктураДиалогФильтр.ДиалогФильтр;
			ДиалогВыбораФайла.Заголовок				= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выберите") + " " + ?(ШаблонФайлаДляГрупповойзагрузки, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("каталог"), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("файл")) + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("для") + " " + ?(СтруктураИмпортаЭкспорта.Экспортер, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("экспорт"), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("импорт")) + "а " + СтруктураИмпортаЭкспорта.БлокОбъектов + " (" + СокрЛП(ШаблонФайла) + "):";
			ДиалогВыбораФайла.ПолноеИмяФайла		= ?(ПодсистемаИЭ.КонстантыОтносительныйАдресФайловПолучить() = "", ПодсистемаИЭ.константыПодсистемаИЭПолучить(), ПодсистемаИЭ.КонстантыОтносительныйАдресФайловПолучить()); // АДРЕС
			ДиалогВыбораФайла.Фильтр				= ДиалогФильтр;
			ДиалогВыбораФайла.Расширение			= ДиалогРасширение;
			ДиалогВыбораФайла.МножественныйВыбор	= ЛОЖЬ;
			ДиалогВыбораФайла.ИндексФильтра			= 0;
			ДиалогВыбораФайла.ПредварительныйПросмотр		= ?(СтруктураИмпортаЭкспорта.Экспортер,ЛОЖЬ,ИСТИНА);
			ДиалогВыбораФайла.ПроверятьСуществованиеФайла 	= ?(ШаблонФайлаДляГрупповойзагрузки, ЛОЖЬ, ?(СтруктураИмпортаЭкспорта.Экспортер, ЛОЖЬ, ИСТИНА));

			Если ДиалогВыбораФайла.Выбрать() Тогда
				АдресФайла = ?(ШаблонФайлаДляГрупповойзагрузки, ДиалогВыбораФайла.Каталог, ДиалогВыбораФайла.ПолноеИмяФайла);
				Попытка
					ПодсистемаИЭ.КонстантыПодсистемаИЭУстановить(АдресФайла);
				Исключение
				КонецПопытки;
			КонецЕсли; // когда файл адрес Файла выбран
		КонецЕсли;

		Если НЕ СокрЛП(АдресФайла) = "" Тогда
			ДатаДоОперации = ТекущаяДата();
			СтруктураИмпортаЭкспорта.АдресФайла 	= АдресФайла;
			СтруктураИмпортаЭкспорта.ОбъектОперации = ОбъектОперации;
			СтруктураИмпортаЭкспорта.ШаблонФайла 	= ШаблонФайла;
			ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора = ПодсистемаИЭ.ШаблонФайлаПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора(ШаблонФайла);
			СтруктураИмпортаЭкспорта.ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора = ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора;
			#Если НЕ ТолстыйКлиентУправляемоеПриложение Тогда
				СтруктураИмпортаЭкспорта.ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора = ЛОЖЬ;

				Если ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора Тогда
					ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ошибка: Таблица для отбора не может быть открыта в этом режиме приложения!! Только ТОЛСТЫЙ клиент"));
				КонецЕсли;

			#КонецЕсли
			ФормаПрогресса = Неопределено ;
			Если ПодсистемаИЭ.ШаблонФайлаПоказыватьПрогрессПроизводстваОбмена(ШаблонФайла) Тогда
				ПараметрыФормыПрогресса = ПодсистемаИЭ.СоздатьСтруктуруФормыПрогресса(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Прогресс") + " " + ?(СтруктураИмпортаЭкспорта.Экспортер, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("экспорта"), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("импорта")) + " " + СокрЛП(ШаблонФайла), ШаблонФайла);
				ПараметрыФормыПрогресса.ДанныеПрогресса.ДатаНачала = ДатаДоОперации;
				ПараметрыФормыПрогресса.ДанныеПрогресса.НачальноеОкно = ИСТИНА;
				ФормаПрогресса = ПолучитьФорму("Справочник.ПодсистемаИЭШаблоны.Форма.ПрогрессОпераций", ПараметрыФормыПрогресса);
				ФормаПрогресса.Открыть();
			КонецЕсли;

			Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Операция импорта или экспорта.."), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ждите.."));
			РезультатИсполнения = ПодсистемаИЭ.ВыполнитьДляФайлаНаСервере(СтруктураИмпортаЭкспорта);
			#Если ТолстыйКлиентУправляемоеПриложение Тогда

				Если СтруктураИмпортаЭкспорта.Экспортер
					И СтруктураИмпортаЭкспорта.ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора
					И НЕ РезультатИсполнения = Неопределено Тогда

					ТаблицаОбмена = РезультатИсполнения.ТаблицаОбмена;
					ПараметрыФормыОбъектовОбмена = Новый Структура;
					ПараметрыФормыОбъектовОбмена.Вставить("ТаблицаОбмена", ТаблицаОбмена);
					ФормаОбъектовОбмена = ПолучитьФорму("Справочник.ПодсистемаИЭШаблоны.Форма.ОтборОбъектовОбмена", ПараметрыФормыОбъектовОбмена);
					ФормаОбъектовОбмена.ОткрытьМодально();
					СтруктураИмпортаЭкспорта.ТаблицаОбмена = ФормаОбъектовОбмена.ТаблицаОбмена;
					СтруктураИмпортаЭкспорта.ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора = ЛОЖЬ;
					СтруктураИмпортаЭкспорта.ПрямаяОбработкаТаблицы = ИСТИНА;
					РезультатИсполнения = ПодсистемаИЭ.ВыполнитьДляФайлаНаСервере(СтруктураИмпортаЭкспорта);
				КонецЕсли;

			#КонецЕсли
			Если НЕ РезультатИсполнения = Неопределено Тогда

				Если НЕ СтруктураИмпортаЭкспорта.Экспортер
					И (ПодсистемаИЭ.ШаблонФайлаОткрыватьФормуКаждогоЭлементаИлиДокумента(ШаблонФайла)
					ИЛИ ПодсистемаИЭ.ШаблонФайлаОткрыватьФормуДокументовКоторыеНеУдалосьПровести(ШаблонФайла)) Тогда

					СписокОбъектов = РезультатИсполнения.СписокОбъектов;

					Для Каждого ЭлементФормуКоторогоСледуетОткрыть Из СписокОбъектов Цикл
						ПоказатьЗначение(, ЭлементФормуКоторогоСледуетОткрыть.Значение);
					КонецЦикла;
				КонецЕсли;

				Если ПодсистемаИЭ.ШаблонФайлаПоказыватьПрогрессПроизводстваОбмена(ШаблонФайла) Тогда
					ФормаПрогресса.Закрыть();
					ПараметрыФормыПрогресса.ДанныеПрогресса.ВремяОбработки = ТекущаяДата() - ДатаДоОперации;
					ПараметрыФормыПрогресса.ДанныеПрогресса.ТаблицаОбработанныхОбъектов = РезультатИсполнения.ТаблицаОбработанныхОбъектов;
					ПараметрыФормыПрогресса.ДанныеПрогресса.ЧислоОбъектовДляОбработки 	= РезультатИсполнения.ЧислоОбъектовДляОбработки;
					ПараметрыФормыПрогресса.ДанныеПрогресса.ЧислоОбработанныхОбъектов 	= РезультатИсполнения.ЧислоОбработанныхОбъектов;
					ПараметрыФормыПрогресса.ДанныеПрогресса.НачальноеОкно = ЛОЖЬ;
					ФормаПрогресса = ПолучитьФорму("Справочник.ПодсистемаИЭШаблоны.Форма.ПрогрессОпераций", ПараметрыФормыПрогресса);
					ФормаПрогресса.Открыть();
				КонецЕсли;
			КонецЕсли;

			Если НЕ ПодсистемаИЭ.НеВыводитьСообщениеОЗавершенииОбмена(ШаблонФайла) Тогда
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обмен") + " (" + СокрЛП(ШаблонФайла) + ") " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("окончен.") + " " + ТекущаяДата(), ОбъектОперации);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

// Функция создания структуры задачи на импорт или экспорт
Функция   СоздатьСтруктуруВызоваИмпЭкспОперации(
	ОбъектОперации = Неопределено,
	ШаблонФайла = Неопределено,
	Экспортер = ЛОЖЬ,
	АдресФайла = "",
	ВидДляОтбора = "",
	ИмяТаблицыШаблонаФайла = "",
	ПериодДляДокументов = "",
	ДополнительныйПараметр = Неопределено,
	ДляТаблицыМатериалы = ЛОЖЬ,
	ДатаАктуальности = '00010101000000',
	ТипОбъектаОперации = "",
	ВладелецСпецификаций = Неопределено,
	ЭтотРасчетныйСчет = Неопределено,
	ТипМетаОбъектаОбмена = "",
	АдресВторогоФайла = "",
	ХарактеристикаВладельцаСпецификации = Неопределено,
	РежимТестирования = ЛОЖЬ,
	ПредПодготовка = ЛОЖЬ
	) Экспорт
	СтруктураИмпортаЭкспорта = Новый Структура;
	СтруктураИмпортаЭкспорта.Вставить("ОбъектОперации", ОбъектОперации);
	СтруктураИмпортаЭкспорта.Вставить("ШаблонФайла", ШаблонФайла);
	СтруктураИмпортаЭкспорта.Вставить("Экспортер", Экспортер);
	СтруктураИмпортаЭкспорта.Вставить("ВидДляОтбора", ВидДляОтбора);
	СтруктураИмпортаЭкспорта.Вставить("АдресФайла", АдресФайла);
	СтруктураИмпортаЭкспорта.Вставить("АдресВторогоФайла", АдресВторогоФайла);
	СтруктураИмпортаЭкспорта.Вставить("ЭтоВыборкаДокументов", ЛОЖЬ);
	СтруктураИмпортаЭкспорта.Вставить("ИмяТаблицыШаблонаФайла", ИмяТаблицыШаблонаФайла);
	СтруктураИмпортаЭкспорта.Вставить("ПериодДляДокументов", ПериодДляДокументов);

	Если ВидДляОтбора = "К" ТОгда
		СтруктураИмпортаЭкспорта.Вставить("БлокОбъектов", "карточки/шапки");
	ИначеЕсли ВидДляОтбора = "С" ТОгда
		СтруктураИмпортаЭкспорта.Вставить("БлокОбъектов", "списка");
		СтруктураИмпортаЭкспорта.ИмяТаблицыШаблонаФайла = "LISTofALL";
		СтруктураИмпортаЭкспорта.ЭтоВыборкаДокументов = ИСТИНА;
	ИначеЕсли ВидДляОтбора = "З" ТОгда
		СтруктураИмпортаЭкспорта.Вставить("БлокОбъектов", "Товаров");
	Иначе
		СтруктураИмпортаЭкспорта.Вставить("БлокОбъектов", "определенных данных");
	КонецЕсли;

	ДополнительнаяИнформация = Новый Структура;
	СтруктураИмпортаЭкспорта.Вставить("СтруктураДопТаблиц", ДополнительнаяИнформация);
	СтруктураИмпортаЭкспорта.Вставить("ЧислоДопТаблиц", 0);
	СтруктураИмпортаЭкспорта.Вставить("ДляТаблицыМатериалы", ДляТаблицыМатериалы);
	СтруктураИмпортаЭкспорта.Вставить("ДатаАктуальности", ДатаАктуальности);
	СтруктураИмпортаЭкспорта.Вставить("ТипОбъектаОперации", ТипОбъектаОперации);
	СтруктураИмпортаЭкспорта.Вставить("ТипМетаОбъектаОбмена", ТипМетаОбъектаОбмена);
	СтруктураИмпортаЭкспорта.Вставить("ВладелецСпецификаций", ВладелецСпецификаций);
	ДополнительнаяИнформация = Новый Структура;
	ДополнительнаяИнформация.Вставить("ЭтотРасчетныйСчет", ЭтотРасчетныйСчет);
	СтруктураИмпортаЭкспорта.Вставить("ДополнительнаяИнформация", ДополнительнаяИнформация);
	СтруктураИмпортаЭкспорта.Вставить("ХарактеристикаВладельцаСпецификации", ХарактеристикаВладельцаСпецификации);
	СтруктураИмпортаЭкспорта.Вставить("ДополнительныйПараметр", ДополнительныйПараметр);
	СтруктураИмпортаЭкспорта.Вставить("РежимТестирования", РежимТестирования);
	СтруктураИмпортаЭкспорта.Вставить("ПредПодготовка", ПредПодготовка);
	СтруктураИмпортаЭкспорта.Вставить("СтруктураФормыПрогресса", Новый Структура);
	Попытка
		Если ЗначениеЗаполнено(ОбъектОперации.Клиент) Тогда

			СтруктураИмпортаЭкспорта.Вставить("Клиент", ОбъектОперации.Клиент);
		Иначе
			СтруктураИмпортаЭкспорта.Вставить("Клиент", ПредопределенноеЗначение("Справочник.Клиенты.ПустаяСсылка"));
		КонецЕсли;

	Исключение
	КонецПопытки;
	// Попытка
	// 	Если ЗначениеЗаполнено(ОбъектОперации.Организация) Тогда

	// 		СтруктураИмпортаЭкспорта.Вставить("Организация", ОбъектОперации.Организация);
	// 	Иначе
	// 		СтруктураИмпортаЭкспорта.Вставить("Организация", ПредопределенноеЗначение("Справочник.Организации.ПустаяСсылка"));
	// 	КонецЕсли;

	// Исключение
	// КонецПопытки;
	СтруктураИмпортаЭкспорта.Вставить("ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора", ЛОЖЬ);
	СтруктураИмпортаЭкспорта.Вставить("ПрямаяОбработкаТаблицы", ЛОЖЬ);
	СтруктураИмпортаЭкспорта.Вставить("ТаблицаОбмена", Неопределено);

	Возврат СтруктураИмпортаЭкспорта;

КонецФункции // СоздатьСтруктуруФормыПрогресса()
