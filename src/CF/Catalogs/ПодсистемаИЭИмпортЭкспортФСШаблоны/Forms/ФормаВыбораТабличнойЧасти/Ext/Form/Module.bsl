﻿//sza131119-2322 
//sza131003-1910 : 
//sza101116-0110       
//sza101115-1718       
&НаКлиенте
Процедура ВыбратьТабличнуюЧасть(Команда)
	ЭтаФорма.Закрыть(Элементы.ИмяТабличнойЧасти);
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьИЗакрыть(Команда)
	ИмяТабличнойЧасти = "";
	ЭтаФорма.Закрыть(Элементы.ИмяТабличнойЧасти);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	
	Если Элементы.ИмяТабличнойЧасти.СписокВыбора.Количество() = 0 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Таблиц у объекта нет!");
		Сообщение.Сообщить();			
		Отказ = ИСТИНА;
		
	ИначеЕсли Элементы.ИмяТабличнойЧасти.СписокВыбора.Количество() = 1 Тогда
		ЭтаФорма.ИмяТабличнойЧасти = Элементы.ИмяТабличнойЧасти.СписокВыбора.Получить(0);
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Таблица только одна -")+ЭтаФорма.ИмяТабличнойЧасти;
		Сообщение.Сообщить();
		Отказ = ИСТИНА
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	Элементы.ИмяТабличнойЧасти.СписокВыбора.Очистить();
	
	Попытка
	Для Каждого ТипОбъекта из Метаданные[Параметры.ТипМета][Параметры.ТипОбъектаОбмена].ТабличныеЧасти Цикл 	
		Элементы.ИмяТабличнойЧасти.СписокВыбора.Добавить(ТипОбъекта.Имя, ТипОбъекта.Синоним);
	КонецЦикла;	
	Исключение
	КонецПопытки;
	
КонецПроцедуры



