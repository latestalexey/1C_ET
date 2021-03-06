﻿// sza150512-1601
// sza140420-2108
// sza131126-1704

&НаСервере
Процедура НайтиДобавитьСтроку(ТекКод)

	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("ШтрихКод", ТекКод);
	СтрокаТовара = Объект.ОписаниеСерийНоменклатуры.НайтиСтроки(ПараметрыОтбора);
	Если НЕ СтрокаТовара.Количество() = 0 Тогда
		СтрокаТовара = СтрокаТовара[0];
		Элементы.ОписаниеСерийНоменклатуры.ТекущаяСтрока  = СтрокаТовара.ПолучитьИдентификатор();
	Иначе
		НоваяСтрока = Объект.ОписаниеСерийНоменклатуры.Добавить();
		НоваяСтрока.Серия 	 = ТекКод;
		НоваяСтрока.ШтрихКод = ТекКод;

		Элементы.ОписаниеСерийНоменклатуры.ТекущаяСтрока  = НоваяСтрока.ПолучитьИдентификатор();
	КонецЕсли;

	Элементы.ОписаниеСерийНоменклатуры.ТекущийЭлемент = Элементы.ОписаниеСерийНоменклатурыШтрихКод;

КонецПроцедуры

&НаКлиенте
Процедура НоменклатураОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)

	ОбщийМодульКлиент.ПоискОшибкиПриВводеТекстаПользователем("Номенклатура", ДанныеВыбора, Текст, Объект.Номенклатура);
	ОбновитьВидимость();

КонецПроцедуры

&НаКлиенте
Процедура НоменклатураПриИзменении(Элемент)
	ОбновитьВидимость();
КонецПроцедуры

Процедура ОбновитьВидимость()
	Элементы.СформироватьСерииСНумерацией.Видимость = ЗначениеЗаполнено(Объект.Номенклатура);
КонецПроцедуры // ОбновитьВидимость

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если НЕ НеДобавлятьСерииСканером
		И Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда

		Если ИмяСобытия = "ScanData" Тогда
			Если Параметр[1] = Неопределено Тогда
				ТекКод = Параметр[0];
			Иначе
				ТекКод = Параметр[1][1];
			КонецЕсли;

			Если ЭтаФорма.ТекущийЭлемент = Элементы.ОписаниеСерийНоменклатурыКодПродукта Тогда
				ТекущиеДанные = Элементы.ОписаниеСерийНоменклатуры.ТекущиеДанные;
				ТекущиеДанные.КодПродукта = ТекКод;
			Иначе
				НайтиДобавитьСтроку(ТекКод);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

	Если ИспользоватьПодключаемоеОборудование
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда

		ОписаниеОшибки 			= "" ;
		ПоддерживаемыеТипыВО 	= Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		Если НЕ МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка") + ": " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

	Если ИспользоватьПодключаемоеОборудование
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда

		ОписаниеОшибки 			= "" ;
		ПоддерживаемыеТипыВО 	= Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		Если НЕ МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При подключении оборудования произошла ошибка") + ": " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;

	Если ЗначениеЗаполнено(Параметры.Номенклатура) Тогда
		Объект.Номенклатура = Параметры.Номенклатура;
	КонецЕсли;

	ОбновитьВидимость();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000300", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ИспользоватьПодключаемоеОборудование = ПодключаемоеОборудованиеДСервер.ИспользоватьПодключаемоеОборудование();
		ИспользоватьШтрихКоды				 = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьШтрихКоды");
		Если НЕ ЗначениеЗаполнено(ТипШтрихКодов) Тогда
			ТипШтрихКодов = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ТипШтрихКодов");

			Если НЕ ЗначениеЗаполнено(ТипШтрихКодов) Тогда
				ТипШтрихКодов = ПланыВидовХарактеристик.ТипыШтрихКодов.CODE128;
			КонецЕсли;
		КонецЕсли;

		ИспользоватьДополнительныеКодыСерий = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьДополнительныеКодыСерий");
		Элементы.ОписаниеСерийНоменклатурыДополнительныйКод1.Видимость = ИспользоватьДополнительныеКодыСерий;
		Элементы.ОписаниеСерийНоменклатурыДополнительныйКод2.Видимость = ИспользоватьДополнительныеКодыСерий;
		Элементы.ОписаниеСерийНоменклатурыДополнительныйКод3.Видимость = ИспользоватьДополнительныеКодыСерий;
		Элементы.ОписаниеСерийНоменклатурыДополнительныйКод4.Видимость = ИспользоватьДополнительныеКодыСерий;
		Элементы.ОписаниеСерийНоменклатурыДополнительныйКод5.Видимость = ИспользоватьДополнительныеКодыСерий;
		ФормулаГенерацииСерий = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормулаГенерацииСерий");
		Элементы.ОписаниеСерийНоменклатурыСформироватьСерию.Видимость = ЗначениеЗаполнено(ФормулаГенерацииСерий);
		ДобавитьККоду = ОбщийМодульСервисСервер.МаксимальныйКодЭлемента("СерииНоменклатуры", ИСТИНА);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСерии(Команда)

	Если НЕ ПроверитьСерииНаСервере() Тогда
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Серии указаны полностью."));
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция   ПроверитьСерииНаСервере(Отказ = ЛОЖЬ)

	Если НЕ ЗначениеЗаполнено(Объект.Номенклатура) Тогда
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Номенклатура не указана!"));
		Отказ = ИСТИНА;
	ИначеЕсли не ОбщийМодульПовтор.ТоварВедетсяПоСериям(Объект.Номенклатура) Тогда
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Эта Номенклатура не учитывается по сериям!"));
		Отказ = ИСТИНА;
	Иначе
		МассивИменСерий	= Новый Массив;
		МассивШтрихКода	= Новый Массив;

		Для Каждого СтрокаСерии Из Объект.ОписаниеСерийНоменклатуры Цикл
			Если НЕ ЗначениеЗаполнено(СтрокаСерии.Серия) Тогда
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("В строке №") + СтрокаСерии.НомерСтроки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("не указана серия!"));
				Отказ = ИСТИНА;
			ИначеЕсли не МассивИменСерий.Найти(СтрокаСерии.Серия) = Неопределено Тогда
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("В строке №") + СтрокаСерии.НомерСтроки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("повторяется серия") + ": " + СтрокаСерии.Серия);
				Отказ = ИСТИНА;
			Иначе
				МассивИменСерий.Добавить(СтрокаСерии.Серия);
			КонецЕсли;

			Если ИспользоватьШтрихКоды
				И ЗначениеЗаполнено(СтрокаСерии.ШтрихКод) Тогда

				ШтрихКод = СокрЛП(СтрокаСерии.ШтрихКод);

				Если НЕ МассивШтрихКода.Найти(ШтрихКод) = Неопределено Тогда
					ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("В строке №") + СтрокаСерии.НомерСтроки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("повторяется Штрих-код") + ": " + ШтрихКод);
					Отказ = ИСТИНА;
				Иначе
					ЕстьТакая 	 = ОбщийМодульТоварСервер.НайтиНоменклатуруПоШтрихКоду(ШтрихКод, ИСТИНА, ИСТИНА);
					Номенклатура = ЕстьТакая.Номенклатура;
					Серия		 = ЕстьТакая.СерияНоменклатуры;

					Если ЗначениеЗаполнено(Номенклатура) Тогда
						ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("В строке №") + СтрокаСерии.НомерСтроки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Штрих-код чужой") + ": " + Номенклатура + " " + Серия);
						Отказ = ИСТИНА;
					Иначе
						МассивШтрихКода.Добавить(СтрокаСерии.ШтрихКод);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;

		КонецЦикла;
	КонецЕсли;

	Возврат Отказ;

