﻿// sza151214-1935
// sza150623-0015
// sza140827-0034 взять основное значение
// sza140119-1433
// sza131130-0059

&НаКлиенте
Процедура ВзятьОсновноеЗначение(Команда)
	Запись.ЗначениеНастройки = ОсновноеЗначение;
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаСервере()

	ЭтотОбъект1 = ДанныеФормыВзначение(Запись, Тип("РегистрСведенийЗапись.НастройкиПользователей"));
	ЭтотОбъект1.Записать();
	ЗначениеВДанныеФормы(ЭтотОбъект1,  Запись);

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеНастройкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	ОчиститьТипЗначенияНастройки();
	// 	Элементы.ЗначениеНастройки.ОграничениеТипа = Запись.Настройка.ТипЗначения;
	//  Запись.ЗначениеНастройки = Элементы.ЗначениеНастройки.ОграничениеТипа.ПривестиЗначение(Запись.ЗначениеНастройки);
	//  Элементы.ЗначениеНастройки.ВыбиратьТип = ЛОЖЬ;

КонецПроцедуры

&НаКлиенте
Процедура ЗначениеНастройкиОчистка(Элемент, СтандартнаяОбработка)
	ОчиститьТипЗначенияНастройки();
КонецПроцедуры

&НаКлиенте
Процедура ЗначениеНастройкиПриИзменении(Элемент)
	ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Сменил") + " " + Запись.Настройка, 2);
КонецПроцедуры

&НаКлиенте
Процедура КомандаДа(Команда)

	Запись.ЗначениеНастройки = ИСТИНА;

	Если глВерсияПлатформы < 803040000 Тогда ЗаписатьНаСервере(); Иначе Выполнить(" Записать(); "); КонецЕсли;

	ЭтаФорма.Закрыть();

КонецПроцедуры

&НаКлиенте
Процедура КомандаНет(Команда)

	Запись.ЗначениеНастройки = ЛОЖЬ;

	Если глВерсияПлатформы < 803040000 Тогда ЗаписатьНаСервере(); Иначе Выполнить(" Записать(); "); КонецЕсли;

	ЭтаФорма.Закрыть();

КонецПроцедуры

&НаСервере
Процедура ОчиститьТипЗначенияНастройки()

	ОсновноеЗначение = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты(ПланыВидовХарактеристик.НастройкиПользователей.ПолучитьИмяПредопределенного(Запись.Настройка), ИСТИНА);
	Элементы.ЗначениеНастройки.ОграничениеТипа = Запись.Настройка.ТипЗначения;
	Запись.ЗначениеНастройки = Элементы.ЗначениеНастройки.ОграничениеТипа.ПривестиЗначение(Запись.ЗначениеНастройки);
	Элементы.ЗначениеНастройки.ВыбиратьТип = ЛОЖЬ;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)

	Запись.ДатаУстановки = ТекущаяДата();

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	ОбновитьПовторноИспользуемыеЗначения();

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

	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
	КонецЕсли;

	Если ЗначениеЗаполнено(Запись.Настройка) Тогда
		ОчиститьТипЗначенияНастройки();
	КонецЕсли;

	Элементы.ДатаУстановки.Видимость = ЗначениеЗаполнено(Запись.ДатаУстановки);
	Элементы.КнопкиДаНет.Видимость = ТипЗнч(Запись.ЗначениеНастройки) = Тип("Булево");

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
