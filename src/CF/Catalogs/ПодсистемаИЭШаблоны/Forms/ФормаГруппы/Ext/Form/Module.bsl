﻿// sza140420-2103
// sza131216-0043 :

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)

	Объект.Наименование = Наименование;
	НаименованиеИзменяли = ИСТИНА;
	Если ПереводитьНаименованияАвтоматически Тогда
		ОбщийМодульКлиент.ПеревестиНаименованияАвтоматически(Наименование, НаименованияНаДругихЯзыках);
		БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахНаЯзыкеПриИзменении(Элемент)

	БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;

КонецПроцедуры

&НаКлиенте
Процедура НаименованияНаДругихЯзыкахПриИзменении(Элемент)

	БылиИзмененияЗначенияПолейНаЯзыках = ИСТИНА;

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = ИСТИНА;

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	Если ПоддержкаДругихЯзыков Тогда
		Если НаименованиеИзменяли Тогда
			ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, Наименование);
		КонецЕсли;

		Если БылиИзмененияЗначенияПолейНаЯзыках Тогда
			Для Каждого СтрокаЯзыка Из НаименованияНаДругихЯзыках Цикл
				ОбщийМодульСервер.обновитьЗначениеНаЯзыке(Объект.Ссылка, СтрокаЯзыка.НаЯзыке, "Наименование", СтрокаЯзыка.Язык);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеНаДругихЯзыках(Команда)

	Элементы.НаименованияНаДругихЯзыках.Видимость  = НЕ Элементы.НаименованияНаДругихЯзыках.Видимость;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", ЭтаФорма, Отказ, Объект);

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ПоддержкаДругихЯзыков = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьИныеЯзыкиКромеРусского")
		И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского", ИСТИНА);

		Если ПоддержкаДругихЯзыков
			И ЗначениеЗаполнено(Объект.Ссылка) Тогда

			Наименование = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(Объект.Ссылка);

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
		КонецЕсли;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
