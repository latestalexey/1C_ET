﻿//sza131014-0346 : 

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ФормаПечати = получитьформу("ОбщаяФорма.ФормаПечати");
	
	Печать(ФормаПечати.Результат, ПараметрКоманды);

	ФормаПечати.Результат.ОтображатьСетку = Ложь;
	ФормаПечати.Результат.Защита = Истина;
	ФормаПечати.Результат.ТолькоПросмотр = Истина;
	ФормаПечати.Результат.ОтображатьЗаголовки = Ложь;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Производитель");
	ФормаПечати.открыть();	
	
КонецПроцедуры

&НаСервере
Процедура Печать(ТабДок, ПараметрКоманды)
	
	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал карточку производителя. "), 2);
	Справочники.Производители.Печать(ТабДок, ПараметрКоманды);
	
КонецПроцедуры
