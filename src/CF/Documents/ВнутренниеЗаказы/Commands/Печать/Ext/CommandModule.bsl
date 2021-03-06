﻿// sza151217-2319

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормыПечати = Новый Структура("ОбъектПечати", ПараметрКоманды[0]);
	ФормаПечати = ПолучитьФорму("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	Печать(ФормаПечати.Результат, ПараметрКоманды);
	ФормаПечати.Результат.ОтображатьСетку = ЛОЖЬ;
	ФормаПечати.Результат.Защита = ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр = ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: внутренний заказ");
	ФормаПечати.Открыть();

КонецПроцедуры

&НаСервере
Процедура Печать(ДокументДляПечати, ПараметрКоманды)

	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал документ."), 2);
	Документы.ВнутренниеЗаказы.Печать(ДокументДляПечати, ПараметрКоманды);

КонецПроцедуры
