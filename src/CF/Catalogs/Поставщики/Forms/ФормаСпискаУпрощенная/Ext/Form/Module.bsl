﻿// sza151214-0107 про
// sza140710-1750  локац
// sza140420-0424
// sza131115-1641

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
Функция   ОбработатьПолученныйШтрихкодНаКлиенте(Знач ТекКод)

	Результат = ИСТИНА;
	КодЭлемента = ОбработатьПолученныйШтрихкодНаСервере(ТекКод);
	Если КодЭлемента <> Неопределено Тогда
		ПараметрыОткрытия = Новый Структура("Ключ", КодЭлемента);
		ОткрытьФорму("Справочник.Поставщики.Форма.ФормаЭлемента", ПараметрыОткрытия);
	Иначе
		Результат = ЛОЖЬ;
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаСервере
Функция   ОбработатьПолученныйШтрихкодНаСервере(Знач ТекКод)

	КодЭлемента = ОбщийМодульСервер.НайтиКонтрагентаПоШтрихКоду(ТекКод, , ИСТИНА);

	Если ЗначениеЗаполнено(КодЭлемента) Тогда
		Результат = КодЭлемента;
	Иначе
		Результат = Неопределено;
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если ИспользоватьМагнитныеКартыКлиентов
		И Источник = "ПодключаемоеОборудование"
		И ВводДоступен () Тогда

		Если ИмяСобытия = "TracksData" Тогда
			ПолученКодИзСМК(Параметр);
		КонецЕсли;
	КонецЕсли;

	Если ИспользоватьШтрихКодыДляИдентификацииКонтрагентов
		И Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда

		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[1] = Неопределено Тогда
				ТекКод = Параметр[0];
			Иначе
				ТекКод = Параметр[1][1];
			КонецЕсли;

			Если НЕ ОбработатьПолученныйШтрихкодНаКлиенте(ТекКод) Тогда
				СообщитьОбОшибке(ТекКод)
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПолеПоискаПриИзменении(Элемент)
	ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ПолученКодИзСМК(Параметр)

	Если Параметр[1][3] <> Неопределено Тогда
		МКод = Параметр[1][3][0].ДанныеДорожек[0].ЗначениеПоля;
	Иначе
		МКод = Параметр[0];
	КонецЕсли;

	Поставщик = ПолучитьКлиентаНаСервере(МКод);

	Если НЕ Поставщик = Неопределено Тогда
		Закрыть(Поставщик);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция   ПолучитьКлиентаНаСервере(Знач МКод)

	Поставщик = ПодключаемоеОборудованиеДСервер.НайтиКлиентаПоМК(МКод, ИСТИНА);

	Если Поставщик <> Неопределено Тогда
		Возврат Поставщик;
	Иначе
		ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Карта не найдена.");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);

		Возврат Неопределено;
	КонецЕсли;

КонецФункции

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю
	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                     // ПРИ ЗАКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

	Если ИспользоватьПодключаемоеОборудование
		И (ИспользоватьМагнитныеКартыКлиентов или ИспользоватьШтрихКодыДляИдентификацииКонтрагентов) Тогда

		ПоддерживаемыеТипыВО = Новый Массив ();

		Если ИспользоватьМагнитныеКартыКлиентов Тогда
			ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
		КонецЕсли;

		Если ИспользоватьШтрихКодыДляИдентификацииКонтрагентов Тогда
			ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		КонецЕсли;

		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

	Если ИспользоватьПодключаемоеОборудование
		И (ИспользоватьМагнитныеКартыКлиентов ИЛИ ИспользоватьШтрихКодыДляИдентификацииКонтрагентов)
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда

		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		Если ИспользоватьМагнитныеКартыКлиентов Тогда
			ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
		КонецЕсли;

		Если ИспользоватьШтрихКодыДляИдентификацииКонтрагентов Тогда
			ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		КонецЕсли;

		Если НЕ МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка") + ": " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;

	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

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
		ИспользоватьШтрихКодыДляИдентификацииКонтрагентов = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьШтрихКодыДляИдентификацииКонтрагентов");
		ИспользоватьМагнитныеКартыКлиентов 		= ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьМагнитныеКартыКлиентов");
		ИспользоватьПодключаемоеОборудование 	= ПодключаемоеОборудованиеДСервер.ИспользоватьПодключаемоеОборудование();
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
Процедура СообщитьОбОшибке(Знач ТекКод)

	ТекстПредупреждения 	= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поставщик не найден!");
	ЗаголовокПредупреждения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поиск по штрихкоду");
	ПоказатьПредупреждение(Неопределено, ТекстПредупреждения, 10, ЗаголовокПредупреждения);

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
