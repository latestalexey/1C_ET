﻿// sza150406-0452
// sza140211-1307

&НаКлиенте
Процедура ДействиеСформировать(Команда)
	СформироватьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураПриИзменении(Элемент)
	ОбновитьШтрихКод();
КонецПроцедуры

Процедура ОбновитьШтрихКод()
	Штрихкод = ОбщийМодульТоварСервер.ПолучитьШтрихКодНоменклатурыСерии(Номенклатура, СерияНоменклатуры);
КонецПроцедуры

&НаКлиенте
Процедура Печать(Команда)
	Результат.Напечатать(РежимИспользованияДиалогаПечати.Использовать);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ОбновитьШтрихКод();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000200", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		Если Параметры.Свойство("АвтоТест") Тогда
			Возврат;
		КонецЕсли;

		Штрихкод     = "2900001462105"; // "46120441";
		УголПоворота = 0;
		ТипШтрихкода = 1;
		ФлагФормирования = ЛОЖЬ;
		Элементы.ВДаннойОбработкеТестированияНеИспользуетсяМеханизмПроизвольныхПечатныхФорм.Видимость = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьПроизвольныеПечатныеФормы");
		ВнешняяКомпонента = МенеджерОборудованияСерверПовтИсп.ПодключитьВнешнююКомпонентуПечатиШтрихкода();

		Если НЕ ВнешняяКомпонента = Неопределено Тогда
			ВерсияКомпоненты = ВнешняяКомпонента.Версия;
		Иначе
			ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ошибка: Компонента печати штрих-кода не установлена!"));
		КонецЕсли;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СерияНоменклатурыПриИзменении(Элемент)

	Штрихкод = ОбщийМодульТоварСервер.ПолучитьШтрихКодСерии(СерияНоменклатуры);
	СформироватьНаСервере();

КонецПроцедуры

&НаСервере
Процедура СформироватьНаСервере()

	Результат.Очистить();
	ВремОбъект = РеквизитФормыВЗначение("Объект");
	Макет = ВремОбъект.ПолучитьМакет("Макет");
	Область = Макет.ПолучитьОбласть("СтрокаИКолонка");
	Рисунок = Область.Рисунки.ШтрихКод;
	Эталон = Обработки.ПечатьШтрихкода.ПолучитьМакет("Эталон");
	КоличествоМиллиметровВПикселе = Эталон.Рисунки.Квадрат100Пикселей.Высота / 100;
	ПараметрыШтрихкода = Новый Структура;
	ПараметрыШтрихкода.Вставить("Ширина"			, Окр(Рисунок.Ширина / КоличествоМиллиметровВПикселе));
	ПараметрыШтрихкода.Вставить("Высота"			, Окр(Рисунок.Высота / КоличествоМиллиметровВПикселе));
	ПараметрыШтрихкода.Вставить("ТипКода"			, ТипШтрихкода);
	ПараметрыШтрихкода.Вставить("ОтображатьТекст"	, ИСТИНА);
	ПараметрыШтрихкода.Вставить("РазмерШрифта"		, 12);
	ПараметрыШтрихкода.Вставить("УголПоворота"		, Число(УголПоворота));
	ПараметрыШтрихкода.Вставить("Штрихкод"			, Штрихкод);
	Картинка = МенеджерОборудованияВызовСервера.ПолучитьКартинкуШтрихкода(ПараметрыШтрихкода);
	Рисунок.Картинка = Картинка;
	ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Область);
	Результат.Вывести(Область);

КонецПроцедуры

&НаКлиенте
Процедура ТипШтрихкодаПриИзменении(Элемент)
	СформироватьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура УголПоворотаПриИзменении(Элемент)
	СформироватьНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ШтрихкодПриИзменении(Элемент)

	НоменклатураПоШтрихКоду = ОбщийМодульТоварСервер.НайтиНоменклатуруПоШтрихКоду(Штрихкод, ИСТИНА, ИСТИНА);

	Если НЕ НоменклатураПоШтрихКоду = Неопределено
		И НЕ ЗначениеЗаполнено(НоменклатураПоШтрихКоду) Тогда

		Номенклатура = НоменклатураПоШтрихКоду.Номенклатура;
		СерияНоменклатуры = НоменклатураПоШтрихКоду.СерияНоменклатуры;
	КонецЕсли;

	СформироватьНаСервере();

КонецПроцедуры
