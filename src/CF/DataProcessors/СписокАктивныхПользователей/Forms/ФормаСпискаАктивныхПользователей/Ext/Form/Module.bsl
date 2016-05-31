﻿// sza160208-0059
// sza150117-0434 Админ:
// процедура заполняет список активных пользователей, устанавливает текущую строку

&НаКлиенте
Процедура ЗаполнитьСписок()

	ТекущийСеанс = Неопределено;
	ТекущиеДанные = Элементы.СписокПользователей.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ТекущийСеанс = ТекущиеДанные.Сеанс;
	КонецЕсли;

	ЗаполнитьСписокПользователей();

	Если ТекущийСеанс <> Неопределено Тогда
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("Сеанс", ТекущийСеанс);
		НайденныеСеансы = СписокПользователей.НайтиСтроки(СтруктураПоиска);

		Если НайденныеСеансы.Количество() = 1 Тогда
			Элементы.СписокПользователей.ТекущаяСтрока = НайденныеСеансы[0].ПолучитьИдентификатор();
			Элементы.СписокПользователей.ВыделенныеСтроки.Очистить();
			Элементы.СписокПользователей.ВыделенныеСтроки.Добавить(Элементы.СписокПользователей.ТекущаяСтрока);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокПользователей()

	ТЗСписокПользователей = РеквизитФормыВЗначение("СписокПользователей");
	ТЗСписокПользователей.Очистить();
	СеансыИБ = ПолучитьСеансыИнформационнойБазы();
	Если СеансыИБ <> Неопределено Тогда
		Для каждого СеансИБ Из СеансыИБ Цикл

			РолиПользователя = "";
			СтрПользователя = ТЗСписокПользователей.Добавить();
			Если ТипЗнч(СеансИБ.Пользователь) = Тип("ПользовательИнформационнойБазы") Тогда
				СтрПользователя.Пользователь = СеансИБ.Пользователь.Имя;
				СтрПользователя.ИмяПользователя = СеансИБ.Пользователь.Имя;
			КонецЕсли;

			СтрПользователя.Приложение   = ПредставлениеПриложения(СеансИБ.ИмяПриложения);
			СтрПользователя.НачалоРаботы = СеансИБ.НачалоСеанса;
			СтрПользователя.Компьютер    = СеансИБ.ИмяКомпьютера;
			СтрПользователя.Сеанс        = СеансИБ.НомерСеанса;

			Если СеансИБ.НомерСеанса = НомерСеансаИнформационнойБазы() Тогда
				СтрПользователя.НомерРисункаПользователя = 0;
			Иначе
				СтрПользователя.НомерРисункаПользователя = 1;
			КонецЕсли;

			Для Каждого РольПользователя Из СеансИБ.Пользователь.Роли Цикл
				РолиПользователя = РолиПользователя + ?(ПустаяСтрока(РолиПользователя), "", ", ") + СокрЛП(РольПользователя);
			КонецЦикла;

			СтрПользователя.РолиПользователя = РолиПользователя;

		КонецЦикла;
	КонецЕсли;

	КоличествоАктивныхПользователей = СеансыИБ.Количество();
	ТЗСписокПользователей.Сортировать(ИмяКолонкиСортировки + " " + НаправлениеСортировки);
	ЗначениеВРеквизитФормы(ТЗСписокПользователей, "СписокПользователей");

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВыполнить()
	ЗаполнитьСписок();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьЖурналРегистрации()
	ЖурналРегистрации = ОткрытьФорму("Обработка.ЖурналРегистрации.Форма");
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьЖурналРегистрацииПоПользователю()

	ТекущиеДанные = Элементы.СписокПользователей.ТекущиеДанные;

	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ОткрытьФорму("Обработка.ЖурналРегистрации.Форма", Новый Структура("Пользователь", СокрЛП(ТекущиеДанные.Пользователь)));

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

	ИмяКолонкиСортировки = "НачалоРаботы";
	НаправлениеСортировки = "Возр";
	ЗаполнитьСписокПользователей();

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СортироватьПоВозрастанию()
	СортировкаПоКолонке("Возр");
КонецПроцедуры

&НаКлиенте
Процедура СортироватьПоУбыванию()
	СортировкаПоКолонке("Убыв");
КонецПроцедуры

&НаКлиенте
Процедура СортировкаПоКолонке(Направление)

	Колонка = Элементы.СписокПользователей.ТекущийЭлемент;

	Если Колонка = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ИмяКолонкиСортировки = Колонка.Имя;
	НаправлениеСортировки = Направление;
	ЗаполнитьСписок();

КонецПроцедуры
