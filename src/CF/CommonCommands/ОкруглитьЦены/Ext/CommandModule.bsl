﻿// sza140420-1355
// sza140404-0037 :

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000200", , , );

	Если НЕ Отказ Тогда
		Если НЕ ОбщийМодульСервер.ПроверитьДокументПроведен(ПараметрКоманды) Тогда
			Если ОбщийМодульСервер.ПроверитьПользовательИмеетПравоМенятьЦены() Тогда
				Коэффициент = 0;
				ПоказатьВводЧисла(Новый ОписаниеОповещения("ОбработкаКомандыЗавершение", ЭтотОбъект, Новый Структура("ПараметрКоманды, Коэффициент", ПараметрКоманды, Коэффициент)), Коэффициент, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Число знаков после запятой") + ": ", 1, 0);
			Иначе
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("У Вас нет права менять цены!"), СтатусСообщения.Внимание);
			КонецЕсли;
		Иначе
			ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Документ уже проведен. Изменения не произведены."), СтатусСообщения.Информация);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКомандыЗавершение(Число, ДополнительныеПараметры) Экспорт

	ПараметрКоманды = ДополнительныеПараметры.ПараметрКоманды;
	Коэффициент = ?(Число = Неопределено, ДополнительныеПараметры.Коэффициент, Число);
	Если НЕ Число = Неопределено Тогда
		ОкруглятьВверх = Неопределено;
		ПоказатьВопрос(Новый ОписаниеОповещения("ОбработкаКомандыЗавершениеЗавершение", ЭтотОбъект, Новый Структура("Коэффициент, ПараметрКоманды", Коэффициент, ПараметрКоманды)), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Следует ли округлять исключительно в большую сторону?"), РежимДиалогаВопрос.ДаНет);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКомандыЗавершениеЗавершение(РезультатВопроса, ДополнительныеПараметры1) Экспорт

	Коэффициент = ДополнительныеПараметры1.Коэффициент;
	ПараметрКоманды = ДополнительныеПараметры1.ПараметрКоманды;
	ОкруглятьВверх = РезультатВопроса = КодВозвратаДиалога.Да;
	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Округление цен для таблицы товара") + " " + Коэффициент);
	ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Округлил цены товара") + " " + Коэффициент, 2, ПараметрКоманды);
	ОбщийМодульКлиент.ОкруглитьДанныеВТаблицеТовары(ПараметрКоманды, Коэффициент, ОкруглятьВверх);

КонецПроцедуры
