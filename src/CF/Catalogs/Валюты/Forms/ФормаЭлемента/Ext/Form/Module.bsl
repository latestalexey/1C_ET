﻿// sza151014-0347
// sza141215-0051 ПараметрыСуммыПрописью
// sza141111-1337
// sza140428-2156
// sza131007-1623

&НаКлиенте
Процедура ВыбратьВалютуМираОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)

	СтандартнаяОбработка = ЛОЖЬ;
	Объект.Код			 = ВыбранноеЗначение;
	ПараметрыОтбора 	 = Новый Структура("Код", ВыбранноеЗначение);
	Наименование		 = СписокВалют.НайтиСтроки(ПараметрыОтбора)[0].Наименование;
	Объект.Наименование  = Наименование;
	Объект.МеждународныйКод = Наименование;
	НаименованиеИзменяли = ИСТИНА;

	Если ПереводитьНаименованияАвтоматически Тогда
		ОбщийМодульКлиент.ПеревестиНаименованияАвтоматически(Наименование, НаименованияНаДругихЯзыках);
		БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
	КонецЕсли;

	Элементы.Наименование.Видимость = ИСТИНА;
	Элементы.ВыбратьВалютуМира.Видимость = ЛОЖЬ;
	ПараметрыСуммыПрописьюОткрытиеНаСервере();
	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВалютуМираПриИзменении(Элемент)

	Объект.Наименование  = Наименование;
	НаименованиеИзменяли = ИСТИНА;
	Если ПереводитьНаименованияАвтоматически Тогда
		ОбщийМодульКлиент.ПеревестиНаименованияАвтоматически(Наименование, НаименованияНаДругихЯзыках);
		БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
	КонецЕсли;

	ПараметрыСуммыПрописьюОткрытиеНаСервере();
	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаСервере
Функция   ЕстьЗависимыеЦены(Знач Валюта)

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	               |	Цены.Цена
	               |ИЗ РегистрСведений.Цены КАК Цены
	               |ГДЕ Цены.Цена <> 0
	               |	И Цены.ВидЦен.Зависимая = ИСТИНА
	               |	И Цены.ВидЦен.ОсновнойВидЦен.ВалютаЦены = &ВалютаЦены
	               |ОБЪЕДИНИТЬ ВСЕ
	               |ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	               |	Цены.Цена
	               |ИЗ РегистрСведений.Цены КАК Цены
	               |ГДЕ Цены.Цена <> 0
	               |	И Цены.ВидЦен.Зависимая = ИСТИНА
	               |	И Цены.ВидЦен.СпособыФормированияЦеныДляНоменклатурныхГрупп.ОсновнойВидЦен.ВалютаЦены = &ВалютаЦены
	               |ОБЪЕДИНИТЬ ВСЕ
	               |ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1
	               |	Цены.Цена
	               |ИЗ РегистрСведений.Цены КАК Цены
	               |ГДЕ Цены.Цена <> 0
	               |	И Цены.ВидЦен.Зависимая = ИСТИНА
	               |	И Цены.ВидЦен.ТаблицаЗависимости.ОсновнойВидЦен.ВалютаЦены = &ВалютаЦены";
	Запрос.УстановитьПараметр("ВалютаЦены", Валюта);

	РезультатЗапроса = Запрос.Выполнить();

	Возврат НЕ РезультатЗапроса.Пустой();

КонецФункции

&НаКлиенте
Процедура КодПриИзменении(Элемент)

	ПараметрыСуммыПрописьюОткрытиеНаСервере();
	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаКлиенте
Процедура КурсыЭтойВалютыПриИзменении(Элемент)

	ПроверитьЗаписанныйОбъект();
	ПроверитьЗаписанныйОбъектНаКлиенте();

КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)

	Объект.Наименование  = Наименование;
	НаименованиеИзменяли = ИСТИНА;
	Если ПереводитьНаименованияАвтоматически Тогда
		ОбщийМодульКлиент.ПеревестиНаименованияАвтоматически(Наименование, НаименованияНаДругихЯзыках);
		БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
	КонецЕсли;

		ПараметрыСуммыПрописьюОткрытиеНаСервере();
	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахНаЯзыкеПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
КонецПроцедуры

&НаСервереБезКонтекста
Функция   НетКурсов(Ссылка)

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ КурсыВалютСрезПоследних.Курс
	|ИЗ РегистрСведений.КурсыВалют.СрезПоследних(&Дата, Валюта = &Ссылка) КАК КурсыВалютСрезПоследних";

	Запрос.УстановитьПараметр("Дата", ОбщийМодульСервисСервер.ПользователяТекущаяДата());
	Запрос.УстановитьПараметр("Ссылка", Ссылка);

	РезультатЗапроса = Запрос.Выполнить();

	Возврат РезультатЗапроса.Пустой();

КонецФункции

&НаКлиенте
Процедура ПараметрыСуммыПрописиНаДругихЯзыках(Команда)
	Элементы.ПараметрыСуммыПрописиНаДругихЯзыках.Видимость  = НЕ Элементы.ПараметрыСуммыПрописиНаДругихЯзыках.Видимость;
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыСуммыПрописиНаДругихЯзыкахНаЯзыкеПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыСуммыПрописиНаДругихЯзыкахПриИзменении(Элемент)
	БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
КонецПроцедуры

&НаКлиенте
Процедура ПараметрыСуммыПрописьюОткрытие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = ЛОЖЬ;
	ПараметрыСуммыПрописьюОткрытиеНаСервере();
	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаСервере
Процедура ПараметрыСуммыПрописьюОткрытиеНаСервере()

	ПараметрыСуммыПрописью = ОбщийМодульТекстСервер.СформироватьСуммуПрописью(1, Объект.Ссылка, , ИСТИНА, , , Объект.Код);
	Объект.ПараметрыСуммыПрописью = ПараметрыСуммыПрописью;
	НаименованиеИзменяли = ИСТИНА;

КонецПроцедуры

&НаКлиенте
Процедура ПараметрыСуммыПрописьюОчистка(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = ЛОЖЬ;
	ПараметрыСуммыПрописью = "";
	Объект.ПараметрыСуммыПрописью = "";
	НаименованиеИзменяли = ИСТИНА;
	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаКлиенте
Процедура ПараметрыСуммыПрописьюПриИзменении(Элемент)

	Объект.ПараметрыСуммыПрописью = ПараметрыСуммыПрописью;
	НаименованиеИзменяли = ИСТИНА;
	ПересчитатьСуммуПрописью();
	Если ПереводитьНаименованияАвтоматически Тогда
		ОбщийМодульКлиент.ПеревестиНаименованияАвтоматически(ПараметрыСуммыПрописью, ПараметрыСуммыПрописиНаДругихЯзыках);
		БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПересчитатьВсеЗависимыеЦеныНаСервере()
	ОбщийМодульСервер.РассчитатьВсеЗависимыеЦеныПриСменеКурса(Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьСуммуПрописью()
	ТекстСуммыПрописью = ОбщийМодульТекстСервер.СформироватьСуммуПрописью(ПримерСуммыПрописью, Объект.Ссылка, , , ПараметрыСуммыПрописью);
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	ПроверитьЗаписанныйОбъектНаКлиенте();
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = ИСТИНА;

	Если НЕ Объект.Предопределенный
		И НетКурсов(Объект.Ссылка) Тогда

		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Внимание. Не следует использовать данную валюту, пока у нее нет курса!"));
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	ПроверитьЗаписанныйОбъект();

	Если ПоддержкаДругихЯзыков Тогда
		Если НаименованиеИзменяли Тогда
			ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, Наименование);
		КонецЕсли;

		Если БылиИзмененияЗначенияПолейНаЯзыках Тогда
			Для Каждого СтрокаЯзыка Из НаименованияНаДругихЯзыках Цикл
				ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, СтрокаЯзыка.НаЯзыке, "Наименование", СтрокаЯзыка.Язык);
			КонецЦикла;

			Для Каждого СтрокаЯзыка Из ПараметрыСуммыПрописиНаДругихЯзыках Цикл
				ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, СтрокаЯзыка.НаЯзыке, "ПараметрыСуммыПрописью", СтрокаЯзыка.Язык);
			КонецЦикла;

			ОбновитьПовторноИспользуемыеЗначения();
		КонецЕсли;
	КонецЕсли;

	Элементы.ГруппаПримераПрописи.Видимость = ЗначениеЗаполнено(Объект.Ссылка);

КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеНаДругихЯзыках(Команда)
	Элементы.НаименованияНаДругихЯзыках.Видимость = НЕ Элементы.НаименованияНаДругихЯзыках.Видимость;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                              // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура ПримерСуммыПрописьюОчистка(Элемент, СтандартнаяОбработка)
	ПересчитатьСуммуПрописью();
КонецПроцедуры

&НаКлиенте
Процедура ПримерСуммыПрописьюПриИзменении(Элемент)
	ПересчитатьСуммуПрописью();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                         // ПРИ ОТКРЫТИИ

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, ИСТИНА);
	ПроверитьЗаписанныйОбъектНаКлиенте();
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ЭтаФорма.ТекущийЭлемент = Элементы.Наименование;
	КонецЕсли;

	ПересчитатьСуммуПрописью();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000950", ЭтаФорма, Отказ, Объект);

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ЗначениеЗаполненоОбъектСсылка = ЗначениеЗаполнено(Объект.Ссылка);
		Элементы.КурсыЭтойВалюты.Видимость = НЕ Объект.Предопределенный ;
		Элементы.ТекущийКурс.Видимость = НЕ Объект.Предопределенный ;
		ПроверитьЗаписанныйОбъект();

		Если НЕ ЗначениеЗаполненоОбъектСсылка Тогда
			Элементы.Наименование.Видимость = ЛОЖЬ;
			Элементы.ВыбратьВалютуМира.Видимость = ИСТИНА;
			ОбщийМодульСервер.ПолучитьСписокВалют(СписокВалют);

			Для Каждого ЭлементВалюта Из СписокВалют Цикл
				Элементы.ВыбратьВалютуМира.СписокВыбора.Добавить(ЭлементВалюта.Код, ЭлементВалюта.Наименование);
			КонецЦикла;
		Иначе
			Элементы.ВыбратьВалютуМира.Видимость = ЛОЖЬ;
		КонецЕсли;

		ПоддержкаДругихЯзыков = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьИныеЯзыкиКромеРусского") И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского", ИСТИНА);

		Если ПоддержкаДругихЯзыков
			И ЗначениеЗаполненоОбъектСсылка Тогда

			Наименование = ОбщийМодульПовтор.ПолучитьПредставлениеНаЯзыке(Объект.Ссылка);
			ПараметрыСуммыПрописью = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(Объект.Ссылка, "ПараметрыСуммыПрописью");

			Запрос = Новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ ЗначенияНаДругихЯзыках.Язык,
			|	ЗначенияНаДругихЯзыках.НаЯзыке,
			|	ЗначенияНаДругихЯзыках.Поле
			|ИЗ РегистрСведений.ЗначенияНаДругихЯзыках КАК ЗначенияНаДругихЯзыках
			|ГДЕ ЗначенияНаДругихЯзыках.ОбъектБазыДанных = &ОбъектБазыДанных";
			Запрос.УстановитьПараметр("ОбъектБазыДанных", Объект.Ссылка);

			РезультатЗапроса = Запрос.Выполнить();

			Если НЕ РезультатЗапроса.Пустой() Тогда
				ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
				Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
					Если ВыборкаДетальныеЗаписи.Поле = "Наименование" Тогда
						СтрокаЯзыка = НаименованияНаДругихЯзыках.Добавить();
						СтрокаЯзыка.Язык 	= ВыборкаДетальныеЗаписи.Язык;
						СтрокаЯзыка.НаЯзыке = ВыборкаДетальныеЗаписи.НаЯзыке;
					ИначеЕсли ВыборкаДетальныеЗаписи.Поле = "ПараметрыСуммыПрописью" Тогда
						СтрокаЯзыка = ПараметрыСуммыПрописиНаДругихЯзыках.Добавить();
						СтрокаЯзыка.Язык 	= ВыборкаДетальныеЗаписи.Язык;
						СтрокаЯзыка.НаЯзыке = ВыборкаДетальныеЗаписи.НаЯзыке;
					КонецЕсли;

				КонецЦикла;
			КонецЕсли;
		Иначе
			Наименование = Объект.Наименование;
		КонецЕсли;

		Если ПоддержкаДругихЯзыков Тогда
			ПереводитьНаименованияАвтоматически = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьРегистрТекстовНаДругихЯзыкахДляАвтоматическогоПереводаНаименований");
			Элементы.НаименованияНаДругихЯзыкахЯзык.РежимВыбораИзСписка = ИСТИНА;
			ОбщийМодульПовтор.УстановитьСписокДоступныхЯзыков(Элементы.НаименованияНаДругихЯзыкахЯзык.СписокВыбора, ИСТИНА);
			Элементы.ПараметрыСуммыПрописиНаДругихЯзыкахЯзык.РежимВыбораИзСписка = ИСТИНА;
			ОбщийМодульПовтор.УстановитьСписокДоступныхЯзыков(Элементы.ПараметрыСуммыПрописиНаДругихЯзыкахЯзык.СписокВыбора, ИСТИНА);
		КонецЕсли;

		Элементы.ГруппаПримераПрописи.Видимость = ЗначениеЗаполнено(Объект.Ссылка);
		Элементы.ПриРасчетахНаличнымиИспользуютсяМонеты.Видимость = НЕ Объект.ТолькоДляБезналичныхРасчетов;
		МеждународныйКодОсновнойВалюты = ПредопределенноеЗначение("Справочник.Валюты.ОсновнаяВалюта").МеждународныйКод;
		Элементы.КурсВИнтернет.Видимость = НЕ Объект.Предопределенный;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаСервере
Процедура ПроверитьЗаписанныйОбъект()

	ЗначениеЗаполненоОбъектСсылка 		= НЕ Объект.Предопределенный И ЗначениеЗаполнено(Объект.Ссылка);
	Элементы.КурсыЭтойВалюты.Видимость 	= ЗначениеЗаполненоОбъектСсылка;
	Элементы.ТекущийКурс.Видимость 		= ЗначениеЗаполненоОбъектСсылка;
	ТекущийКурс = ОбщийМодульПовтор.ПолучитьТекущийКурс(Объект.Ссылка);

КонецПроцедуры // ПроверитьЗаписанныйОбъект

&НаКлиенте
Процедура ПроверитьЗаписанныйОбъектНаКлиенте()

	ЗначениеОтбора = ?(ЗначениеЗаполнено(Объект.Ссылка), Объект.Ссылка, ПредопределенноеЗначение("Справочник.Валюты.ПустаяСсылка"));
	ОбщийМодульКлиент.УстановитьЭлементОтбора(
	КурсыЭтойВалюты.Отбор,
	"Валюта",
	ЗначениеОтбора,
	ВидСравненияКомпоновкиДанных.Равно,
	,
	ИСТИНА
	);
	Элементы.КурсыЭтойВалюты.Обновить();

КонецПроцедуры

&НаКлиенте
Процедура РассчитатьВсеЗависимыеЦены(Команда)

	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002350");
		глПроверятьСообщения = ИСТИНА;

		Если НЕ ОТказ
			И ЕстьЗависимыеЦены(Объект.Ссылка) Тогда

			ПоказатьВопрос(Новый ОписаниеОповещения("РассчитатьВсеЗависимыеЦеныЗавершение", ЭтаФорма), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Есть Зависимые цены по этой валюте.") + символы.пс + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Рассчитать все зависимые цены по этой валюте?"), РежимДиалогаВопрос.ДаНет);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура РассчитатьВсеЗависимыеЦеныЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Расчет всех зависимых цен.."));
		ПересчитатьВсеЗависимыеЦеныНаСервере();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ТолькоДляБезналичныхРасчетовПриИзменении(Элемент)

	Элементы.ПриРасчетахНаличнымиИспользуютсяМонеты.Видимость = НЕ Объект.ТолькоДляБезналичныхРасчетов;

	Если Объект.ТолькоДляБезналичныхРасчетов Тогда
		Объект.ПриРасчетахНаличнымиИспользуютсяМонеты = ЛОЖЬ;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьНовыйКурсНаДату(Команда)

	ПараметрыФормы = Новый Структура("Валюта", Объект.Ссылка);
	ОткрытьФорму("РегистрСведений.КурсыВалют.ФормаЗаписи", ПараметрыФормы);

КонецПроцедуры

&НаКлиенте
Процедура КурсВИнтернет(Команда)

	АдресВИнтернете = """https://www.google.com.ua/search?q=" + Объект.МеждународныйКод + "+" + МеждународныйКодОсновнойВалюты + """";

	Если глВерсияПлатформы < 806010000 Тогда
		Выполнить(" ЗапуститьПриложение(" + АдресВИнтернете + "); ");
	Иначе
		Выполнить(" НачатьЗапускПриложения(Неопределено, " + АдресВИнтернете + "); ");
	КонецЕсли;

КонецПроцедуры
