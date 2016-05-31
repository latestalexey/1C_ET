﻿// sza160308-0032
// sza150626-0434
// sza150403-0258

&НаКлиенте
Процедура ДобавитьСебя(Команда)
	ДобавитьСебяНаСервере();
КонецПроцедуры

&НаСервере
Процедура ДобавитьСебяНаСервере()

	СтрокаПолучатели = Объект.ПолучателиСообщения.Добавить();
	СтрокаПолучатели.Получатель = ПараметрыСеанса.ТекущийПользователь;

КонецПроцедуры

&НаКлиенте
Процедура КодПрограммыПриИзменении(Элемент)

	ТекСтрока = Элементы.РеакцииНаСобытие.ТекущиеДанные;

	Если НЕ ТекСтрока = Неопределено Тогда
		ТекСтрока.РеакцияПрограмма = КодПрограммы;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	глЧислоОбъектов = глЧислоОбъектов + 1; глПроверятьСообщения = ИСТИНА;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002800", ЭтаФорма, Отказ);

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

		Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
			Если ЗначениеЗаполнено(Параметры.ОбъектПодписки) Тогда
				СтрокаОбъекта = Объект.ОбъектыСобытия.Добавить();
				СтрокаОбъекта.ОбъектСобытия = Параметры.ОбъектПодписки;
				СтрокаОбъекта.ОСтроке = "" + Параметры.ОбъектПодписки;
				Объект.Комментарий = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Для") + " " + СтрокаОбъекта.ОСтроке;
				СтрокаУсловия = Объект.УсловияСобытия.Добавить();
				СтрокаУсловия.ОбъектСобытия = СокрЛП(Параметры.ОбъектПодписки.Метаданные().Имя);
				СтрокаУсловия.НаименованиеОбъектаСобытия = ОбщийМодульСервисСервер.ПолучитьКрасивоеНаименованиеОбъекта(ТипЗнч(Параметры.ОбъектПодписки));
				Объект.Наименование = Объект.Комментарий;
				ЭтаФорма.ТекущийЭлемент = Элементы.УсловияСобытияВидСобытия;
			КонецЕсли;
		КонецЕсли;

		Для Каждого СправочникМетаданных Из Метаданные.Справочники Цикл
			Элементы.УсловияСобытияНаименованиеОбъектаСобытия.СписокВыбора.Добавить(СправочникМетаданных.Имя, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(СправочникМетаданных.Синоним));
		КонецЦикла;

		Для Каждого ДокументМетаданных Из Метаданные.Документы Цикл
			Элементы.УсловияСобытияНаименованиеОбъектаСобытия.СписокВыбора.Добавить(ДокументМетаданных.Имя, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(ДокументМетаданных.Синоним));
		КонецЦикла;

		Элементы.УсловияСобытияНаименованиеОбъектаСобытия.СписокВыбора.СортироватьПоПредставлению();
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВместоТумблеровПоказыватьГалочки") Тогда
			Элементы.Отключено.ВидФлажка = ВидФлажка.Флажок;
			Элементы.Отключено.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Отключено (неактивно)");
			Элементы.Отключено.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Право;
		КонецЕсли;
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура РеакцииНаСобытиеПриАктивизацииСтроки(Элемент)
	ПодключитьОбработчикОжидания("СписокПриАктивизацииСтрокиОповещение", 0.2, ИСТИНА);
КонецПроцедуры

&НаКлиенте
Процедура РеакцииНаСобытиеРеакцияПрограммаПриИзменении(Элемент)

	ТекСтрока = Элементы.РеакцииНаСобытие.ТекущиеДанные;

	Если НЕ ТекСтрока = Неопределено Тогда
		КодПрограммы = ТекСтрока.РеакцияПрограмма;
		Элементы.КодПрограммы.Доступность = ИСТИНА;
		Элементы.КодПрограммы.Видимость = (ТекСтрока.СпособРеакции = ПредопределенноеЗначение("Перечисление.СпособыРеакции.ВыполнитьПрограмму")) ИЛИ (ТекСтрока.СпособРеакции = ПредопределенноеЗначение("Перечисление.СпособыРеакции.ВыполнитьПрограммуСОбъектом"));
	Иначе
		Элементы.КодПрограммы.Видимость = ЛОЖЬ;
		КодПрограммы = "";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтрокиОповещение()

	ТекСтрока = Элементы.РеакцииНаСобытие.ТекущиеДанные;

	Если НЕ ТекСтрока = Неопределено Тогда
		КодПрограммы = ТекСтрока.РеакцияПрограмма;
		Элементы.КодПрограммы.Доступность = ИСТИНА;
		Элементы.КодПрограммы.Видимость = (ТекСтрока.СпособРеакции = ПредопределенноеЗначение("Перечисление.СпособыРеакции.ВыполнитьПрограмму")) ИЛИ (ТекСтрока.СпособРеакции = ПредопределенноеЗначение("Перечисление.СпособыРеакции.ВыполнитьПрограммуСОбъектом"));
	Иначе
		Элементы.КодПрограммы.Видимость = ЛОЖЬ;
		КодПрограммы = "";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УсловияСобытияНаименованиеОбъектаСобытияПриИзменении(Элемент)

	ТекущиеДанные = Элементы.УсловияСобытия.ТекущиеДанные;

	Если ЗначениеЗаполнено(ТекущиеДанные.НаименованиеОбъектаСобытия) Тогда
		ТекущиеДанные.ОбъектСобытия = ТекущиеДанные.НаименованиеОбъектаСобытия;
	Иначе
		ТекущиеДанные.ОбъектСобытия = "";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)

	Если ПустаяСтрока(Объект.Наименование) Тогда
		Если НЕ Объект.УсловияСобытия.Количество() = 0 Тогда
			ПервоеУсловие = Объект.УсловияСобытия[0];
			Объект.Наименование =  "" + ПервоеУсловие.ВидСобытия + " " + ПервоеУсловие.НаименованиеОбъектаСобытия;
		КонецЕсли;

		Если НЕ Объект.ОбъектыСобытия.Количество() = 0 Тогда
			ПервыйОбъект = Объект.ОбъектыСобытия[0];
			Объект.Наименование = СокрЛП(Объект.Наименование + " " + ПервыйОбъект.ОбъектСобытия);
		КонецЕсли;

		Если НЕ Объект.РеакцииНаСобытие.Количество() = 0 Тогда
			ПерваяРеакция = Объект.РеакцииНаСобытие[0];
			Объект.Наименование = СокрЛП(Объект.Наименование + " " + ПерваяРеакция.СпособРеакции);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УсловияСобытияПриИзменении(Элемент)
	глВремяПоследнегоСобытия = ТекущаяДата();
КонецПроцедуры

&НаКлиенте
Процедура ОбъектыСобытияПриИзменении(Элемент)
	глВремяПоследнегоСобытия = ТекущаяДата();
КонецПроцедуры

&НаКлиенте
Процедура РеакцииНаСобытиеПриИзменении(Элемент)
	глВремяПоследнегоСобытия = ТекущаяДата();
КонецПроцедуры
