﻿// sza140420-2056
// sza140228-1422
// sza110521-2218 УстановитьИЭ
// sza110427-0048
// sza110322-1651
// sza110301-1909
// sza110215-1427
// sza110211-1254 УстановитьАдресПоШаблону
// sza110209-1649
// sza110202-1723
// sza110125-1758
// sza110121-1445
// sza110112-2108
// sza110110-1428
// sza101222-0232
// sza101216-0032
//

&НаКлиенте
Процедура ВыбратьПериод(Команда)

	ПериодДляДокументов = Новый СтандартныйПериод;
	ПериодДляДокументов.ДатаНачала = Объект.ДатаНачала;
	ПериодДляДокументов.ДатаОкончания = Объект.ДатаОкончания;
	ПериодДляДокументовДиалог = Новый ДиалогРедактированияСтандартногоПериода;
	ПериодДляДокументовДиалог.Период = ПериодДляДокументов;
	ПериодДляДокументовДиалог.Показать(Новый ОписаниеОповещения("ВыбратьПериодЗавершение", ЭтаФорма, Новый Структура("ПериодДляДокументовДиалог", ПериодДляДокументовДиалог)));

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПериодЗавершение(Период, ДополнительныеПараметры) Экспорт

	ПериодДляДокументовДиалог = ДополнительныеПараметры.ПериодДляДокументовДиалог;
	Объект.ДатаНачала = ПериодДляДокументовДиалог.Период.ДатаНачала;
	Объект.ДатаОкончания = КонецДня(ПериодДляДокументовДиалог.Период.ДатаОкончания);

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьВсеОперацииИмпорта(Команда)

	ВыполнитьОбменСпискаСРежимом(1);

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьВсеОперацииЭкспорта(Команда)

	ВыполнитьОбменСпискаСРежимом(2);

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбменСписка()
	ВыполнитьОбменСпискаСРежимом(0);
КонецПроцедуры // ВыполнитьОбменСпискаЗадач

