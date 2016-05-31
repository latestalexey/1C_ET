﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza151210-2245 про
// sza150609-0317
Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ПометкаУдаления
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		Отказ = ОбщийМодульСервер.ПроверитьУникальностьЗначенияРеквизита(Отказ, "ХранилищаДенег", Наименование, Ссылка);
		ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(Наименование, Ссылка, , Отказ);
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
			ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "ДляНоменклатурныхГрупп", "НоменклатурнаяГруппа", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("номенклатурных групп"));
			ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "ДляНоменклатурыИЕеГрупп");
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриЗаписи(Отказ)

	Если НЕ Отказ
		И Модифицированность()
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
