﻿// sza140521-0039  
// sza140411-0137  
&НаСервере
Процедура НаПечать(ТабДок, ПараметрКоманды)
	
	ОбщийМодульСервер.ДобавитьСобытиеЖурналаНаСервере(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Напечатал Комплектацию"), 2);
	Документы.Комплектация.НаПечать(ТабДок, ПараметрКоманды);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОбъектПечати", ПараметрКоманды[0]);
	ПараметрыФормы.Вставить("Документ", ПараметрКоманды[0]);
	ФормаПечати = получитьформу("ОбщаяФорма.ФормаПечати", ПараметрыФормы);
	
	НаПечать(ФормаПечати.Результат, ПараметрКоманды);

	ФормаПечати.Результат.ОтображатьСетку = ЛОЖЬ;
	ФормаПечати.Результат.Защита = ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр = ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Комплектация");
	ФормаПечати.открыть();	
	
КонецПроцедуры