КонецФункции

&НаКлиенте
Процедура СоздатьНовуюНоменклатуру(Команда)

	Номенклатура = СоздатьНовуюСерийнуюНоменклатуру();
	ПоказатьЗначение(Новый ОписаниеОповещения("СоздатьНовуюНоменклатуруЗавершение", ЭтаФорма, Новый Структура("Номенклатура", Номенклатура)), Номенклатура);

КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовуюНоменклатуруЗавершение(ДополнительныеПараметры) Экспорт

	Номенклатура = ДополнительныеПараметры.Номенклатура;
	Объект.Номенклатура = Номенклатура;
	ОбновитьВидимость();

КонецПроцедуры

&НаСервере
Функция   СоздатьНовуюСерийнуюНоменклатуру()

	Номенклатура = Справочники.Номенклатура.СоздатьЭлемент();
	Номенклатура.СерийныйУчет = ИСТИНА;
	Номенклатура.Наименование = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Новый серийный товар") + " " + ТекущаяДата();
	Номенклатура.ОбменДанными.Загрузка = ИСТИНА;
	Номенклатура.Записать();

	Возврат Номенклатура.Ссылка;

КонецФункции // СоздатьНовуюСерийнуюНоменклатуру

&НаКлиенте
Процедура СоздатьСерииНоменклатуры(Команда)

	Если НЕ ПроверитьСерииНаСервере() Тогда
		Закрыть(СоздатьСерииНоменклатурыНаСервере());
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция   СоздатьСерииНоменклатурыНаСервере()

	МассивНовыхСерий = Новый Массив;

	Если НЕ ЗначениеЗаполнено(ТипШтрихКодов) Тогда
		ТипШтрихКодов = ПланыВидовХарактеристик.ТипыШтрихКодов.CODE128;
	КонецЕсли;

	КодыСерийУникальныИТакжеУказываютНаСерию = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("КодыСерийУникальныИТакжеУказываютНаСерию");

	Для Каждого СтрокаСерии Из Объект.ОписаниеСерийНоменклатуры Цикл
		НоваяСерия = Справочники.СерииНоменклатуры.СоздатьЭлемент();
		НоваяСерия.Владелец		= Объект.Номенклатура;
		НоваяСерия.Наименование	= СтрокаСерии.Серия;
		НоваяСерия.КодПродукта	= СтрокаСерии.КодПродукта;
		НоваяСерия.ДополнительныйКод1 = СтрокаСерии.ДополнительныйКод1;
		НоваяСерия.ДополнительныйКод2 = СтрокаСерии.ДополнительныйКод2;
		НоваяСерия.ДополнительныйКод3 = СтрокаСерии.ДополнительныйКод3;
		НоваяСерия.ДополнительныйКод4 = СтрокаСерии.ДополнительныйКод4;
		НоваяСерия.ДополнительныйКод5 = СтрокаСерии.ДополнительныйКод5;
		НоваяСерия.Записать();
		НоваяСерия = НоваяСерия.Ссылка;
		МассивНовыхСерий.Добавить(НоваяСерия.Ссылка);

		Если ИспользоватьШтрихКоды Тогда
			ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.Серия, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
			ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.ШтрихКод, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);

			Если КодыСерийУникальныИТакжеУказываютНаСерию Тогда
				ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.КодПродукта, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
				ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.ДополнительныйКод1, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
				ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.ДополнительныйКод2, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
				ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.ДополнительныйКод3, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
				ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.ДополнительныйКод4, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
				ОбщийМодульТоварСервер.ЗарегистрироватьШтрихКод(СтрокаСерии.ДополнительныйКод5, Объект.Номенклатура, ТипШтрихКодов, НоваяСерия);
			КонецЕсли;
		КонецЕсли;

	КонецЦикла;

	Результат = Новый Структура;
	Результат.Вставить("Номенклатура", Объект.Номенклатура);
	Результат.Вставить("МассивНовыхСерий", МассивНовыхСерий);

	Возврат Результат;

