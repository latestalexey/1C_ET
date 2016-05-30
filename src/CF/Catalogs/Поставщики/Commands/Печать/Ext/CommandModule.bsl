﻿//sza131106-0148

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = новый Структура;
	ПараметрыФормы.Вставить("Контрагент", ПараметрКоманды[0]);
	ПараметрыФормы.Вставить("НаименованиеДокумента", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Карточка"));
	ФормаПечати = получитьформу("ОбщаяФорма.ФормаПечати", ПараметрыФормы);
	
	Печать(ФормаПечати.Результат, ПараметрКоманды);

	ФормаПечати.Результат.ОтображатьСетку 	= Ложь;
	ФормаПечати.Результат.Защита 			= Истина;
	ФормаПечати.Результат.ТолькоПросмотр 	= Истина;
	ФормаПечати.Результат.ОтображатьЗаголовки = Ложь;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Карточка Поставщика");
	ФормаПечати.открыть();	
	
КонецПроцедуры

&НаСервере
Процедура Печать(ТабДок, ПараметрКоманды)
	
	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал карточку поставщика. "), 2);
	Справочники.Поставщики.Печать(ТабДок, ПараметрКоманды);
	
КонецПроцедуры
