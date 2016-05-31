﻿// sza140521-0038
// sza140409-0125

&НаСервере
Процедура НаПечать(ДокументДляПечати, Знач ПараметрКоманды)

	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал таблицу."), 2);
	Документы.ТаблицыДанных.НаПечать(ДокументДляПечати, ПараметрКоманды);

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
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Таблица с данными");
	ФормаПечати.Открыть();

КонецПроцедуры