КонецФункции

&НаКлиенте
Процедура СформироватьСерииСНумерацией(Команда)

	ПараметрыФормы = Новый Структура("Номенклатура", Объект.Номенклатура);
	ФормаАвтоФормированияСерий = ПолучитьФорму("Обработка.ОперацииССериямиНоменклатуры.Форма.ФормированиеСерийСНумерацией", ПараметрыФормы);
	СтруктураВозврат = ФормаАвтоФормированияСерий.ОткрытьМодально();
	Если НЕ СтруктураВозврат = Неопределено Тогда
		ПрефиксАвтоНумерации 	= СтруктураВозврат.ПрефиксАвтоНумерации;
		НачальныйНомерСерии  	= СтруктураВозврат.НачальныйНомерСерии;
		КонечныйНомерСерии 	 	= СтруктураВозврат.КонечныйНомерСерии;
		ПостфиксАвтоНумерации 	= СтруктураВозврат.ПостфиксАвтоНумерации;
		ДобавлятьЛидирующиеНули = СтруктураВозврат.ДобавлятьЛидирующиеНули;
		ДлинаКонечногоНомера  	= СтрДлина(формат(КонечныйНомерСерии, "ЧДЦ=; ЧРГ=' '; ЧГ=0"));
		сч = НачальныйНомерСерии;

		пока сч < КонечныйНомерСерии Цикл
			СтрокаСерий = Объект.ОписаниеСерийНоменклатуры.Добавить();
			ЛидирующиеНули = "";
			Если ДобавлятьЛидирующиеНули Тогда
				счлн = 0;

				пока счлн < (ДлинаКонечногоНомера - стрдлина(СокрЛП(сч))) цикл
					счлн = счлн + 1;
					ЛидирующиеНули = ЛидирующиеНули + "0";
				КонецЦикла;
			КонецЕсли;

			СтрокаСерий.Серия = ПрефиксАвтоНумерации + ЛидирующиеНули + формат(сч, "ЧДЦ=; ЧРГ=' '; ЧГ=0") + ПостфиксАвтоНумерации;
			сч = сч + 1;
		КонецЦикла;

		ДобавитьККоду = ДобавитьККоду + сч;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СформироватьСерию(Команда)

	НоваяСтрока = Объект.ОписаниеСерийНоменклатуры.Добавить();
	НоваяСтрока.Серия 	 = ОбщийМодульТоварСервер.СгенерироватьСерию(ФормулаГенерацииСерий, Объект.Номенклатура, ДобавитьККоду);
	НоваяСтрока.ШтрихКод = НоваяСтрока.Серия;
	ДобавитьККоду 		 = ДобавитьККоду + 1;
	Элементы.ОписаниеСерийНоменклатуры.ТекущаяСтрока  = НоваяСтрока.ПолучитьИдентификатор();
	Элементы.ОписаниеСерийНоменклатуры.ТекущийЭлемент = Элементы.ОписаниеСерийНоменклатурыКодПродукта;

КонецПроцедуры
