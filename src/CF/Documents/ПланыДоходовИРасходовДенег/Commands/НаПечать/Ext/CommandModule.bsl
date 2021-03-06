﻿// sza140530-1704 : 
&НаСервере
Процедура НаПечать(ТабДок, ПараметрКоманды)
	
	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал План доходов и расходов."), 2);
	Документы.ПланыДоходовИРасходовДенег.НаПечать(ТабДок, ПараметрКоманды);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормыПечати = Новый Структура("ОбъектПечати", ПараметрКоманды[0]);
	ФормаПечати = получитьформу("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	НаПечать(ФормаПечати.Результат, ПараметрКоманды);

	ФормаПечати.Результат.ОтображатьСетку = ЛОЖЬ;
	ФормаПечати.Результат.Защита = ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр = ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: План доходов и расходов");
	ФормаПечати.открыть();	
	
КонецПроцедуры



