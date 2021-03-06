﻿// sza151108-1536
// sza140425-1911
// sza130918-1611 :

&НаКлиенте
Перем ПропуститьИнициализацию;

&НаКлиенте
Процедура АналогиВыборЗначения(Элемент, Значение, СтандартнаяОбработка)

	ТекущиеДанные = Элементы.Аналоги.ТекущиеДанные;

	Если НЕ ТекущиеДанные = Неопределено Тогда
		Закрыть(ТекущиеДанные.Номенклатура);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция   ВвестиШтрихКод(ШтрихКод, Знач ТекстЗаголовка = "") Экспорт

	Результат = ЛОЖЬ;

	Если НЕ ЗначениеЗаполнено(ТекстЗаголовка) Тогда
		ТекстЗаголовка = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Введите Штрих-код");
	КонецЕсли;

	Если ВвестиЗначение(ШтрихКод, ТекстЗаголовка) Тогда
		Если НЕ ПустаяСтрока(ШтрихКод) Тогда
			Результат = ИСТИНА;
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаКлиенте
Процедура ВводШтрихКода(Команда)

	ТекКод = "";

	Если ВвестиШтрихКод(ТекКод) Тогда
		Если НЕ ОбработатьПолученныйШтрихкодНаСервере(ТекКод) Тогда
			ОбщийМодульКлиент.ВыдатьСигнал(ТекКод);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВидЦенПриИзменении(Элемент)

	ИзменитьВидЦен();

