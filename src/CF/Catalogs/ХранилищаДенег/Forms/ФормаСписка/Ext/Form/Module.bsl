﻿//sza131129-2146 SZA: 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура Деньги(Команда)
	
	ФормаОстатоков = ПолучитьФорму("ОбщаяФорма.Деньги");
	ФормаОстатоков.Открыть();
	
КонецПроцедуры
