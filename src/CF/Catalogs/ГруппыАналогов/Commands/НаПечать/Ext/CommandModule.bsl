﻿// sza140424-1619

&НаСервере
Процедура НаПечать(ДокументДляПечати, Знач ПараметрКоманды)

	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал карточку группы аналогов"), 2);
	Справочники.ГруппыАналогов.НаПечать(ДокументДляПечати, ПараметрКоманды);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормыПечати = Новый Структура("ОбъектПечати", ПараметрКоманды[0]);
	ФормаПечати = ПолучитьФорму("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	НаПечать(ФормаПечати.Результат, ПараметрКоманды);
	ФормаПечати.Результат.ОтображатьСетку = ЛОЖЬ;
	ФормаПечати.Результат.Защита = ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр = ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: группа аналогов");
	ФормаПечати.Открыть();

КонецПроцедуры