&НаКлиенте
Процедура ВыполнитьОбменСпискаЗадач(Команда)

	Если Объект.ЗадачиИмпортаЭкспорта.Количество() = 0 Тогда
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не заполнен список обмена!"));
	Иначе
		ВыполнитьОбменСписка();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбменСпискаСРежимом(Режим)

	Если НЕ ЗначениеЗаполнено(Объект.ДатаНачала)
		И НЕ ЗначениеЗаполнено(Объект.ДатаОкончания) Тогда

		ПериодДляДокументов = "";
	Иначе
		ПериодДляДокументов = Новый Структура;
		ПериодДляДокументов.Вставить("ДатаНачала", Объект.ДатаНачала);
		ПериодДляДокументов.Вставить("ДатаОкончания", Объект.ДатаОкончания);
	КонецЕсли;

	Для Каждого ЗадачаОбмена Из Объект.ЗадачиИмпортаЭкспорта Цикл

		Если ЗадачаОбмена.Исполнять
			И (Режим = 0 ИЛИ (Режим = 1 И ЗадачаОбмена.ИмпортНеЭкспорт)
			ИЛИ (Режим = 2 И НЕ ЗадачаОбмена.ИмпортНеЭкспорт)) Тогда

			СтруктураИмпортаЭкспорта = ПодсистемаИЭКлиент.СоздатьСтруктуруВызоваИмпЭкспОперации(
			неопределено,
			ЗадачаОбмена.ШаблонФайла,
			?(ЗадачаОбмена.ИмпортНеЭкспорт, ЛОЖЬ, ИСТИНА),
			ЗадачаОбмена.АдресФайла,
			?(ЗадачаОбмена.СписокНеКарточка, "С", "К"),
			"",
			ПериодДляДокументов,
			неопределено);

			Если Лев(ЗадачаОбмена.ТипОбъектаОперации, 1) = "Д" Тогда
				ТипМета = "ДокументСсылка";
			Иначе
				ТипМета = "СправочникСсылка";
			КонецЕсли;

			ТипОбъектаОперации = Прав(ЗадачаОбмена.ТипОбъектаОперации, стрДлина(ЗадачаОбмена.ТипОбъектаОперации) - 1);
			СтруктураИмпортаЭкспорта.ТипМетаОбъектаОбмена = ТипМета;
			СтруктураИмпортаЭкспорта.ТипОбъектаОперации = ТипОбъектаОперации;
			Если ПустаяСтрока(ЗадачаОбмена.ИмяТаблицыШаблонаФайла) Тогда
				СтруктураИмпортаЭкспорта.ИмяТаблицыШаблонаФайла = "LISTofALL";
			Иначе
				СтруктураИмпортаЭкспорта.ИмяТаблицыШаблонаФайла = ЗадачаОбмена.ИмяТаблицыШаблонаФайла;
			КонецЕсли;

			СтруктураИмпортаЭкспорта.РежимТестирования = Объект.РежимТестирования;
			СтруктураИмпортаЭкспорта.АдресФайла = ЗадачаОбмена.АдресФайла;
			Если ЗначениеЗаполнено(ТипОбъектаОперации) Тогда
				СтруктураИмпортаЭкспорта.ОбъектОперации = Новый(Тип(ТипМета + "." + ТипОбъектаОперации));
			Иначе
				СтруктураИмпортаЭкспорта.ОбъектОперации = Неопределено ;
			КонецЕсли;

			ПодсистемаИЭКлиент.ИмпортЭкспортОбработкаОбмена(СтруктураИмпортаЭкспорта);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаПриИзменении(Элемент)

	Если Объект.ДатаОкончания < Объект.ДатаНачала Тогда
		Объект.ДатаОкончания = Объект.ДатаНачала;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДатаОкончанияПриИзменении(Элемент)

	Если Объект.ДатаОкончания < Объект.ДатаНачала Тогда
		Объект.ДатаНачала = Объект.ДатаОкончания;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗагрузитьСписокЗадачОбменаДокументамиДенежныхСредств()

	Объект.ЗадачиИмпортаЭкспорта.Очистить();

	ЗапШаблоныОбменаДС = Новый Запрос;
	ЗапШаблоныОбменаДС.Текст = "ВЫБРАТЬ
	|	SZИмпортЭкспортФСШаблоны.Ссылка,
	|	SZИмпортЭкспортФСШаблоны.ИспользоватьТолькоДляИмпорта КАК ИспользоватьТолькоДляИмпорта,
	|	SZИмпортЭкспортФСШаблоны.ИспользоватьТолькоДляЭкспорта КАК ИспользоватьТолькоДляЭкспорта,
	|	SZИмпортЭкспортФСШаблоны.АдресФайла
	|ИЗ
	|	Справочник.ПодсистемаИЭШаблоны КАК SZИмпортЭкспортФСШаблоны
	|ГДЕ
	|	SZИмпортЭкспортФСШаблоны.Предопределенный = ЛОЖЬ
	|	И SZИмпортЭкспортФСШаблоны.ПометкаУдаления = ЛОЖЬ
	|	И SZИмпортЭкспортФСШаблоны.ЭтоПлатежныйДокумент = ИСТИНА
	|
	|УПОРЯДОЧИТЬ ПО
	|	SZИмпортЭкспортФСШаблоны.СтрокаСортировкиДляСпискаЗадачИмпортаЭкспорта,
	|	ИспользоватьТолькоДляИмпорта,
	|	ИспользоватьТолькоДляЭкспорта";

	ВзШаблоныОбменаДС = ЗапШаблоныОбменаДС.Выполнить();

	Если НЕ ВзШаблоныОбменаДС.Пустой() Тогда
		РезШаблоныОбменаДС = ВзШаблоныОбменаДС.Выбрать();
		Пока РезШаблоныОбменаДС.Следующий() Цикл
			ЗадачаИмпортаЭкспорта = Объект.ЗадачиИмпортаЭкспорта.Добавить();
			ЗадачаИмпортаЭкспорта.ШаблонФайла = РезШаблоныОбменаДС.Ссылка;

			Если РезШаблоныОбменаДС.ИспользоватьТолькоДляИмпорта Тогда
				ЗадачаИмпортаЭкспорта.ИмпортНеЭкспорт = ИСТИНА;
				Элементы.ЗадачиИмпортаЭкспортаИмпорт.Доступность = ЛОЖЬ;
			ИначеЕсли РезШаблоныОбменаДС.ИспользоватьТолькоДляЭкспорта Тогда
				Элементы.ЗадачиИмпортаЭкспортаИмпорт.Доступность = ЛОЖЬ;
			КонецЕсли;

			Если ЗначениеЗаполнено(РезШаблоныОбменаДС.АдресФайла) Тогда
				ЗадачаИмпортаЭкспорта.АдресФайла = РезШаблоныОбменаДС.АдресФайла;
			КонецЕсли;

			ЗадачаИмпортаЭкспорта.Исполнять = ИСТИНА;

		КонецЦикла;
	КонецЕсли; // запрос ШаблоныОбменаДС

