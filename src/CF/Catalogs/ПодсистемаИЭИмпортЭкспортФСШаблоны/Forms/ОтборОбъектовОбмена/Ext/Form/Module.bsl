﻿//sza131119-2320 
//sza131003-1913 

&НаКлиенте
Процедура ПродолжитьИВыгрузить(Команда)
	
	ЭтаФорма.Закрыть(ТаблицаОбмена);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	
	//// создаем реквизиты
	ДобавляемыеРеквизиты = Новый Массив;
	//	
	////	Элементы.Вставить("ТаблицаОбмена", Тип("ТаблицаФормы"));
	
	Если ЗначениеЗаполнено(Параметры.таблицаОбмена) Тогда
		Для Каждого Колонка Из Параметры.таблицаОбмена.Колонки Цикл
			КолонкаИмя = СокрЛП(Колонка.Имя);
			
			Если Не КолонкаИмя = "Обрабатывать" Тогда
				НовыйРеквизитФормы = Новый РеквизитФормы("" + КолонкаИмя, Новый ОписаниеТипов("Строка"), "ТаблицаОбмена", КолонкаИмя);
				ДобавляемыеРеквизиты.Добавить(НовыйРеквизитФормы);	
			КонецЕсли;
			
		КонецЦикла;
		
		ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		
		Для Каждого Колонка Из Параметры.таблицаОбмена.Колонки Цикл
			КолонкаИмя = СокрЛП(Колонка.Имя);
			
			Если Не КолонкаИмя = "Обрабатывать" Тогда
				Элемент = Элементы.Добавить(КолонкаИмя, Тип("ПолеФормы"), Элементы.ТаблицаОбменаЭл); 
				Элемент.Вид = ВидПоляФормы.ПолеВвода;
				
				Элемент.ПутьКДанным = "ТаблицаОбмена." + КолонкаИмя;	
				Если НЕ Найти(Колонка.заголовок, "SPTSZN") = 0 Тогда
					Элемент.Видимость = ложь;
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;
		
		ЗначениеВРеквизитФормы(Параметры.ТаблицаОбмена, "ТаблицаОбмена");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОбрабатыватьВсе(Команда)
	
	Для Каждого СтрокаТаблицыОбмена Из ТаблицаОбмена Цикл
		СтрокаТаблицыОбмена.Обрабатывать = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОбрабатыватьНичего(Команда)
	
	Для Каждого СтрокаТаблицыОбмена Из ТаблицаОбмена Цикл
		СтрокаТаблицыОбмена.Обрабатывать = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры
