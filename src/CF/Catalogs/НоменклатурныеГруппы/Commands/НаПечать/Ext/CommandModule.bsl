﻿// sza140314-1711

&НаСервере
Процедура НаПечать(ДокументДляПечати, ПараметрКоманды)

	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал карточку номенклатурной группы."), 2);
	Справочники.НоменклатурныеГруппы.НаПечать(ДокументДляПечати, ПараметрКоманды);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормыПечати = Новый Структура("ОбъектПечати", ПараметрКоманды[0]);
	ФормаПечати = ПолучитьФорму("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	НаПечать(ФормаПечати.Результат, ПараметрКоманды);
	ФормаПечати.Результат.ОтображатьСетку 	= ЛОЖЬ;
	ФормаПечати.Результат.Защита 			= ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр 	= ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Номенклатурная группа");
	ФормаПечати.Открыть();

КонецПроцедуры