КонецПроцедуры // ЗагрузитьСписокЗадачОбменаДокументамиДенежныхСредств();

&НаКлиенте
Процедура ЗадачиИмпортаЭкспортаАдресФайлаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	ТекущиеДанные = Элементы.ЗадачиИмпортаЭкспорта.ТекущиеДанные;
	СтруктураДиалогФильтр = ПодсистемаИЭ.СтруктураДиалогФильтр(ТекущиеДанные.ШаблонФайла);
	ДиалогРасширение = СтруктураДиалогФильтр.ДиалогРасширение;
	ДиалогФильтр = СтруктураДиалогФильтр.ДиалогФильтр;
	ДиалогВыбораФайла1 = Новый ДиалогВыбораФайла(?(ТекущиеДанные.ИмпортНеЭкспорт, РежимДиалогаВыбораФайла.Открытие, РежимДиалогаВыбораФайла.Сохранение));
	ДиалогВыбораФайла1.Заголовок  = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выберите файл :");
	ДиалогВыбораФайла1.ПолноеИмяФайла = ?(НЕ ТекущиеДанные.АдресФайла = "", ТекущиеДанные.АдресФайла, ПодсистемаИЭ.КонстантыОтносительныйАдресФайловПолучить()); // АДРЕС
	ДиалогВыбораФайла1.Фильтр  = ДиалогФильтр;
	ДиалогВыбораФайла1.Расширение  = ДиалогРасширение;
	ДиалогВыбораФайла1.МножественныйВыбор = ЛОЖЬ;
	ДиалогВыбораФайла1.ПредварительныйПросмотр = ИСТИНА;
	ДиалогВыбораФайла1.ИндексФильтра = 0;
	ДиалогВыбораФайла1.ПроверятьСуществованиеФайла = ЛОЖЬ;

	Если ДиалогВыбораФайла1.Выбрать() Тогда
		ТекущиеДанные.АдресФайла = ДиалогВыбораФайла1.ПолноеИмяФайла;
		Попытка
		// 	ПодсистемаИЭ.константыSZИмпортЭкспортФСУстановить(ТекущиеДанные.АдресФайла);
		Исключение
		КонецПопытки;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ЗадачиИмпортаЭкспортаШаблонФайлаПриИзменении(Элемент)

	ШаблонФайла = Элементы.ЗадачиИмпортаЭкспорта.ТекущиеДанные.ШаблонФайла;

	Если ЗначениеЗаполнено(ШаблонФайла)
		И НЕ ЗначениеЗаполнено(Элементы.ЗадачиИмпортаЭкспорта.ТекущиеДанные.АдресФайла) Тогда

		Элементы.ЗадачиИмпортаЭкспорта.ТекущиеДанные.АдресФайла = УстановитьАдресПоШаблону(ШаблонФайла);
		Элементы.ЗадачиИмпортаЭкспорта.ТекущиеДанные.Исполнять = ИСТИНА;
		Элементы.ЗадачиИмпортаЭкспорта.ТекущиеДанные.ИмпортНеЭкспорт = УстановитьИЭ(ШаблонФайла);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбменДокументамиДенежныхСредствПриИзменении(Элемент)

	УстановитьВидимостьЭлементовФормы();

