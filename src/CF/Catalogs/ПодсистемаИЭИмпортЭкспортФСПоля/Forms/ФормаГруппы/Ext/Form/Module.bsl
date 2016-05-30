﻿//sza131125-1532 SZA: 
//sza131119-2317 

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	если ЗначениеЗаполнено(Объект.Ссылка)
		И Объект.Ссылка = Объект.Родитель Тогда
		
		Объект.Родитель = ОбщийМодульКлиент.ПолучитьРодителя(Объект.Родитель);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = Истина;
КонецПроцедуры
