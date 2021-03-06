﻿// sza151118-0143 ФТ
// sza140619-1652
// sza140406-0147

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

&НаСервере
Процедура ОбновитьВидТаблицыСДанными(Знач НеОбновлять = ЛОЖЬ)

	Счетчик = 1;

	Для Каждого СтрокаОписания Из Объект.ОписаниеКолонок Цикл
		Если счетчик <= 20 Тогда
			Выполнить(" Элементы.ТаблицаСДаннымиЗначениеПоляТаблицы" + СокрЛП(Счетчик) + ".Видимость = ИСТИНА;");
			Выполнить(" Элементы.ТаблицаСДаннымиЗначениеПоляТаблицы" + СокрЛП(Счетчик) + ".Заголовок = СтрокаОписания.ОписаниеПоляКолонки;");
			Выполнить(" Элементы.ТаблицаСДаннымиЗначениеПоляТаблицы" + СокрЛП(Счетчик) + ".Подсказка = СтрокаОписания.ОписаниеПоляКолонки;");

			Если НЕ НеОбновлять Тогда
				ТипЗначенияРеквизитНоменклатурнойГруппы = Неопределено;
				ЗначениеПоУмолчанию = ОбщийМодульПовтор.ПолучитьПустоеЗначениеДополнительногоРеквизита(СтрокаОписания.ТипПоля);
				Для Каждого СтрокаТаблицы Из Объект.ТаблицаСДанными Цикл
					Выполнить(" ТипЗначенияРеквизитНоменклатурнойГруппы = ТипЗнч(СтрокаТаблицы.ЗначениеПоляТаблицы" + СокрЛП(Счетчик) + ");");

					Если НЕ ТипЗначенияРеквизитНоменклатурнойГруппы = ТипЗнч(ЗначениеПоУмолчанию)  Тогда
						Выполнить(" СтрокаТаблицы[""ЗначениеПоляТаблицы"" + СокрЛП(Счетчик)] = ЗначениеПоУмолчанию;");
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;

		Счетчик = Счетчик + 1;

	КонецЦикла;

	Пока счетчик <= 20 Цикл
		Выполнить(" Элементы.ТаблицаСДаннымиЗначениеПоляТаблицы" + СокрЛП(Счетчик) + ".Видимость = ЛОЖЬ;");

		Для Каждого СтрокаТаблицы Из Объект.ТаблицаСДанными Цикл
			СтрокаТаблицы["ЗначениеПоляТаблицы" + СокрЛП(Счетчик)] = Неопределено;
		КонецЦикла;

		Счетчик = Счетчик + 1;

	КонецЦикла;

КонецПроцедуры

&НаКлиенте
Процедура ОбработатьПолученныйШтрихкодНаКлиенте(ТекКод)

	Если НЕ ОбработатьПолученныйШтрихкодНаСервере(ТекКод) Тогда
		СканерЗаблокирован = ОбщийМодульКлиент.ВыдатьСигнал(ТекКод);
		Элементы.РазблокироватьСканер.видимость 	= СканерЗаблокирован;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция   ОбработатьПолученныйШтрихкодНаСервере(Знач ТекКод, Знач Количество = 1)

	Результат = ИСТИНА;
	СтрокаТаблицы = Неопределено;
	РезультатОбработки = ОбщийМодульТоварСервер.НайтиНоменклатуруПоШтрихКоду(ТекКод, ИСТИНА, , Объект.Дата);
	ОстановитьПоиск = ЛОЖЬ;

	Если Объект.ОписаниеКолонок.Количество() <> 0 Тогда
		ТипПервойКолонки = Объект.ОписаниеКолонок[0].ТипПоля;

		Если ТипПервойКолонки = Перечисления.ТипыДополнительныхРеквизитов.Строка Тогда
			СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
			СтрокаТаблицы.ЗначениеПоляТаблицы1 = ТекКод;
			ОстановитьПоиск = ИСТИНА;
		КонецЕсли;
	КонецЕсли;

	Если НЕ ОстановитьПоиск Тогда
		Если ЗначениеЗаполнено(РезультатОбработки) Тогда
			СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
			СтрокаТаблицы.ЗначениеПоляТаблицы1 = РезультатОбработки.Номенклатура;

			Если ЗначениеЗаполнено(РезультатОбработки.СерияНоменклатуры) Тогда
				СтрокаТаблицы.ЗначениеПоляТаблицы2 = РезультатОбработки.СерияНоменклатуры;
			КонецЕсли;

			СтрокаДисплеяПокупателя = СокрЛП(РезультатОбработки.Номенклатура);
		Иначе
			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПродажПоСотрудникам") Тогда

				РезультатОбработки = ОбщийМодульСервер.НайтиСотрудникаПоШтрихКоду(ТекКод);

				Если ЗначениеЗаполнено(РезультатОбработки) Тогда
					СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
					СтрокаТаблицы.ЗначениеПоляТаблицы1 = РезультатОбработки;
					ОстановитьПоиск = ИСТИНА;
				КонецЕсли;
			КонецЕсли;

			Если НЕ ОстановитьПоиск
				И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьШтрихКодыДляИдентификацииКонтрагентов") Тогда

				РезультатОбработки = ОбщийМодульСервер.НайтиКонтрагентаПоШтрихКоду(ТекКод);

				Если ЗначениеЗаполнено(РезультатОбработки) Тогда
					СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
					СтрокаТаблицы.ЗначениеПоляТаблицы1 = РезультатОбработки;
					ОстановитьПоиск = ИСТИНА;
				КонецЕсли;
			КонецЕсли;

			Если НЕ ОстановитьПоиск
				И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетСобственныхЮридическихЛиц") Тогда

				РезультатОбработки = ОбщийМодульСервер.НайтиКонтрагентаПоШтрихКоду(ТекКод, , , ИСТИНА);

				Если ЗначениеЗаполнено(РезультатОбработки) Тогда
					СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
					СтрокаТаблицы.ЗначениеПоляТаблицы1 = РезультатОбработки;
					ОстановитьПоиск = ИСТИНА;
				КонецЕсли;
			КонецЕсли;

			Если НЕ ОстановитьПоиск Тогда
				СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
				СтрокаТаблицы.ЗначениеПоляТаблицы1 = ТекКод;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

	Если НЕ СтрокаТаблицы = Неопределено Тогда
		Для Каждого ПолеТаблицы Из Объект.ОписаниеКолонок Цикл
			Если НЕ ПолеТаблицы.НомерСтроки = 1 Тогда
				ЗначениеПоУмолчанию = ОбщийМодульПовтор.ПолучитьПустоеЗначениеДополнительногоРеквизита(ПолеТаблицы.ТипПоля);
				Выполнить(" СтрокаТаблицы[""ЗначениеПоляТаблицы"" + СокрЛП(ПолеТаблицы.НомерСтроки)] = ЗначениеПоУмолчанию;");
			КонецЕсли;

		КонецЦикла;
	КонецЕсли;

	Возврат Результат;

КонецФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если Источник = "ПодключаемоеОборудование"
		И ВводДоступен() Тогда

		Если НЕ СканерЗаблокирован
			И ИмяСобытия = "ScanData" Тогда

			Если Параметр[1] = Неопределено Тогда
				ТекКод = Параметр[0];
			Иначе
				ТекКод = Параметр[1][1];
			КонецЕсли;

			ОбработатьПолученныйШтрихкодНаКлиенте(ТекКод);
		ИначеЕсли ИмяСобытия = "TracksData" Тогда
			ПолученКодИзСМК(Параметр);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОписаниеКолонокПриИзменении(Элемент)
	
	ОбновитьВидТаблицыСДанными();
	глВремяПоследнегоСобытия = ТекущаяДата();
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТаблицу(Команда)
	ОчиститьТаблицуНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОчиститьТаблицуНаСервере()
	Объект.ТаблицаСДанными.Очистить();
КонецПроцедуры

&НаКлиенте
Процедура ПолученКодИзСМК(Параметр)

	Если Параметр[1][3] <> Неопределено Тогда
		МКод = Параметр[1][3][0].ДанныеДорожек[0].ЗначениеПоля;
	Иначе
		МКод = Параметр[0];
	КонецЕсли;

	ПолучитьКлиентаНаСервере(МКод);

КонецПроцедуры

&НаСервере
Процедура ПолучитьКлиентаНаСервере(Знач МКод)

	Клиент = ПодключаемоеОборудованиеДСервер.НайтиКлиентаПоМК(МКод);

	Если Клиент <> Неопределено Тогда
		СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
		СтрокаТаблицы.ЗначениеПоляТаблицы1 = Клиент;
	Иначе
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Клиент не найден."));
	КонецЕсли;

КонецПроцедуры

&НаСервере
функция   ПолучитьОтносительныйАдресНаСервере();

	Возврат ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПодсистемаИЭИмпортЭкспортОтносительныйАдресФайлов");

КонецФункции

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = ИСТИНА;
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	Если ДопИнформацияИзменена Тогда
		ОбщийМодульСервисСервер.ЗаписатьДополнительнуюИнформацию(Объект.Ссылка, ДополнительнаяИнформация);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, ИСТИНА);

	Если ИспользоватьПодключаемоеОборудование Тогда
		ПоддерживаемыеТипыВО = Новый Массив ();
		ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		ПоддерживаемыеТипыВО.Добавить("ДисплейПокупателя");
		МенеджерОборудованияКлиент.ОтключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, ИСТИНА);

	Если ИспользоватьПодключаемоеОборудование
		И МенеджерОборудованияКлиент.ОбновитьРабочееМестоКлиента() Тогда

		ОписаниеОшибки = "" ;
		ПоддерживаемыеТипыВО = Новый Массив();
		ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
		ПоддерживаемыеТипыВО.Добавить("СканерШтрихКода");
		ПоддерживаемыеТипыВО.Добавить("ДисплейПокупателя");

		Если НЕ МенеджерОборудованияКлиент.ПодключитьОборудованиеПоТипу(УникальныйИдентификатор, ПоддерживаемыеТипыВО, ОписаниеОшибки) Тогда
			ТекстСообщения = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке( "При подключении оборудования произошла ошибка") + ": " + ОписаниеОшибки + ".";
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;

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
		ИспользоватьПодключаемоеОборудование = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьПодключаемоеОборудование");
		Элементы.Страницы.ТекущаяСтраница = Элементы.ГруппаТаблицаСДанными;
		ОбновитьВидТаблицыСДанными(ИСТИНА);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ПрочитатьLOG(Команда)

	АдресФайла = ПолучитьОтносительныйАдресНаСервере();
	ДиалогФильтр	 = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Файл") + " (*.*)|*.*";
	ДиалогРасширение = "*";
	ДиалогДляВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогДляВыбораФайла.Заголовок				= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выберите файл для загрузки") + ":";
	ДиалогДляВыбораФайла.ПолноеИмяФайла			= АдресФайла; // АДРЕС
	ДиалогДляВыбораФайла.Фильтр					= ДиалогФильтр;
	ДиалогДляВыбораФайла.Расширение				= ДиалогРасширение;
	ДиалогДляВыбораФайла.МножественныйВыбор		= ЛОЖЬ;
	ДиалогДляВыбораФайла.ПредварительныйПросмотр= ИСТИНА;
	ДиалогДляВыбораФайла.ИндексФильтра			= 0;
	ДиалогДляВыбораФайла.ПроверятьСуществованиеФайла = ИСТИНА;

	Если ДиалогДляВыбораФайла.Выбрать() Тогда
		АдресФайла = ДиалогДляВыбораФайла.ПолноеИмяФайла;
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Идет Загрузка данных.."), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ждите.."));
		ПрочитатьLOGНаСервере(АдресФайла);
		ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Загрузил данные Из файла") + ": " + АдресФайла, 2);

		Если НЕ ЗначениеЗаполнено(Объект.Комментарий) Тогда
			Объект.Комментарий = АдресФайла;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПрочитатьLOGНаСервере(Знач АдресФайла)

	Разделитель = ?(ЗначениеЗаполнено(Объект.РазделительВТекстовомФайле), Объект.РазделительВТекстовомФайле, " ");
	ЧтениеЛога = Новый ЧтениеТекста(АдресФайла);
	ПрочитаннаяСтрока = ЧтениеЛога.ПрочитатьСтроку();
	СчСтрок = 1;

	Пока не ПрочитаннаяСтрока = Неопределено Цикл
		МассивЭлементовСтроки = РазложитьСтрокуВМассив(ПрочитаннаяСтрока, Разделитель);
		Если МассивЭлементовСтроки.Количество() > 0 Тогда
			СтрокаТаблицы = Объект.ТаблицаСДанными.Добавить();
			СтрокаТаблицы.ЗначениеПоляТаблицы1 = МассивЭлементовСтроки[0];

			Если Объект.ОписаниеКолонок.Количество() = 0 Тогда
				НовоеОписание = Объект.ОписаниеКолонок.Добавить();
				НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[0];
			КонецЕсли;

			Если МассивЭлементовСтроки.Количество() > 1 Тогда
				СтрокаТаблицы.ЗначениеПоляТаблицы2 = МассивЭлементовСтроки[1];
				Если Объект.ОписаниеКолонок.Количество() = 1 Тогда
					НовоеОписание = Объект.ОписаниеКолонок.Добавить();
					НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[1];
				КонецЕсли;

				Если МассивЭлементовСтроки.Количество() > 2 Тогда
					СтрокаТаблицы.ЗначениеПоляТаблицы3 = МассивЭлементовСтроки[2];
					Если Объект.ОписаниеКолонок.Количество() = 2 Тогда
						НовоеОписание = Объект.ОписаниеКолонок.Добавить();
						НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[2];
					КонецЕсли;

					Если МассивЭлементовСтроки.Количество() > 3 Тогда
						СтрокаТаблицы.ЗначениеПоляТаблицы4 = МассивЭлементовСтроки[3];
						Если Объект.ОписаниеКолонок.Количество() = 3 Тогда
							НовоеОписание = Объект.ОписаниеКолонок.Добавить();
							НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[3];
						КонецЕсли;

						Если МассивЭлементовСтроки.Количество() > 4 Тогда
							СтрокаТаблицы.ЗначениеПоляТаблицы5 = МассивЭлементовСтроки[4];
							Если Объект.ОписаниеКолонок.Количество() = 4 Тогда
								НовоеОписание = Объект.ОписаниеКолонок.Добавить();
								НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[4];
							КонецЕсли;

							Если МассивЭлементовСтроки.Количество() > 5 Тогда
								СтрокаТаблицы.ЗначениеПоляТаблицы6 = МассивЭлементовСтроки[5];
								Если Объект.ОписаниеКолонок.Количество() = 5 Тогда
									НовоеОписание = Объект.ОписаниеКолонок.Добавить();
									НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[5];
								КонецЕсли;

								Если МассивЭлементовСтроки.Количество() > 6 Тогда
									СтрокаТаблицы.ЗначениеПоляТаблицы7 = МассивЭлементовСтроки[6];
									Если Объект.ОписаниеКолонок.Количество() = 6 Тогда
										НовоеОписание = Объект.ОписаниеКолонок.Добавить();
										НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[6];
									КонецЕсли;

									Если МассивЭлементовСтроки.Количество() > 7 Тогда
										СтрокаТаблицы.ЗначениеПоляТаблицы8 = МассивЭлементовСтроки[7];
										Если Объект.ОписаниеКолонок.Количество() = 7 Тогда
											НовоеОписание = Объект.ОписаниеКолонок.Добавить();
											НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[7];
										КонецЕсли;

										Если МассивЭлементовСтроки.Количество() > 8 Тогда
											СтрокаТаблицы.ЗначениеПоляТаблицы9 = МассивЭлементовСтроки[8];
											Если Объект.ОписаниеКолонок.Количество() = 8 Тогда
												НовоеОписание = Объект.ОписаниеКолонок.Добавить();
												НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[8];
											КонецЕсли;

											Если МассивЭлементовСтроки.Количество() > 9 Тогда
												СтрокаТаблицы.ЗначениеПоляТаблицы10 = МассивЭлементовСтроки[9];
												Если Объект.ОписаниеКолонок.Количество() = 9 Тогда
													НовоеОписание = Объект.ОписаниеКолонок.Добавить();
													НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[9];
												КонецЕсли;

												Если МассивЭлементовСтроки.Количество() > 10 Тогда
													СтрокаТаблицы.ЗначениеПоляТаблицы11 = МассивЭлементовСтроки[10];
													Если Объект.ОписаниеКолонок.Количество() = 10 Тогда
														НовоеОписание = Объект.ОписаниеКолонок.Добавить();
														НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[10];
													КонецЕсли;

													Если МассивЭлементовСтроки.Количество() > 11 Тогда
														СтрокаТаблицы.ЗначениеПоляТаблицы12 = МассивЭлементовСтроки[11];
														Если Объект.ОписаниеКолонок.Количество() = 11 Тогда
															НовоеОписание = Объект.ОписаниеКолонок.Добавить();
															НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[11];
														КонецЕсли;

														Если МассивЭлементовСтроки.Количество() > 12 Тогда
															СтрокаТаблицы.ЗначениеПоляТаблицы13 = МассивЭлементовСтроки[12];
															Если Объект.ОписаниеКолонок.Количество() = 12 Тогда
																НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[12];
															КонецЕсли;

															Если МассивЭлементовСтроки.Количество() > 13 Тогда
																СтрокаТаблицы.ЗначениеПоляТаблицы14 = МассивЭлементовСтроки[13];
																Если Объект.ОписаниеКолонок.Количество() = 13 Тогда
																	НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																	НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[13];
																КонецЕсли;

																Если МассивЭлементовСтроки.Количество() > 14 Тогда
																	СтрокаТаблицы.ЗначениеПоляТаблицы15 = МассивЭлементовСтроки[14];
																	Если Объект.ОписаниеКолонок.Количество() = 14 Тогда
																		НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																		НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[14];
																	КонецЕсли;

																	Если МассивЭлементовСтроки.Количество() > 15 Тогда
																		СтрокаТаблицы.ЗначениеПоляТаблицы16 = МассивЭлементовСтроки[15];
																		Если Объект.ОписаниеКолонок.Количество() = 15 Тогда
																			НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																			НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[15];
																		КонецЕсли;

																		Если МассивЭлементовСтроки.Количество() > 16 Тогда
																			СтрокаТаблицы.ЗначениеПоляТаблицы17 = МассивЭлементовСтроки[16];
																			Если Объект.ОписаниеКолонок.Количество() = 16 Тогда
																				НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																				НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[16];
																			КонецЕсли;

																			Если МассивЭлементовСтроки.Количество() > 17 Тогда
																				СтрокаТаблицы.ЗначениеПоляТаблицы18 = МассивЭлементовСтроки[17];
																				Если Объект.ОписаниеКолонок.Количество() = 17 Тогда
																					НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																					НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[17];
																				КонецЕсли;

																				Если МассивЭлементовСтроки.Количество() > 18 Тогда
																					СтрокаТаблицы.ЗначениеПоляТаблицы19 = МассивЭлементовСтроки[18];
																					Если Объект.ОписаниеКолонок.Количество() = 18 Тогда
																						НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																						НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[18];
																					КонецЕсли;

																					Если МассивЭлементовСтроки.Количество() > 19 Тогда
																						СтрокаТаблицы.ЗначениеПоляТаблицы20 = МассивЭлементовСтроки[19];
																						Если Объект.ОписаниеКолонок.Количество() = 19 Тогда
																							НовоеОписание = Объект.ОписаниеКолонок.Добавить();
																							НовоеОписание.ОписаниеПоляКолонки = МассивЭлементовСтроки[19];
																						КонецЕсли;
																					КонецЕсли;
																				КонецЕсли;
																			КонецЕсли;
																		КонецЕсли;
																	КонецЕсли;
																КонецЕсли;
															КонецЕсли;
														КонецЕсли;
													КонецЕсли;
												КонецЕсли;
											КонецЕсли;
										КонецЕсли;
									КонецЕсли;
								КонецЕсли;
							КонецЕсли;
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		ПрочитаннаяСтрока = ЧтениеЛога.ПрочитатьСтроку();
		СчСтрок = СчСтрок + 1;
	КонецЦикла;

	ЧтениеЛога.Закрыть();
	ОбновитьВидТаблицыСДанными(ИСТИНА);

КонецПроцедуры

&НаКлиенте
Процедура РазблокироватьСканер(Команда)

	СканерЗаблокирован = ЛОЖЬ;
	Элементы.РазблокироватьСканер.видимость = СканерЗаблокирован;

КонецПроцедуры

Функция   РазложитьСтрокуВМассив(Знач Стр, Знач Разделитель = ",") Экспорт

	МассивСтрок = Новый Массив;
	Если Разделитель = " " Тогда
		Стр = СокрЛП(Стр);
		Пока 1=1 Цикл
			Поз = Найти(Стр, Разделитель);

			Если Поз=0 Тогда
				СтрокаЭлемента = Справочники.ЗначенияЯчеекТаблицДанных.НайтиПоНаименованию(стр);
				Если НЕ ЗначениеЗаполнено(СтрокаЭлемента) Тогда
					СтрокаЭлементаО = Справочники.ЗначенияЯчеекТаблицДанных.СоздатьЭлемент();
					СтрокаЭлементаО.Наименование = Стр;
					СтрокаЭлементаО.Записать();
					СтрокаЭлемента = СтрокаЭлементаО.ссылка;
				КонецЕсли;

				МассивСтрок.Добавить(СтрокаЭлемента);

				Возврат МассивСтрок;
			КонецЕсли;

			СтрокаТекста = Лев(Стр, Поз - 1);
			СтрокаЭлемента = Справочники.ЗначенияЯчеекТаблицДанных.НайтиПоНаименованию(СтрокаТекста);
			Если НЕ ЗначениеЗаполнено(СтрокаЭлемента) Тогда
				СтрокаЭлементаО = Справочники.ЗначенияЯчеекТаблицДанных.СоздатьЭлемент();
				СтрокаЭлементаО.Наименование = СтрокаТекста;
				СтрокаЭлементаО.Записать();
				СтрокаЭлемента = СтрокаЭлементаО.ссылка;
			КонецЕсли;

			МассивСтрок.Добавить(СтрокаЭлемента);
			Стр = СокрЛ(Сред(Стр, Поз));
		КонецЦикла;
	Иначе
		ДлинаРазделителя = СтрДлина(Разделитель);

		Пока 1=1 Цикл
			Поз = Найти(Стр, Разделитель);

			Если Поз = 0 Тогда
				СтрокаЭлемента = Справочники.ЗначенияЯчеекТаблицДанных.НайтиПоНаименованию(стр);
				Если НЕ ЗначениеЗаполнено(СтрокаЭлемента) Тогда
					СтрокаЭлементаО = Справочники.ЗначенияЯчеекТаблицДанных.СоздатьЭлемент();
					СтрокаЭлементаО.Наименование = Стр;
					СтрокаЭлементаО.Записать();
					СтрокаЭлемента = СтрокаЭлементаО.ссылка;
				КонецЕсли;

				МассивСтрок.Добавить(СтрокаЭлемента);

				Возврат МассивСтрок;
			КонецЕсли;

			СтрокаТекста = Лев(Стр, Поз - 1);
			СтрокаЭлемента = Справочники.ЗначенияЯчеекТаблицДанных.НайтиПоНаименованию(СтрокаТекста);
			Если НЕ ЗначениеЗаполнено(СтрокаЭлемента) Тогда
				СтрокаЭлементаО = Справочники.ЗначенияЯчеекТаблицДанных.СоздатьЭлемент();
				СтрокаЭлементаО.Наименование = СтрокаТекста;
				СтрокаЭлементаО.Записать();
				СтрокаЭлемента = СтрокаЭлементаО.ссылка;
			КонецЕсли;

			МассивСтрок.Добавить(СтрокаЭлемента);
			Стр = Сред(Стр, Поз + ДлинаРазделителя);
		КонецЦикла;
	КонецЕсли;

КонецФункции

&НаКлиенте
Процедура СформироватьОбщееНаименование(Команда)

	ПредставлениеДокументаТаблицыДанных = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПредставлениеДокументаТаблицыДанных");

	Если ПустаяСтрока(ПредставлениеДокументаТаблицыДанных) Тогда
		ПредставлениеДокументаТаблицыДанных = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Таблица данных");
	КонецЕсли;

	Объект.ОбщееНаименование = ПредставлениеДокументаТаблицыДанных + " " + Объект.Номер + Символы.Таб + " " + Формат(Объект.Дата,  "ДФ='dd.MM.yy ЧЧ:мм'");

КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСДаннымиПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)

	Если НоваяСтрока Тогда
		ТекущиеДанные = Элементы.ТаблицаСДанными.ТекущиеДанные;
		Для Каждого ПолеТаблицы Из Объект.ОписаниеКолонок Цикл
			ЗначениеПоУмолчанию = ОбщийМодульПовтор.ПолучитьПустоеЗначениеДополнительногоРеквизита(ПолеТаблицы.ТипПоля);
			Выполнить(" ТекущиеДанные[""ЗначениеПоляТаблицы"" + СокрЛП(ПолеТаблицы.НомерСтроки)] = ЗначениеПоУмолчанию;");

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОписаниеШапкиПриИзменении(Элемент)
	глВремяПоследнегоСобытия = ТекущаяДата();
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаСДаннымиПриИзменении(Элемент)
	глВремяПоследнегоСобытия = ТекущаяДата();
КонецПроцедуры

&НаКлиенте
Процедура ТекстДокументаПриИзменении(Элемент)
	глВремяПоследнегоСобытия = ТекущаяДата();
КонецПроцедуры