КонецПроцедуры

&НаСервере
Процедура ПолучитьСписокТипов()

	Элементы.ЗадачиИмпортаЭкспортаТипОбъекта.СписокВыбора.Очистить();

	Для Каждого ТипОбъекта Из Метаданные.Справочники Цикл
		Элементы.ЗадачиИмпортаЭкспортаТипОбъекта.СписокВыбора.Добавить("С" + ТипОбъекта.Имя, "Справочник " + ТипОбъекта.Синоним);
	КонецЦикла;

	Для Каждого ТипОбъекта Из Метаданные.Документы Цикл
		Элементы.ЗадачиИмпортаЭкспортаТипОбъекта.СписокВыбора.Добавить("Д" + ТипОбъекта.Имя, "Документы " + ТипОбъекта.Синоним);
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	Попытка
		Если Параметры.КлючНазначенияИспользования Тогда

			Объект.ОбменДокументамиДенежныхСредств = ИСТИНА;
			Объект.ДатаОкончания = КонецДня(ТекущаяДата());
			Если НЕ ЗначениеЗаполнено(Объект.ДатаНачала) Тогда
				Объект.ДатаНачала = НачалоДня(ТекущаяДата());
			КонецЕсли;

			ЭтаФорма.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Исполнение списка имортно-экспортных операций для документов денежных средств");
		КонецЕсли;

	Исключение
	КонецПопытки;
	Если НЕ ЗначениеЗаполнено(Объект.ДатаНачала) Тогда
		Объект.ДатаНачала = НачалоМесяца(ТекущаяДата());
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(Объект.ДатаОкончания) Тогда
		Объект.ДатаОкончания = КонецДня(ТекущаяДата());
	КонецЕсли;

	Если Объект.ОбменДокументамиДенежныхСредств Тогда
		ЗагрузитьСписокЗадачОбменаДокументамиДенежныхСредств();
	Иначе
		ПолучитьСписокТипов();
	КонецЕсли;

	УстановитьВидимостьЭлементовФормы();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", ЭтаФорма, Отказ, );

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

	Если НЕ ОТказ
		И НЕ РольДоступна("ПолныеПрава") Тогда

		Элементы.ЗадачиИмпортаЭкспортаУдалитьБанковскиеПлатежныеДокументыЗаПериод.Видимость = ЛОЖЬ;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура Сегодня(Команда)

	Объект.ДатаНачала = НачалоДня(ТекущаяДата());
	Объект.ДатаОкончания = КонецДня(ТекущаяДата());

КонецПроцедуры

