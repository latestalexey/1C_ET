﻿// sza141203-1531
// sza141203-0122
// sza141129-0021

&НаКлиенте
Процедура Артикул(Команда)

	Запись.Поле = ПредопределенноеЗначение("Перечисление.ПоляПредставленийНоменклатуры.Артикул");
	ОбновитьСобственноеЗначение();

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьЭтотЯзык(Команда)

	Запись.Язык = ЯзыкДокументовКонтрагента;

КонецПроцедуры

&НаКлиенте
Процедура КлиентПоставщикПриИзменении(Элемент)

	КлиентПоставщикПриИзмененииНаСервере();

КонецПроцедуры

&НаСервере
Процедура КлиентПоставщикПриИзмененииНаСервере()

	Если ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского
		И ЗначениеЗаполнено(Запись.КлиентПоставщик) Тогда

		ЯзыкДокументовКонтрагента = Запись.КлиентПоставщик.ЯзыкДокументов;
	КонецЕсли;

	Элементы.ГруппаПодЯзыкКонтрагента.Видимость = ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского И ЗначениеЗаполнено(ЯзыкДокументовКонтрагента);

КонецПроцедуры

&НаКлиенте
Процедура Наименование(Команда)

	Запись.Поле = ПредопределенноеЗначение("Перечисление.ПоляПредставленийНоменклатуры.Наименование");
	ОбновитьСобственноеЗначение();

КонецПроцедуры

&НаКлиенте
Процедура НаименованиеДляПечати(Команда)

	Запись.Поле = ПредопределенноеЗначение("Перечисление.ПоляПредставленийНоменклатуры.НаименованиеДляПечати");
	ОбновитьСобственноеЗначение();

КонецПроцедуры

&НаКлиенте
Процедура НоменклатураПриИзменении(Элемент)
	ОбновитьСобственноеЗначение();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСобственноеЗначение()
	Запись.СобственноеПредставление = ОбщийМодульТоварСервер.СобственноеЗначениеНаСервере(Запись.Номенклатура, Запись.Язык, Запись.Поле);
КонецПроцедуры

&НаКлиенте
Функция   ОбработатьПолученныйШтрихкодНаКлиенте(Знач ТекКод)

	Результат = ИСТИНА;
	КодЭлемента = ОбработатьПолученныйШтрихкодНаСервере(ТекКод);
	Если КодЭлемента <> Неопределено Тогда
		Запись.Номенклатура = КодЭлемента;
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

			Если НЕ ОбработатьПолученныйШтрихкодНаКлиенте(ТекКод) Тогда
				СообщитьОбОшибке(ТекКод)
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)

	Если Запись.ЗначениеПредставления = Запись.СобственноеПредставление Тогда
		Отказ = ИСТИНА;
		ПоказатьПредупреждение(Неопределено, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Значения представления не отличаются!"), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Внимание"));
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПолеПриИзменении(Элемент)
	ОбновитьСобственноеЗначение();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

	Если СканерБылПодключен
		И ИспользоватьПодключаемоеОборудование Тогда

		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Запись.Ответственный, ИСТИНА);

	Если ИспользоватьПодключаемоеОборудование
		И НЕ ЗначениеЗаполнено(Запись.Номенклатура)
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда

		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить( "СканерШтрихКода" );
		Если НЕ МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка") + ": " + ОписаниеОшибки;
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;

		СканерБылПодключен = ИСТИНА;
	КонецЕсли;

	Если ЗначениеЗаполнено(Запись.Номенклатура) Тогда
		Если ЗначениеЗаполнено(Запись.КлиентПоставщик) Тогда
			Если ЗначениеЗаполнено(Запись.Поле) Тогда
				ЭтаФорма.ТекущийЭлемент = Элементы.ЗначениеПредставления;
			Иначе
				ЭтаФорма.ТекущийЭлемент = Элементы.Поле;
			КонецЕсли;
		Иначе
			ЭтаФорма.ТекущийЭлемент = Элементы.КлиентПоставщик;
		КонецЕсли;
	Иначе
		ЭтаФорма.ТекущийЭлемент = Элементы.Номенклатура;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("00065B", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ИспользоватьПодключаемоеОборудование = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьПодключаемоеОборудование");
		ВестиУчетПоКлиентам    = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоКлиентам");
		ВестиУчетПоПоставщикам = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоПоставщикам");
		ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского");

		Если НЕ ЗначениеЗаполнено(Запись.Номенклатура) Тогда
			Запись.Номенклатура = Параметры.Номенклатура;
		КонецЕсли;

		Если НЕ ЗначениеЗаполнено(Запись.КлиентПоставщик) Тогда

			Если ВестиУчетПоПоставщикам
				И НЕ ВестиУчетПоКлиентам Тогда

				Запись.КлиентПоставщик = ПредопределенноеЗначение("Справочник.Поставщики.ПустаяСсылка");
			ИначеЕсли НЕ ВестиУчетПоПоставщикам
				И ВестиУчетПоКлиентам Тогда

				Запись.КлиентПоставщик = ПредопределенноеЗначение("Справочник.Клиенты.ПустаяСсылка");
			КонецЕсли;
		КонецЕсли;

		Если ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского
			И ЗначениеЗаполнено(Запись.КлиентПоставщик) Тогда

			ЯзыкДокументовКонтрагента = Запись.КлиентПоставщик.ЯзыкДокументов;
		КонецЕсли;

		Элементы.ГруппаПодЯзыкКонтрагента.Видимость = ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского И ЗначениеЗаполнено(ЯзыкДокументовКонтрагента);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьСобственноеПредставление(Команда)
	Запись.ЗначениеПредставления = Запись.СобственноеПредставление;
КонецПроцедуры

&НаКлиенте
Процедура СообщитьОбОшибке(Знач ТекКод)

	ТекстПредупреждения 	= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Позиция номенклатуры не найдена!");
	ЗаголовокПредупреждения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поиск по штрихкоду");
	ПоказатьПредупреждение(Неопределено, ТекстПредупреждения, 10, ЗаголовокПредупреждения);

КонецПроцедуры

&НаКлиенте
Процедура ЯзыкПриИзменении(Элемент)
	ОбновитьСобственноеЗначение();
КонецПроцедуры