КонецПроцедуры

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
	"Артикул",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Код",
	"",
	?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
	, ЛОЖЬ
	);
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	Список.Отбор,
	"Комментарий",
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

		Если ДинамическийСписокПуст() Тогда
			СтрокаПоискаРус = ОбщийМодульКлиент.ПеревестиТекстНаЯзык(СтрокаПоиска, 0);
			ОбщийМодульКлиент.УстановитьЭлементОтбора(
			Список.Отбор,
			ПолеПоиска,
			СтрокаПоискаРус,
			?(НайтиПоТочномуСоответствию, ВидСравненияКомпоновкиДанных.равно, ВидСравненияКомпоновкиДанных.Содержит),
			,
			ЗначениеЗаполнено(СтрокаПоиска)
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
				ЗначениеЗаполнено(СтрокаПоиска)
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

&НаСервере
Процедура ИзменитьВидЦен()

	Список.Параметры.УстановитьЗначениеПараметра("ВидЦен", ВидЦен);
	Элементы.Список.Обновить();
	Если ИспользоватьЕдиницыИзмеренияНоменклатуры Тогда
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("ВидЦен", ВидЦен);
		Элементы.ОстаткиВЕдиницахИзмерения.Обновить();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ИспользуютсяИзображенияПриИзменении(Элемент)

	Элементы.ГруппаИзображения.Видимость = ИспользуютсяИзображения;

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
Функция   ОбработатьПолученныйШтрихкодНаКлиенте(ТекКод)

	Результат 	= ИСТИНА;
	КодЭлемента = ОбработатьПолученныйШтрихкодНаСервере(ТекКод);
	Если КодЭлемента <> Неопределено Тогда
		Результат = КодЭлемента;
	Иначе
		Результат = ЛОЖЬ;
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаСервере
Функция   ОбработатьПолученныйШтрихкодНаСервере(Знач ТекКод)

	КодЭлемента = ОбщийМодульТоварСервер.НайтиНоменклатуруПоШтрихКоду(ТекКод, ЛОЖЬ);

	Если ЗначениеЗаполнено(КодЭлемента) Тогда
		Результат = КодЭлемента;
	Иначе
		Результат = Неопределено;
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда

		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[1] = Неопределено Тогда
				ТекКод = Параметр[0];
			Иначе
				ТекКод = Параметр[1][1];
			КонецЕсли;

			Номенклатура = ОбработатьПолученныйШтрихкодНаКлиенте(ТекКод);

			Если ЗначениеЗаполнено(Номенклатура) Тогда
				Закрыть(Номенклатура);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПолеПоискаПриИзменении(Элемент)

	ВыполнитьПоискНаКлиенте();

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                              // ПРИ ЗАКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

	Если ИспользоватьПодключаемоеОборудование Тогда
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                         // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

	Если ИспользоватьПодключаемоеОборудование
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда

		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		Если НЕ МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка") + ": " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;

	Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("СопровождатьНоменклатуруИзображениями")
		И ИспользуютсяИзображения Тогда

		ИспользуютсяИзображения = ЛОЖЬ;
	КонецЕсли;

	Элементы.ГруппаИзображения.Видимость = ИспользуютсяИзображения;

	Если ЗначениеЗаполнено(КлиентПоставщик) Тогда
		ЭтаФорма.Заголовок = ЭтаФорма.Заголовок + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("для") + " " + КлиентПоставщик;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000200", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		Элементы.ПолеПоиска.СписокВыбора.Добавить("Наименование", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Наименованию"));

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьРеквизитАртикулНоменклатуры") Тогда
			Элементы.ПолеПоиска.СписокВыбора.Добавить("Артикул", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Артикулу"));
		КонецЕсли;

		Элементы.ПолеПоиска.СписокВыбора.Добавить("Комментарий", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Комментарию"));
		Элементы.ПолеПоиска.СписокВыбора.Добавить("Код", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По Коду"));
		ИспользоватьМеханизмАналоговДляНоменклатуры = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьМеханизмАналоговДляНоменклатуры");
		ИспользоватьЕдиницыИзмеренияНоменклатуры 	= ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьЕдиницыИзмеренияНоменклатуры");
		ИспользоватьСложныйМеханизмЦен 				= ПараметрыСеанса.ИспользоватьСложныйМеханизмЦенПС ;
		ИспользоватьПодключаемоеОборудование 		= ПодключаемоеОборудованиеДСервер.ИспользоватьПодключаемоеОборудование();
		СложныйНабор							 	= ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьНаборыТоваров") И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВыводитьДляНаборовНоменклатурыПоказыватьМаксимальныйОстаток");
		ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры");

		Если СложныйНабор Тогда
			ТекстЗапроса = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
			               |	СправочникНоменклатура.ПометкаУдаления,
			               |	СправочникНоменклатура.Родитель,
			               |	СправочникНоменклатура.ЭтоГруппа,
			               |	СправочникНоменклатура.Код,
			               |	СправочникНоменклатура.Наименование,
			               |	СправочникНоменклатура.НоменклатурнаяГруппа,
			               |	СправочникНоменклатура.Производитель,
			               |	СправочникНоменклатура.ОсновнойШтрихКод,
			               |	СправочникНоменклатура.Артикул,
			               |	ВЫРАЗИТЬ(СправочникНоменклатура.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
			               |	СправочникНоменклатура.SKU,
			               |	СправочникНоменклатура.ПроцентСкидки,
			               |	СправочникНоменклатура.РекомендуемыйМинимальныйОстатокТовара,
			               |	СправочникНоменклатура.Предопределенный,
			               |	ВЫБОР
			               |		КОГДА &ИспользоватьСложныйМеханизмЦен
			               |			ТОГДА ЕСТЬNULL(ЗапросКЦене.Цена, 0)
			               |		ИНАЧЕ СправочникНоменклатура.Цена
			               |	КОНЕЦ КАК Цена,
			               |	СправочникНоменклатура.Ответственный,
			               |	СправочникНоменклатура.ДатаСоздания,
			               |	СправочникНоменклатура.ДатаРедакции,
			               |	ВЫБОР
			               |		КОГДА НЕ &ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры
			               |				ИЛИ ВЫБОР
			               |					КОГДА НЕ СправочникНоменклатура.ЭтоНабор
			               |						ТОГДА ЕСТЬNULL(ЗапросКОстаткам.КоличествоОстаток, 0)
			               |					ИНАЧЕ ЕСТЬNULL(ЗапросНабора.Остаток, 0)
			               |				КОНЕЦ > 0
			               |			ТОГДА ВЫБОР
			               |					КОГДА НЕ СправочникНоменклатура.ЭтоНабор
			               |						ТОГДА ЕСТЬNULL(ЗапросКОстаткам.КоличествоОстаток, 0)
			               |					ИНАЧЕ ЕСТЬNULL(ЗапросНабора.Остаток, 0)
			               |				КОНЕЦ
			               |		ИНАЧЕ 0
			               |	КОНЕЦ КАК Остаток,
			               |	СправочникНоменклатура.ЭтоНабор,
			               |	СправочникНоменклатура.НеОтслеживатьОстаток,
			               |	СправочникНоменклатура.НаименованиеДляПечати,
			               |	СправочникНоменклатура.СерийныйУчет,
			               |	СправочникНоменклатура.ЗапретитьУказаниеБезСерии,
			               |	СправочникНоменклатура.КоличествоПоУмолчанию,
			               |	СправочникНоменклатура.Вес,
			               |	СправочникНоменклатура.Длина,
			               |	СправочникНоменклатура.Ширина,
			               |	СправочникНоменклатура.Высота,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы1,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы2,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы3,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы4,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы5,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы6,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы7,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы8,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы9,
			               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы10,
			               |	СправочникНоменклатура.Ссылка
			               |ИЗ
			               |	Справочник.Номенклатура КАК СправочникНоменклатура
			               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
			               |			ЦеныСрезПоследних.Цена КАК Цена,
			               |			ЦеныСрезПоследних.Номенклатура КАК Номенклатура
			               |		ИЗ
			               |			РегистрСведений.Цены.СрезПоследних(
			               |					&Дата,
			               |					ВидЦен = &ВидЦен
			               |						И ЕдиницаИзмерения = &ПустаяЕдиницаИзмерения) КАК ЦеныСрезПоследних) КАК ЗапросКЦене
			               |		ПО СправочникНоменклатура.Ссылка = ЗапросКЦене.Номенклатура
			               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
			               |			СУММА(ТоварыОстатки.КоличествоОстаток) КАК КоличествоОстаток,
			               |			ТоварыОстатки.Номенклатура КАК НоменклатураОстаток
			               |		ИЗ
			               |			РегистрНакопления.Товары.Остатки(
			               |					&Дата,
			               |					НЕ &ОтборПоСкладу
			               |						ИЛИ (Склад = &Склад
			               |							ИЛИ Склад = &СкладПополнения)) КАК ТоварыОстатки
			               |
			               |		СГРУППИРОВАТЬ ПО
			               |			ТоварыОстатки.Номенклатура) КАК ЗапросКОстаткам
			               |		ПО СправочникНоменклатура.Ссылка = ЗапросКОстаткам.НоменклатураОстаток
			               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
			               |			МИНИМУМ(ВЫРАЗИТЬ(ЗапросКОстаткамЭлементовНабора.КоличествоОстаток / ВЫБОР
			               |						КОГДА НоменклатураСостав.Количество <= 0
			               |							ТОГДА 0
			               |						ИНАЧЕ НоменклатураСостав.Количество
			               |					КОНЕЦ КАК ЧИСЛО(10, 0))) КАК Остаток,
			               |			НоменклатураСостав.Ссылка КАК НоменклатураНабора
			               |		ИЗ
			               |			Справочник.Номенклатура.Состав КАК НоменклатураСостав
			               |				ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
			               |					СУММА(ТоварыОстатки.КоличествоОстаток) КАК КоличествоОстаток,
			               |					ТоварыОстатки.Номенклатура КАК НоменклатураОстатка
			               |				ИЗ
			               |					РегистрНакопления.Товары.Остатки(
			               |							&Дата,
			               |							НЕ &ОтборПоСкладу
			               |								ИЛИ (Склад = &Склад
			               |									ИЛИ Склад = &СкладПополнения)) КАК ТоварыОстатки
			               |
			               |				СГРУППИРОВАТЬ ПО
			               |					ТоварыОстатки.Номенклатура) КАК ЗапросКОстаткамЭлементовНабора
			               |				ПО НоменклатураСостав.Номенклатура = ЗапросКОстаткамЭлементовНабора.НоменклатураОстатка
			               |
			               |		СГРУППИРОВАТЬ ПО
			               |			НоменклатураСостав.Ссылка) КАК ЗапросНабора
			               |		ПО (ЗапросНабора.НоменклатураНабора = СправочникНоменклатура.Ссылка)
			               |ГДЕ
			               |	(&НеОтбиратьТолькоСОстатком
			               |			ИЛИ (СправочникНоменклатура.НеОтслеживатьОстаток = ИСТИНА
			               |				ИЛИ СправочникНоменклатура.ЭтоГруппа = ИСТИНА
			               |				ИЛИ СправочникНоменклатура.ЭтоНабор = ИСТИНА
			               |				ИЛИ СправочникНоменклатура.Предопределенный = ИСТИНА
			               |				ИЛИ (&ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры
			               |						И ЗапросКОстаткам.КоличествоОстаток > 0
			               |					ИЛИ ЗапросКОстаткам.КоличествоОстаток <> 0)))";
		Иначе // обычный
		ТекстЗапроса = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		               |	СправочникНоменклатура.ПометкаУдаления,
		               |	СправочникНоменклатура.Родитель,
		               |	СправочникНоменклатура.ЭтоГруппа,
		               |	СправочникНоменклатура.Код,
		               |	СправочникНоменклатура.Наименование,
		               |	СправочникНоменклатура.НоменклатурнаяГруппа,
		               |	СправочникНоменклатура.Производитель,
		               |	СправочникНоменклатура.ОсновнойШтрихКод,
		               |	СправочникНоменклатура.Артикул,
		               |	ВЫРАЗИТЬ(СправочникНоменклатура.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		               |	СправочникНоменклатура.SKU,
		               |	СправочникНоменклатура.ПроцентСкидки,
		               |	СправочникНоменклатура.РекомендуемыйМинимальныйОстатокТовара,
		               |	СправочникНоменклатура.Предопределенный,
		               |	ВЫБОР
		               |		КОГДА &ИспользоватьСложныйМеханизмЦен
		               |			ТОГДА ЕСТЬNULL(ЗапросКЦкенам.Цена, 0)
		               |		ИНАЧЕ СправочникНоменклатура.Цена
		               |	КОНЕЦ КАК Цена,
		               |	СправочникНоменклатура.Ответственный,
		               |	СправочникНоменклатура.ДатаСоздания,
		               |	СправочникНоменклатура.ДатаРедакции,
		               |	ВЫБОР
		               |		КОГДА НЕ &ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры
		               |				ИЛИ ЕСТЬNULL(ЗапросКОстаткам.КоличествоОстаток, 0) > 0
		               |			ТОГДА ЕСТЬNULL(ЗапросКОстаткам.КоличествоОстаток, 0)
		               |		ИНАЧЕ 0
		               |	КОНЕЦ КАК Остаток,
		               |	СправочникНоменклатура.ЭтоНабор,
		               |	СправочникНоменклатура.НеОтслеживатьОстаток,
		               |	СправочникНоменклатура.НаименованиеДляПечати,
		               |	СправочникНоменклатура.СерийныйУчет,
		               |	СправочникНоменклатура.ЗапретитьУказаниеБезСерии,
		               |	СправочникНоменклатура.КоличествоПоУмолчанию,
		               |	СправочникНоменклатура.Вес,
		               |	СправочникНоменклатура.Длина,
		               |	СправочникНоменклатура.Ширина,
		               |	СправочникНоменклатура.Высота,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы1,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы2,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы3,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы4,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы5,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы6,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы7,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы8,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы9,
		               |	СправочникНоменклатура.РеквизитНоменклатурнойГруппы10,
		               |	СправочникНоменклатура.Ссылка,
		               |	СправочникНоменклатура.ПроСостав
		               |ИЗ
		               |	Справочник.Номенклатура КАК СправочникНоменклатура
		               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		               |			ЦеныСрезПоследних.Цена КАК Цена,
		               |			ЦеныСрезПоследних.Номенклатура КАК Номенклатура
		               |		ИЗ
		               |			РегистрСведений.Цены.СрезПоследних(
		               |					&Дата,
		               |					ВидЦен = &ВидЦен
		               |						И ЕдиницаИзмерения = &ПустаяЕдиницаИзмерения) КАК ЦеныСрезПоследних) КАК ЗапросКЦкенам
		               |		ПО СправочникНоменклатура.Ссылка = ЗапросКЦкенам.Номенклатура
		               |		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ РАЗЛИЧНЫЕ
		               |			СУММА(ТоварыОстатки.КоличествоОстаток) КАК КоличествоОстаток,
		               |			ТоварыОстатки.Номенклатура КАК НоменклатураОстаток
		               |		ИЗ
		               |			РегистрНакопления.Товары.Остатки(
		               |					&Дата,
		               |					НЕ &ОтборПоСкладу
		               |						ИЛИ (Склад = &Склад
		               |							ИЛИ Склад = &СкладПополнения)) КАК ТоварыОстатки
		               |
		               |		СГРУППИРОВАТЬ ПО
		               |			ТоварыОстатки.Номенклатура) КАК ЗапросКОстаткам
		               |		ПО СправочникНоменклатура.Ссылка = ЗапросКОстаткам.НоменклатураОстаток
		               |ГДЕ
		               |	(&НеОтбиратьТолькоСОстатком
		               |			ИЛИ (СправочникНоменклатура.НеОтслеживатьОстаток = ИСТИНА
		               |				ИЛИ СправочникНоменклатура.ЭтоГруппа = ИСТИНА
		               |				ИЛИ СправочникНоменклатура.ЭтоНабор = ИСТИНА
		               |				ИЛИ СправочникНоменклатура.Предопределенный = ИСТИНА
		               |				ИЛИ (&ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры
		               |						И ЗапросКОстаткам.КоличествоОстаток > 0
		               |					ИЛИ ЗапросКОстаткам.КоличествоОстаток <> 0)))";
			//!! наборы без склада пополнения
		КонецЕсли;

		Список.ТекстЗапроса = ТекстЗапроса;

		КлиентПоставщик = Параметры.КлиентПоставщик;
		ВидЦен = ПредопределенноеЗначение("Справочник.ВидыЦен.ПустаяСсылка");
		Если ИспользоватьСложныйМеханизмЦен Тогда
			Если ЗначениеЗаполнено(Параметры.ВидЦен) Тогда
				ВидЦен = Параметры.ВидЦен;
			Иначе
				ВидЦен = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВидЦенРасходованияПоУмолчанию");

				Если НЕ ЗначениеЗаполнено(ВидЦен) Тогда
					ВидЦен = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВидЦенПриходованияТовараПоУмолчанию");
					Если НЕ ЗначениеЗаполнено(ВидЦен) Тогда
						ВидЦен = ПредопределенноеЗначение("Справочник.ВидыЦен.ГлавныйВидЦен");
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;

			ИзменитьВидЦен();
		КонецЕсли;

		Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры", ПоказыватьНольЕслиОстаткиОтрицательныеВСпискеНоменклатуры);
		Список.Параметры.УстановитьЗначениеПараметра("ИспользоватьСложныйМеханизмЦен", ИспользоватьСложныйМеханизмЦен);
		Список.Параметры.УстановитьЗначениеПараметра("ВидЦен", ВидЦен);
		Аналоги.Параметры.УстановитьЗначениеПараметра("Номенклатура", ПредопределенноеЗначение("Справочник.Номенклатура.ПустаяСсылка"));
		ИспользуетсяОтборПоСкладу = ЗначениеЗаполнено(Параметры.ОтборПоСкладу) И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоСкладам");
		ОтборПоСкладу 			  = Параметры.ОтборПоСкладу;
		ВызовИзРасходаТовара 	  = Параметры.ВызовИзРасходаТовара;
		Список.Параметры.УстановитьЗначениеПараметра("ПустаяЕдиницаИзмерения", ПредопределенноеЗначение("Справочник.ЕдиницыИзмерения.ПустаяСсылка"));
		Список.Параметры.УстановитьЗначениеПараметра("ОтборПоСкладу", ИспользуетсяОтборПоСкладу);
		Список.Параметры.УстановитьЗначениеПараметра("Склад", ОтборПоСкладу);
		Список.Параметры.УстановитьЗначениеПараметра("СкладПополнения", ?(ИспользуетсяОтборПоСкладу и ВызовИзРасходаТовара, ОтборПоСкладу.СкладПополнения, ПредопределенноеЗначение("Справочник.Склады.ПустаяСсылка")));
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("ИспользоватьСложныйМеханизмЦен", ИспользоватьСложныйМеханизмЦен);
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("ДатаОстатка", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("Номенклатура", ПредопределенноеЗначение("Справочник.Номенклатура.ПустаяСсылка"));
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("НетОтбораПоСкладу", Не используетсяОтборПоСкладу);
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("ВидЦен", ВидЦен);
		ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("ОтборПоСкладу", ОтборПоСкладу);

		Если ИспользуетсяОтборПоСкладу
			И ВызовИзРасходаТовара
			И ЗначениеЗаполнено(ОтборПоСкладу.СкладПополнения) Тогда

			Элементы.ОтборПоСкладу.Видимость 	  = ЛОЖЬ;
			Элементы.ОтборПоСкладуСкладПополнения.Видимость = ЛОЖЬ;
			Элементы.отборПоскладуТекст.видимость = ИСТИНА;
			Элементы.отборПоскладуТекст.заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Отбор на складах") + ": " + СокрЛП(ОтборПоСкладу) + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("и") + " " + СокрЛП(ОтборПоСкладу.СкладПополнения);
		Иначе
			Элементы.отборПоскладуТекст.видимость = ЛОЖЬ;
			Элементы.ОтборПоСкладу.Видимость 	  = ИспользуетсяОтборПоСкладу;
			Элементы.ОтборПоСкладуСкладПополнения.Видимость = ИспользуетсяОтборПоСкладу;
		КонецЕсли;

		Попытка

			Если (ВызовИзРасходаТовара или параметры.ИзПеремещения)
				И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ДемонстрироватьПриВыбореНоменклатурыПриРасходованииИПеремещенииТолькоСОстатками") Тогда

				Список.Параметры.УстановитьЗначениеПараметра("НеОтбиратьТолькоСОстатком", ЛОЖЬ);
			Иначе
				Список.Параметры.УстановитьЗначениеПараметра("НеОтбиратьТолькоСОстатком", ИСТИНА);
			КонецЕсли;

		Исключение
		КонецПопытки;

		ИспользуетсяОтборПоДате = ЗначениеЗаполнено(параметры.ОтборПоДате);
		ОтборПоДате = Параметры.ОтборПоДате;
		Список.Параметры.УстановитьЗначениеПараметра("Дата", ?(ИспользуетсяОтборПоДате, ОтборПоДате, ОбщийМодульСервисСервер.ПользователяТекущаяДата()));
		Аналоги.Параметры.УстановитьЗначениеПараметра("НетОтбораПоСкладу", Не используетсяОтборПоСкладу);
		Аналоги.Параметры.УстановитьЗначениеПараметра("ОтборПоСкладу", ОтборПоСкладу);
		Аналоги.Параметры.УстановитьЗначениеПараметра("ДатаОстатка", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
		Элементы.ПроцентСкидки.Видимость = ПараметрыСеанса.ВключитьВозможностьУказыватьПроцентСкидкиДляНоменклатуры;
		Элементы.ОтборПоДате.Видимость 	 = ИспользуетсяОтборПоДате;
		Элементы.ПроСостав.Видимость 	 = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьНаборыТоваров") И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков");
		ИспользоватьДополнительныеРеквизитыНоменклатурныхГрупп = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьДополнительныеРеквизитыНоменклатурныхГрупп");

		Если ИспользоватьДополнительныеРеквизитыНоменклатурныхГрупп Тогда
			НаименованияДополнительныхРеквизитов = ОбщийМодульПовтор.ПолучитьДополнительныеРеквизитыНоменклатурныхГрупп(, ИСТИНА);
			Если НЕ НаименованияДополнительныхРеквизитов = Неопределено Тогда
				Счетчик = 1;

				Для Каждого ДопРеквизит Из НаименованияДополнительныхРеквизитов Цикл
					Выполнить(" Элементы.РеквизитНоменклатурнойГруппы" + СокрЛП(Счетчик) + ".Видимость = ИСТИНА;");
					Выполнить(" Элементы.РеквизитНоменклатурнойГруппы" + СокрЛП(Счетчик) + ".Заголовок = """ + ДопРеквизит.ИмяДопРеквизита + """;");
					Выполнить(" Элементы.РеквизитНоменклатурнойГруппы" + СокрЛП(Счетчик) + ".Подсказка = """ + ДопРеквизит.ИмяДопРеквизита + """;");
					Счетчик = Счетчик + 1;
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;

		ОбщийМодульСервисСервер.ОформитьФорматКоличества(Элементы.Остаток, , ИСТИНА);
		ОбщийМодульСервисСервер.ОформитьФорматКоличества(Элементы.АналогиКоличество, , ИСТИНА);
		ОбщийМодульСервисСервер.ОформитьФорматКоличества(Элементы.АналогиОстаток, , ИСТИНА);
		ОбщийМодульСервер.ОбеспечитьСписокОтборов(Список);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	ПодключитьОбработчикОжидания("СписокПриАктивизацииСтрокиОповещение", 0.2, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтрокиОповещение()

	ТекущиеДанные = Элементы.Список.ТекущиеДанные;

	Если НЕ ПропуститьИнициализацию
		И НЕ ТекущиеДанные = Неопределено ТОгда

		Попытка
			Номенклатура = ТекущиеДанные.Ссылка;
			Если ТекущаяНоменклатура = Номенклатура Тогда
				Возврат;
			Иначе
				ТекущаяНоменклатура = Номенклатура;
			КонецЕсли;

		Исключение // спрятал колонку ссылка
		КонецПопытки;
		Если ИспользуютсяИзображения Тогда
			ПодСсылку = "";
			ТекущийЭлементСписка = Элементы.Список.ТекущаяСтрока;

			Если ЗначениеЗаполнено(ТекущийЭлементСписка) Тогда
				ОсновноеИзображениеОбъекта = ОбщийМодульПовтор.ПолучитьОсновноеИзображениеОбъекта(ТекущийЭлементСписка);
				Если ЗначениеЗаполнено(ОсновноеИзображениеОбъекта) Тогда
					СтруктураИзображения = ОбщийМодульСервер.ПолучитьСтруктуруИзображения(ОсновноеИзображениеОбъекта);
					ПодСсылку = СтруктураИзображения.ПодСсылку;
					Элементы.СсылкаНаИзображение.Видимость = НЕ СтруктураИзображения.ИзображениеВБазеДанных;
					Элементы.ИзображениеВБазеДанных.Видимость = СтруктураИзображения.ИзображениеВБазеДанных;

					Если СтруктураИзображения.РазмерПриОтображении = 1 Тогда
						Элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.АвтоРазмер
					ИначеЕсли СтруктураИзображения.РазмерПриОтображении = 2 Тогда

						Элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.Пропорционально
					ИначеЕсли СтруктураИзображения.РазмерПриОтображении = 3 Тогда

						Элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.Растянуть
					ИначеЕсли СтруктураИзображения.РазмерПриОтображении = 4 Тогда

						Элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.РеальныйРазмер
					ИначеЕсли СтруктураИзображения.РазмерПриОтображении = 5 Тогда

						Элементы.ИзображениеВБазеДанных.РазмерКартинки = РазмерКартинки.Черепица
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		Если ИспользоватьЕдиницыИзмеренияНоменклатуры Тогда
			УНоменклатурыЕстьЕдиницыИзмерения = ОбщийМодульКлиент.УНоменклатурыЕстьЕдиницыИзмерения(Номенклатура);
			Если УНоменклатурыЕстьЕдиницыИзмерения Тогда
				ОстаткиВЕдиницахИзмерения.Параметры.УстановитьЗначениеПараметра("Номенклатура", Номенклатура);

				Если НЕ Элементы.ОстаткиВЕдиницахИзмерения.Видимость Тогда
					Элементы.ОстаткиВЕдиницахИзмерения.Видимость = ИСТИНА;
				КонецЕсли;
			ИначеЕсли Элементы.ОстаткиВЕдиницахИзмерения.Видимость Тогда
				Элементы.ОстаткиВЕдиницахИзмерения.Видимость = ЛОЖЬ;
				ПропуститьИнициализацию = ИСТИНА;
			КонецЕсли;
		КонецЕсли;

		Если ИспользоватьМеханизмАналоговДляНоменклатуры Тогда
			АналогиЕсть = ОбщийМодульКлиент.УНоменклатурыЕстьАналоги(Номенклатура);
			Если АналогиЕсть Тогда
				Аналоги.Параметры.УстановитьЗначениеПараметра("Номенклатура", Номенклатура);

				Если НЕ Элементы.Аналоги.Видимость Тогда
					Элементы.Аналоги.Видимость = ИСТИНА;
				КонецЕсли;
			ИначеЕсли Элементы.Аналоги.Видимость Тогда
				Элементы.Аналоги.Видимость = ЛОЖЬ;
				ПропуститьИнициализацию = ИСТИНА;
			КонецЕсли;
		КонецЕсли;
	Иначе
		ПропуститьИнициализацию = ЛОЖЬ;
	КонецЕсли;

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

ПропуститьИнициализацию = ЛОЖЬ;