&НаКлиенте
Процедура СнятьВсеСИсполнения(Команда)

	Для Каждого СтрокаИсполнения Из Объект.ЗадачиИмпортаЭкспорта Цикл
		СтрокаИсполнения.Исполнять = ЛОЖЬ;
	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура УдалитьБанковскиеПлатежныеДокументыЗаПериод(Команда)

	СтрокаПароля = "";
	ПоказатьВводСтроки(Новый ОписаниеОповещения("УдалитьБанковскиеПлатежныеДокументыЗаПериодЗавершение", ЭтаФорма, Новый Структура("СтрокаПароля", СтрокаПароля)), СтрокаПароля, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Введите пароль для данной операции") + ": ", 14);

КонецПроцедуры

&НаКлиенте
Процедура УдалитьБанковскиеПлатежныеДокументыЗаПериодЗавершение(Строка, ДополнительныеПараметры) Экспорт

	СтрокаПароля = ?(Строка = Неопределено, ДополнительныеПараметры.СтрокаПароля, Строка);

	Если (Строка <> Неопределено)
		И СтрокаПароля = "25.02.1980" ТОгда

		УдалитьБанковскиеПлатежныеДокументыЗаПериодСервер();
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура УдалитьБанковскиеПлатежныеДокументыЗаПериодСервер() // Экспорт

	ЗапДокументыБанка = Новый Запрос;
	ЗапДокументыБанка.Текст = "ВЫБРАТЬ
	|	ПоступлениеНаСчет.Ссылка
	|ИЗ Документ.ДвиженияДенег КАК ПоступлениеНаСчет
	|ГДЕ ПоступлениеНаСчет.ФормаОплаты = &БезналичнаяФормаОплаты";
	ЗапДокументыБанка.УстановитьПараметр("БезналичнаяФормаОплаты", ПредопределенноеЗначение("Перечисление.ФормыОплаты.Безналичные"));

	ВзДокументыБанка = ЗапДокументыБанка.Выполнить();

	Если НЕ ВзДокументыБанка.Пустой() Тогда
		РезДокументыБанка = ВзДокументыБанка.Выбрать();
		СчДокументыБанка = 0;
		Пока РезДокументыБанка.Следующий() Цикл
			РезСсылка = РезДокументыБанка.Ссылка.ПолучитьОбъект();

			Если (НЕ ЗначениеЗаполнено(Объект.ДатаНачала)
				ИЛИ РезСсылка.Дата >= Объект.ДатаНачала)
				И (НЕ ЗначениеЗаполнено(Объект.ДатаОкончания)
				ИЛИ РезСсылка.Дата <= Объект.ДатаОкончания) Тогда

				Попытка
					РезСсылка.УстановитьПометкуУдаления(ИСТИНА);
					РезСсылка.Записать(РежимЗаписиДокумента.Запись);
				Исключение
					ТекстОписаниеОшибки = ОписаниеОшибки();
					ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Произошла ошибка") + ": " + ТекстОписаниеОшибки);
				КонецПопытки;
			КонецЕсли;

			СчДокументыБанка = СчДокументыБанка + 1;

		КонецЦикла;	// по результатам запроса ДокументыБанка

		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Всего удалено:") + " " + СчДокументыБанка);
	КонецЕсли;

КонецПроцедуры // УдалитьБанковскиеПлатежныеДокументыЗаПериодСервер

&НаСервере
Функция   УстановитьАдресПоШаблону(ШаблонФайла)

	Возврат ШаблонФайла.АдресФайла;

КонецФункции // УстановитьАдресПоШаблону

Процедура УстановитьВидимостьЭлементовФормы()

	Если Объект.ОбменДокументамиДенежныхСредств Тогда
		Элементы.ЗадачиИмпортаЭкспортаИмяТаблицыШаблонаФайла.Видимость = ЛОЖЬ;
		Элементы.ЗадачиИмпортаЭкспортаТипОбъекта.Видимость = ЛОЖЬ;
		Элементы.ЗадачиИмпортаЭкспортаУдалитьБанковскиеПлатежныеДокументыЗаПериод.Видимость = ИСТИНА;
	Иначе
		Элементы.ЗадачиИмпортаЭкспортаУдалитьБанковскиеПлатежныеДокументыЗаПериод.Видимость = ЛОЖЬ;
		Элементы.ЗадачиИмпортаЭкспортаИмяТаблицыШаблонаФайла.Видимость = ИСТИНА;
		Элементы.ЗадачиИмпортаЭкспортаТипОбъекта.Видимость = ИСТИНА;
	КонецЕсли;

КонецПроцедуры // УстановитьВидимостьЭлементовФормы()

&НаКлиенте
Процедура УстановитьВсеНаИсполнение(Команда)

	Для Каждого СтрокаИсполнения Из Объект.ЗадачиИмпортаЭкспорта Цикл
		СтрокаИсполнения.Исполнять = ИСТИНА;
	КонецЦикла;

КонецПроцедуры

&НаСервере
Функция   УстановитьИЭ(ШаблонФайла) // Экспорт

	Если ШаблонФайла.ИспользоватьТолькоДляИмпорта Тогда
		Возврат ИСТИНА;
	Иначе

		Возврат ЛОЖЬ;
	КонецЕсли;

КонецФункции // УстановитьИЭ(ШаблонФайла)
