﻿//sza131119-2316 
//sza110211-1241 строка 254
//sza110128-0238      
//sza110118-1825      
//sza101104-1758       
&НаКлиенте
Процедура ТипТутЧисло(Команда)
	
	Объект.ТипТут = "N";
	
	Если Объект.ДлинаТут = 120 Тогда
		Объект.ДлинаТут = 15;
	КонецЕсли;	
	
	Если Объект.ТочностьТут = 0 Тогда
		Объект.ТочностьТут = 2;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ТипТутДата(Команда)
	
	Объект.ТипТут = "D";
	Объект.ДлинаТут = 8;
	Объект.ТочностьТут = 0;
	
КонецПроцедуры

&НаКлиенте
Процедура ТипТутСтрока(Команда)
	
	Объект.ТипТут = "S";
	Объект.ТочностьТут = 0;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если ЗначениеЗаполнено(Объект.ОпределенноеЗначение) Тогда
		
		ОпределенноеЗначение = ТипЗнч(Объект.ОпределенноеЗначение);
		Если ОпределенноеЗначение = Тип("Число") Тогда
			
			Объект.ТипТут = "N";
			Если Объект.ДлинаТут = 120 Тогда
				Объект.ДлинаТут = стрдлина(СокрЛП(Объект.ОпределенноеЗначение));
			КонецЕсли;	
			
		иначеесли ОпределенноеЗначение = Тип("Булево") Тогда
			
			Объект.ТипТут = "N";
			Объект.ДлинаТут = 1;
			Объект.ТочностьТут = 0;
			
		иначеесли ОпределенноеЗначение = Тип("Дата") Тогда
			
			Объект.ТипТут = "D";
			Объект.ДлинаТут = 8;
			Объект.ТочностьТут = 0;
			
		КонецЕсли; 
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПоляПриИзменении(Элемент)
	Если НЕ ЗначениеЗаполнено(Объект.ЗаголовокПоляПоУмолчанию) Тогда
		Объект.ЗаголовокПоляПоУмолчанию = СтрЗаменить(Объект.Наименование," ","");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТипТутЛогика(Команда)
	Объект.ТипТут = "L";
	Объект.ДлинаТут = 1;
	Объект.ТочностьТут = 0;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	УстановитьВидимостьЭлементовФормы();
	
КонецПроцедуры

Процедура УстановитьВидимостьЭлементовФормы()
	
	Если Объект.Предопределенный Тогда
		Элементы.Коэффициент.Доступность = Ложь; 	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТипТутСтрока254(Команда)
	Объект.ТипТут = "S";
	Объект.ДлинаТут = 254;
	Объект.ТочностьТут = 0;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0, Объект.Ссылка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1, Объект.Ссылка, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = Истина;
КонецПроцедуры
