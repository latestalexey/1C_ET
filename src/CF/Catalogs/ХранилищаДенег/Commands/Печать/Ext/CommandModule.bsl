﻿// sza140521-0030
// sza131129-2140

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормыПечати = Новый Структура("ОбъектПечати", ПараметрКоманды[0]);
	ФормаПечати = ПолучитьФорму("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	Печать(ФормаПечати.Результат, ПараметрКоманды);
	ФормаПечати.Результат.ОтображатьСетку 	= ЛОЖЬ;
	ФормаПечати.Результат.Защита 			= ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр 	= ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: хранилище денег");
	ФормаПечати.Открыть();

КонецПроцедуры

&НаСервере
Процедура Печать(ДокументДляПечати, Знач ПараметрКоманды)

	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал карточку хранилища денег."), 2);
	Справочники.ХранилищаДенег.Печать(ДокументДляПечати, ПараметрКоманды);

КонецПроцедуры
