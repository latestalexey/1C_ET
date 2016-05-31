﻿// sza151214-0107 про
// sza140710-1747  локац
// sza140420-0423
// sza130905-1658 :

&НаКлиенте
Процедура ВыполнитьПоискНаКлиенте()

	Если ПустаяСтрока(ПолеПоиска) Тогда
		ПолеПоиска = "Наименование";
	КонецЕсли;

	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Наименование",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Телефон",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"ОКПО",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"ИНН",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Адрес",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);

	Если ЗначениеЗаполнено(СтрокаПоиска) Тогда
		ОбщийМодульКлиент.УстановитьЭлементОтбора(
		Список.Отбор,
		ПолеПоиска,
		СтрокаПоиска,
		?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
		, ИСТИНА
		);

		Если ДинамическийСписокПуст()
			И НЕ ПолеПоиска = "Телефон"
			И НЕ ПолеПоиска = "ИНН"
			И НЕ ПолеПоиска = "ОКПО" Тогда

			СтрокаПоискаРус = ОбщийМодульКлиент.ПеревестиТекстНаЯзык(СтрокаПоиска, 0);
			ОбщийМодульКлиент.УстановитьЭлементОтбора(
			Список.Отбор,
			ПолеПоиска,
			СтрокаПоискаРус,
			?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
			,
			ИСТИНА
			);
			Элементы.Список.Обновить();

			Если ДинамическийСписокПуст() Тогда
				СтрокаПоискаАнгл = ОбщийМодульКлиент.ПеревестиТекстНаЯзык(СтрокаПоиска, 1);
				ОбщийМодульКлиент.УстановитьЭлементОтбора(
				Список.Отбор,
				ПолеПоиска,
				СтрокаПоискаАнгл,
				?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
				,
				ИСТИНА
				);
				Элементы.Список.Обновить();

				Если НЕ ДинамическийСписокПуст() Тогда
					СтрокаПоиска = СтрокаПоискаАнгл;
				КонецЕсли;
			Иначе
				СтрокаПоиска = СтрокаПоискаРус;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НайтиПоТочномуСоответствиюПриИзменении(Элемент)

	ВыполнитьПоискНаКлиенте();

КонецПроцедуры

&НаКлиенте
Функция   ДинамическийСписокПуст()

	Возврат Элементы.Список.ТекущиеДанные = Неопределено;

КонецФункции // НетНичего

&НаКлиенте
Процедура ПолеПоискаПриИзменении(Элемент)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                              // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                         // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

	Если НЕ УчетПоПоставщикам Тогда
		закрыть(ПредопределенноеЗначение("Справочник.Поставщики.ФизическоеЛицо"));
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000650", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		Элементы.ПолеПоиска.СписокВыбора.Добавить("Наименование", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Наименованию"));
		Элементы.ПолеПоиска.СписокВыбора.Добавить("Телефон", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Телефону"));
		Элементы.ПолеПоиска.СписокВыбора.Добавить("ОКПО", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По ОКПО"));
		Элементы.ПолеПоиска.СписокВыбора.Добавить("ИНН", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По ИНН"));
		Элементы.ПолеПоиска.СписокВыбора.Добавить("Адрес", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Адресу"));
		ФормироватьОписаниеТаблицОбъектовДляИхСписков = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков");
		Элементы.ПроВидыДеятельности.Видимость = ФормироватьОписаниеТаблицОбъектовДляИхСписков
		И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВидовДеятельности");
		Элементы.ПроЗакрепленныеСотрудники.Видимость = ФормироватьОписаниеТаблицОбъектовДляИхСписков
		И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетЗарплатыСотрудников");
		УчетПоПоставщикам = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоПоставщикам");
		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьРегионыДляУчетаСтранАЛокацииГородов") Тогда
			Элементы.Регион.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Страна");
			Элементы.Локация.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Город");
		КонецЕсли;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаАвтоПодбор(Элемент, Текст, ДанныеВыбора, Параметры, Ожидание, СтандартнаяОбработка)
	ОбщийМодульКлиент.ПодобратьЗначениеПоВведенномуТексту(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаОчистка(Элемент, СтандартнаяОбработка)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры
