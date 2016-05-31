﻿// sza140420-1356
// sza131111-1824

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000200", , , );

	Если НЕ Отказ Тогда
		Если НЕ ОбщийМодульСервер.ПроверитьДокументПроведен(ПараметрКоманды) Тогда
			Если ОбщийМодульСервер.ПроверитьПользовательИмеетПравоМенятьЦены() Тогда
				Коэффициент = 1;
				ПоказатьВводЧисла(Новый ОписаниеОповещения("ОбработкаКомандыЗавершение", ЭтотОбъект, Новый Структура("ПараметрКоманды, Коэффициент", ПараметрКоманды, Коэффициент)), Коэффициент, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Коэффициент для Цен") + ": ", 12, 6);
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
		Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Пересчет цен для таблицы товара по коэффициенту..") + Коэффициент);
		ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Пересчитал цены товара по коэффициенту") + " " + Коэффициент, 2, ПараметрКоманды);
		ОбщийМодульКлиент.ПересчитатьТаблицуТовары(ПараметрКоманды, Коэффициент);
	КонецЕсли;

КонецПроцедуры
