﻿// sza140521-0033  
// sza140228-0419  
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормыПечати = Новый Структура("ОбъектПечати", ПараметрКоманды[0]);
	ФормаПечати = получитьформу("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	Печать(ФормаПечати.Результат, ПараметрКоманды);

	ФормаПечати.Результат.ОтображатьСетку 	= ЛОЖЬ;
	ФормаПечати.Результат.Защита 			= ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр 	= ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Карточка сертификата");
	ФормаПечати.открыть();	
	
КонецПроцедуры

&НаСервере
Процедура Печать(ТабДок, ПараметрКоманды)
	
	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал карточку сертификата."), 2);
	Справочники.СертификатыГигиеническиеЗаключения.Печать(ТабДок, ПараметрКоманды);
	
КонецПроцедуры



