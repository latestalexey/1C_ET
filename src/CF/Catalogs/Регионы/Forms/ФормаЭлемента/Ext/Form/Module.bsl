﻿// sza140710-1204  локац
// sza140523-0203
// sza131005-0202 :

&НаКлиенте
Процедура ДобавитьГруппуЛокаций(Команда)

	ПараметрыФормы = Новый Структура("Регион", Объект.Ссылка);
	ОткрытьФорму("Справочник.Локации.ФормаГруппы", ПараметрыФормы);

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображение(Команда)

	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ДобавитьИзображениеЗавершение", ЭтаФорма), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Сначала следует записать этот элемент. Записать?"), РежимДиалогаВопрос.ДаНет);

        Возврат;
	КонецЕсли;

	ДобавитьИзображениеФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображениеЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт

	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		Записать();
	КонецЕсли;

	ДобавитьИзображениеФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображениеФрагмент()

	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПараметрыФормы = Новый Структура("СвязанныйОбъект", Объект.Ссылка);
		ОткрытьФорму("Справочник.Изображения.ФормаОбъекта", ПараметрыФормы);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьЛокацию(Команда)

	ПараметрыФормы = Новый Структура("Регион", Объект.Ссылка);
	ОткрытьФорму("Справочник.Локации.ФормаОбъекта", ПараметрыФормы);

КонецПроцедуры

&НаКлиенте
Процедура ДополнительнаяИнформацияВидИнформацииНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	ПараметрыФормы = Новый Структура("ТипВладельца", ДопИнфоТипВладельца);
	ФормаВыбораВидаИнформации = ПолучитьФорму("Справочник.ДополнительныеРеквизиты.ФормаВыбора", ПараметрыФормы, ЭтаФорма);
	ВидИнформации = ФормаВыбораВидаИнформации.ОткрытьМодально();
	Если ЗначениеЗаполнено(ВидИнформации) Тогда
		Элементы.ДополнительнаяИнформация.ТекущиеДанные.ВидИнформации = ВидИнформации;
		Элементы.ДополнительнаяИнформация.ТекущиеДанные.Информация = ОбщийМодульКлиент.ПолучитьЗначениеПоУмолчаниюПоляДополнительнойИнформации(ВидИнформации);
		СтандартнаяОбработка = ЛОЖЬ;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДополнительнаяИнформацияПриИзменении(Элемент)

	ДопИнформацияИзменена = ИСТИНА;

КонецПроцедуры

&НаКлиенте
Процедура ИзображенияПриАктивизацииСтроки(Элемент)

	ПодключитьОбработчикОжидания("СписокПриАктивизацииСтрокиОповещение", 0.2, ИСТИНА);

КонецПроцедуры

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

&НаСервере
Процедура ОбновитьЛокации()

	МогутБытьЛокации = ЗначениеЗаполнено(Объект.Ссылка) И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетЛокацииКонтрагентов");
	Элементы.Локации.Видимость = МогутБытьЛокации;
	Если МогутБытьЛокации Тогда
		локации.Параметры.УстановитьЗначениеПараметра("Владелец", Объект.Ссылка);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Плюс2(Команда)

	Объект.ЧасовойПоясОтГринвича = 2;

КонецПроцедуры

&НаКлиенте
Процедура Плюс3(Команда)

	Объект.ЧасовойПоясОтГринвича = 3;

КонецПроцедуры

&НаКлиенте
Процедура Плюс4(Команда)

	Объект.ЧасовойПоясОтГринвича = 4;

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

			ОбновитьПовторноИспользуемыеЗначения();
		КонецЕсли;
	КонецЕсли;

	Если ДопИнформацияИзменена Тогда
		ОбщийМодульСервисСервер.ЗаписатьДополнительнуюИнформацию(Объект.Ссылка, ДополнительнаяИнформация);
	КонецЕсли;

	ОбновитьЛокации();

КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеНаДругихЯзыках(Команда)
	Элементы.НаименованияНаДругихЯзыках.Видимость  = НЕ Элементы.НаименованияНаДругихЯзыках.Видимость;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                     // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, ИСТИНА);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		ОбъектСсылка = Объект.Ссылка;
		ДопИнфоТипВладельца = ОбщийМодульПовтор.ПолучитьТипВладельца(ОбъектСсылка);
		ОбщийМодульСервисСервер.ЗаполнитьДополнительнуюИнформацию(ОбъектСсылка, ДополнительнаяИнформация, ДопИнфоТипВладельца);
		ПоддержкаДругихЯзыков = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьИныеЯзыкиКромеРусского")
		И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского", ИСТИНА);
		Элементы.Изображения.Видимость = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("СопровождатьПроизводителейИзображениями");

		Если ПоддержкаДругихЯзыков
			И ЗначениеЗаполнено(ОбъектСсылка) Тогда

			Наименование = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(ОбъектСсылка);

			Запрос = Новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ
			|	ЗначенияНаДругихЯзыках.Язык,
			|	ЗначенияНаДругихЯзыках.НаЯзыке,
			|	ЗначенияНаДругихЯзыках.Поле
			|ИЗ РегистрСведений.ЗначенияНаДругихЯзыках КАК ЗначенияНаДругихЯзыках
			|ГДЕ ЗначенияНаДругихЯзыках.ОбъектБазыДанных = &ОбъектБазыДанных";
			Запрос.УстановитьПараметр("ОбъектБазыДанных", ОбъектСсылка);

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
			Элементы.ЯзыкОбщения.РежимВыбораИзСписка = ИСТИНА;
			ОбщийМодульПовтор.УстановитьСписокДоступныхЯзыков(Элементы.ЯзыкОбщения.СписокВыбора, , , ИСТИНА);
			Элементы.ЯзыкДокументов.РежимВыбораИзСписка = ИСТИНА;
			ОбщийМодульПовтор.УстановитьСписокДоступныхЯзыков(Элементы.ЯзыкДокументов.СписокВыбора, , ИСТИНА);
		КонецЕсли;

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьРегионыДляУчетаСтранАЛокацииГородов") Тогда
			Элементы.ФормаЗаписатьИЗакрыть.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Записать и закрыть");
			Элементы.Родитель.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Группа Стран");
			Элементы.Наименование.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Наименование Страны");
			Элементы.СтраницаЛокации.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Города");
			Элементы.ЛокацииСоздать.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Добавить Город");
			Элементы.ЛокацииНаименование.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Наименования Городов");
			Элементы.ЧасовойПоясОтГринвича.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Общий часовой пояс Страны");
		КонецЕсли;

		ОбновитьЛокации();
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтрокиОповещение()

	ТекущийЭлементСписка = Элементы.Изображения.ТекущаяСтрока;

	Если ЗначениеЗаполнено(ТекущийЭлементСписка) Тогда
		СтруктураИзображения = ОбщийМодульСервер.ПолучитьСтруктуруИзображения(ТекущийЭлементСписка);
		ПодСсылку = СтруктураИзображения.ПодСсылку;
		Элементы.СсылкаНаИзображение.Видимость    = не СтруктураИзображения.ИзображениеВБазеДанных;
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

КонецПроцедуры

&НаКлиенте
Процедура ЯзыкДокументовПриИзменении(Элемент)
	ЯзыкДокументовПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЯзыкДокументовПриИзмененииНаСервере()
	ОбщийМодульТекстСервер.ЗагрузитьТекстыОпределенногоЯзыкаИзМакета(Объект.ЯзыкДокументов, ИСТИНА);
КонецПроцедуры
