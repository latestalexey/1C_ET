﻿// sza150515-0147

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Перем Данные, Условие, Элемент;
	// сложим условия в транспортабельную структуру
	Данные = Новый Массив;
	Для Каждого Условие Из УсловияЖурнала Цикл
		Элемент = Новый Структура("Колонка, Условие, Значение, ВедущаяКолонка, Событие, КолонкаПредставление");
		ЗаполнитьЗначенияСвойств(Элемент, Условие);
		Данные.Добавить(Элемент);
	КонецЦикла;
	Закрыть(Данные);
	
КонецПроцедуры

&НаСервере
Функция ПредставлениеКолонки(ИмяКолонки)
	
	Перем Результат;
	
	Результат = СписокКолонок.НайтиПоЗначению(ИмяКолонки);
	Если Результат = Неопределено Тогда
		Возврат "<?>";
	Иначе
		Возврат Результат.Представление;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Перем ОбъектОбработки, Текст, ЭлементСписка, СписокТипов, УсловияСобытия, Условие, СтрокаДанных;
	
	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
	КонецЕсли;
	
	ОбъектОбработки = РеквизитФормыВЗначение("Объект");
	МетаПуть = ОбъектОбработки.Метаданные().ПолноеИмя();
	Событие = Параметры.Событие;
	Колонка = Параметры.Колонка;
	Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Редактирование условий для свойства") + " <%1%> " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("события") + " <%2%>";
	Текст = СтрЗаменить(Текст, "%1%", СокрЛП(Колонка));
	Заголовок = СтрЗаменить(Текст, "%2%", СокрЛП(Событие));
	// зададим список выбора для списка колонок
	Для Каждого ЭлементСписка Из Параметры.СписокКолонок Цикл
		СписокКолонок.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
	КонецЦикла;
	СписокКолонок.СортироватьПоПредставлению();
	// установим список типов
	СписокТипов = Новый Структура;
	// скопируем таблицу типов Из параметра в нашу форму
	Для Каждого ТипКолонки Из Параметры.СписокТипов Цикл
		СписокТипов.Вставить(ТипКолонки.Ключ, ?(ТипЗнч(ТипКолонки.Значение) = Тип("СписокЗначений"), ТипКолонки.Значение.Скопировать(), ТипКолонки.Значение));
	КонецЦикла; 
	// установим текущие условия
	Если Параметры.ВсеУсловия <> Неопределено Тогда
		УсловияСобытия = Параметры.ВсеУсловия.НайтиСтроки(Новый Структура("ВедущаяКолонка,Событие", Колонка, Событие));
		Для Каждого Условие Из УсловияСобытия Цикл
			СтрокаДанных = УсловияЖурнала.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаДанных, Условие);
			СтрокаДанных.КолонкаПредставление = ПредставлениеКолонки(СтрокаДанных.Колонка);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция РедактируемоеПоле(ИмяЭлемента)
	
	Если ИмяЭлемента = "УсловияЖурналаКолонкаПредставление" Тогда
		Возврат "Свойство";
	ИначеЕсли ИмяЭлемента = "УсловияЖурналаУсловие" Тогда
		Возврат "Условие";
	ИначеЕсли ИмяЭлемента = "УсловияЖурналаЗначение" Тогда
		Возврат "Значение";
	КонецЕсли;
	Возврат "";
	
КонецФункции

&НаКлиенте
Процедура УсловияЖурналаПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Перем ПараметрыФормы, ОбратныйВызов;
	Отказ = ИСТИНА;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Свойство", "");
	ПараметрыФормы.Вставить("Условие", "");
	ПараметрыФормы.Вставить("Значение", "");
	ПараметрыФормы.Вставить("СписокТипов", СписокТипов);
	ПараметрыФормы.Вставить("СписокКолонок", СписокКолонок);
	ПараметрыФормы.Вставить("ТекущаяКолонка", "");
	Если НЕ ОбщийМодульСервисСервер.ПолучитьВерсиюПлатформы() < 803040000 Тогда
		Выполнить(" ОбратныйВызов = Новый ОписаниеОповещения(""УсловияЖурналаПередНачаломДобавленияЗавершение"", Объект); 
		| ОткрытьФорму(МетаПуть + "".Форма.РедакторУсловия"", ПараметрыФормы, , , , , ОбратныйВызов); ");	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УсловияЖурналаПередНачаломДобавленияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Перем СтрокаСписка;
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		СтрокаСписка = УсловияЖурнала.Добавить();
		СтрокаСписка.Колонка = Результат.Свойство;
		СтрокаСписка.КолонкаПредставление = ПредставлениеКолонки(Результат.Свойство);
		СтрокаСписка.Условие = Результат.Условие;
		СтрокаСписка.Значение = Результат.Значение;
		СтрокаСписка.Событие = Событие;
		СтрокаСписка.ВедущаяКолонка = Колонка;
		Элементы.УсловияЖурнала.ТекущаяСтрока = СтрокаСписка.ПолучитьИдентификатор();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УсловияЖурналаПередНачаломИзменения(Элемент, Отказ)
	
	Перем ТекущиеДанные, ПараметрыФормы, ОбратныйВызов;
	
	Отказ = ИСТИНА;
	
	ТекущиеДанные = Элементы.УсловияЖурнала.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Свойство", ТекущиеДанные.Колонка);
	ПараметрыФормы.Вставить("Условие", ТекущиеДанные.Условие);
	ПараметрыФормы.Вставить("Значение", ТекущиеДанные.Значение);
	ПараметрыФормы.Вставить("СписокТипов", СписокТипов);
	ПараметрыФормы.Вставить("СписокКолонок", СписокКолонок);
	ПараметрыФормы.Вставить("ТекущаяКолонка", РедактируемоеПоле(Элементы.УсловияЖурнала.ТекущийЭлемент.Имя));
	Если НЕ ОбщийМодульСервисСервер.ПолучитьВерсиюПлатформы() < 803040000 Тогда
		Выполнить(" ОбратныйВызов = Новый ОписаниеОповещения(""УсловияЖурналаПередНачаломИзмененияЗавершение"", Объект); 
		| ОткрытьФорму(МетаПуть + "".Форма.РедакторУсловия"", ПараметрыФормы, , , , , ОбратныйВызов); ");	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УсловияЖурналаПередНачаломИзмененияЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Перем ТекущиеДанные;
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ТекущиеДанные = Элементы.УсловияЖурнала.ТекущиеДанные;
		ТекущиеДанные.Колонка = Результат.Свойство;
		ТекущиеДанные.КолонкаПредставление = ПредставлениеКолонки(Результат.Свойство);
		ТекущиеДанные.Условие = Результат.Условие;
		ТекущиеДанные.Значение = Результат.Значение;
	КонецЕсли;
	
КонецПроцедуры
