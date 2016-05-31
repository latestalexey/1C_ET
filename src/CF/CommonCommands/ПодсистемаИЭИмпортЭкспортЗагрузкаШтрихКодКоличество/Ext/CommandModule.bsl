﻿// sza140411-2239 :

&НаСервере
Процедура ЗагрузитьШтрихКодКОличество(Знач Адрес, Знач ПараметрКоманды)

	ОбъектДокумент = ПараметрКоманды.ПолучитьОбъект();
	ОбъектДокумент.Товары.Очистить();
	Если ТипЗнч(ПараметрКоманды) = Тип("ДокументСсылка.ТаблицыДанных") Тогда
		ИмяТаблицы  = "ТаблицаСДанными";
		ИмяКолонки1 = "ЗначениеПоляТаблицы1";
		ИмяКолонки2 = "ЗначениеПоляТаблицы2";
	Иначе
		ИмяТаблицы  = "Товары";
		ИмяКолонки1 = "Номенклатура";
		ИмяКолонки2 = "Количество";

	КонецЕсли;

	ВидДокумента = ПараметрКоманды.МЕТАДАННЫЕ().Имя;
	ЕстьЕдиницаИзмерения = ОбщийМодульСервисСервер.ЕстьЛиРеквизит(ВидДокумента, "ЕдиницаИзмерения", ИмяТаблицы);
	ЕстьСерия = ОбщийМодульСервисСервер.ЕстьЛиРеквизит(ВидДокумента, "СерияНоменклатуры", ИмяТаблицы);
	ЕстьКоличество = ОбщийМодульСервисСервер.ЕстьЛиРеквизит(ВидДокумента, ИмяКолонки2, ИмяТаблицы);
	ТаблицаТоваров = Новый ТаблицаЗначений;
	ТаблицаТоваров.Колонки.Добавить(ИмяКолонки1);

	Если ЕстьЕдиницаИзмерения Тогда
		ТаблицаТоваров.Колонки.Добавить("ЕдиницаИзмерения");
	КонецЕсли;

	Если ЕстьСерия Тогда
		ТаблицаТоваров.Колонки.Добавить("СерияНоменклатуры");
	КонецЕсли;

	Если ЕстьКоличество Тогда
		ТаблицаТоваров.Колонки.Добавить(ИмяКолонки2);
	Иначе
		ТаблицаТоваров.Колонки.Добавить("Цена");
	КонецЕсли;

	ТекстДок = Новый ТекстовыйДокумент;
	ТекстДок.Прочитать(Адрес);
	Счетчик = 1;
	СтрокаФайла = СокрЛП(ТекстДок.ПолучитьСтроку(Счетчик));

	Пока НЕ ПустаяСтрока(СтрокаФайла) Цикл
		Счетчик = Счетчик + 1;
		СтрокаТовара = ТаблицаТоваров.Добавить();
		СтруктураПоШК = ОбщийМодульТоварСервер.НайтиНоменклатуруПоШтрихКоду(СтрокаФайла, ЕстьСерия, , ПараметрКоманды.Дата);
		СтрокаТовара[ИмяКолонки1] = СтруктураПоШК.Номенклатура;

		Если ЕстьСерия Тогда
			СтрокаТовара.СерияНоменклатуры = СтруктураПоШК.СерияНоменклатуры;
		КонецЕсли;

		Если ЕстьЕдиницаИзмерения Тогда
			СтрокаТовара.ЕдиницаИзмерения = СтруктураПоШК.ЕдиницаИзмерения;
		КонецЕсли;

		СтрокаФайла = СокрЛП(ТекстДок.ПолучитьСтроку(Счетчик));
		Счетчик = Счетчик + 1;
		Если НЕ ПустаяСтрока(СтрокаФайла) ТОгда
			Если ЕстьКоличество Тогда
				Попытка
					СтрокаТовара[ИмяКолонки2] = Число(СтрокаФайла);
				Исключение
				КонецПопытки;
			Иначе
				Попытка
					СтрокаТовара.Цена = Число(СтрокаФайла);
				Исключение
				КонецПопытки;
			КонецЕсли;
		КонецЕсли;

		СтрокаФайла = СокрЛП(ТекстДок.ПолучитьСтроку(Счетчик));

	КонецЦикла;

	Если ЕстьКоличество Тогда
		ТаблицаТоваров.Свернуть(ИмяКолонки1 + ?(ЕстьСерия, ", СерияНоменклатуры", "") + ?(ЕстьЕдиницаИзмерения, ", ЕдиницаИзмерения", ""), ИмяКолонки2);
	КонецЕсли;

	ОбъектДокумент.Товары.Загрузить(ТаблицаТоваров);
	ОбъектДокумент.Записать();
	ТекстДок = Неопределено;

КонецПроцедуры // ВыгрузитьШтрихКодКОличество(Адрес)

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", , , );

	Если НЕ Отказ Тогда
		КвоСтрок = ПодсистемаИЭ.ПараметрКомандыТоварыКоличество(ПараметрКоманды);
		ПоказатьВопрос(Новый ОписаниеОповещения("ОбработкаКомандыЗавершение1", ЭтотОбъект, Новый Структура("КвоСтрок, ПараметрКоманды", КвоСтрок, ПараметрКоманды)), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Очистить таблицу Товары?"), РежимДиалогаВопрос.ДаНет);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКомандыЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт

	ДиалогДляВыбораФайла = ДополнительныеПараметры.ДиалогДляВыбораФайла;
	ПараметрКоманды = ДополнительныеПараметры.ПараметрКоманды;
	Если (ВыбранныеФайлы <> Неопределено) Тогда
		Адрес = ДиалогДляВыбораФайла.ПолноеИмяФайла;
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Загружается документ"), , ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ждите.."));
		ЗагрузитьШтрихКодКОличество(Адрес, ПараметрКоманды);
		ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Загрузил таблицу штрихкода из файла"), 2, ПараметрКоманды);
	КонецЕсли; // когда файл Адрес выбран

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКомандыЗавершение1(РезультатВопроса, ДополнительныеПараметры) Экспорт

	КвоСтрок = ДополнительныеПараметры.КвоСтрок;
	ПараметрКоманды = ДополнительныеПараметры.ПараметрКоманды;

	Если НЕ КвоСтрок = Неопределено
		И (КвоСтрок = 0 ИЛИ РезультатВопроса = КодВозвратаДиалога.Да) Тогда

		Адрес = "";
		ДиалогФильтр	 = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Файл текста") + " (*.*)|*.*";
		ДиалогРасширение = "*";
		ДиалогДляВыбораФайла 	 = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
		ДиалогДляВыбораФайла.Заголовок		  =	ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выберите файл для загрузки") + ": ";
		ДиалогДляВыбораФайла.ПолноеИмяФайла	  =	Адрес; // АДРЕС
		ДиалогДляВыбораФайла.Фильтр			  =	ДиалогФильтр;
		ДиалогДляВыбораФайла.Расширение		  =	ДиалогРасширение;
		ДиалогДляВыбораФайла.МножественныйВыбор =	ЛОЖЬ;
		ДиалогДляВыбораФайла.ИндексФильтра	  =	0;
		ДиалогДляВыбораФайла.ПроверятьСуществованиеФайла = ИСТИНА;
		ДиалогДляВыбораФайла.Показать(Новый ОписаниеОповещения("ОбработкаКомандыЗавершение", ЭтотОбъект, Новый Структура("ДиалогДляВыбораФайла, ПараметрКоманды", ДиалогДляВыбораФайла, ПараметрКоманды)));
	КонецЕсли;

КонецПроцедуры
