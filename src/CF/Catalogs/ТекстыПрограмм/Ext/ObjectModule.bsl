﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza151013-0515
Процедура ПередЗаписью(Отказ)

	Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда
		Если НЕ ЗначениеЗаполнено(ВерсияКонфигурацииПриСохранении) Тогда
			ВерсияКонфигурацииПриСохранении	= ОбщийМодульСервисСервер.ПолучитьВерсиюПлатформы(, ИСТИНА);
		КонецЕсли;

		Если НЕ ЗначениеЗаполнено(ВерсияПлатформыПриСохранении) Тогда
			ВерсияПлатформыПриСохранении = ОбщийМодульСервисСервер.ПолучитьВерсиюПлатформы();
		КонецЕсли;

		Если НЕ ЗначениеЗаполнено(ДатаРазработки) Тогда
			ДатаРазработки = ТекущаяДата();
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Комментарий = "";
КонецПроцедуры

#КонецЕсли
