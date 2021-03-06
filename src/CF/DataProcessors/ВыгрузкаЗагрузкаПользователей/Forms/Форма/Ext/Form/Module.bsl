﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ФайлВыгрузки = "IBUsers.xml";
	ФайлЗагрузки = "IBUsers.xml";
	ПриоритетФайла = Ложь;
	ФормироватьПротокол = Истина;

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
	КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

#Если ВебКлиент Тогда
	// В веб-клиенте оставим только имена файлов
	ФайлВыгрузки = "IBUsers.xml";
	ФайлЗагрузки = "IBUsers.xml";
	// и уберем поля для предварительного выбора файлов, т.к. будут использоваться интерактивные методы
	Элементы.ФайлВыгрузки.Видимость = Ложь;
	Элементы.ФайлЗагрузки.Видимость = Ложь;
#КонецЕсли
ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);

КонецПроцедуры

#Область ВыгрузкаПользователей
&НаСервере
Функция ВыгрузитьПользователейНаСервере()

	Обработка = РеквизитФормыВЗначение("Объект");

	Возврат Обработка.ВыгрузитьПользователей();

КонецФункции

&НаКлиенте
Процедура ВыгрузитьПользователей(Команда)

	Состояние(НСтр("ru = 'Выполняется выгрузка списка пользователей...'", "ru"));
	Результат = ВыгрузитьПользователейНаСервере();
	Если НЕ Результат.Статус Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'При выполнении выгрузки пользователей произошла ошибка.'", "ru"));

		Возврат;
	КонецЕсли;

	Если ПодключитьРасширениеРаботыСФайлами() Тогда
		Получаемые = Новый Массив;
		ПолучаемыйФайл = Новый ОписаниеПередаваемогоФайла;
		ПолучаемыйФайл.Имя = ФайлВыгрузки;
		ПолучаемыйФайл.Хранение = Результат.Адрес;
		Получаемые.Добавить(ПолучаемыйФайл);
		Полученные = Новый Массив;

		Если ПолучитьФайлы(Получаемые, Полученные, "", Ложь) Тогда
			ПоказатьПредупреждение(, НСтр("ru='Выгрузка завершена успешно. Выгружено пользователей: " + Результат.Количество + "'", "ru"));
		КонецЕсли;
	Иначе
		ПолучитьФайл(Результат.Адрес, ФайлВыгрузки, Истина);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ФайлВыгрузкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбора.Заголовок = НСтр("ru = 'Укажите файл для сохранения списка пользователей'", "ru");
	ДиалогВыбора.ПроверятьСуществованиеФайла = Ложь;
	ДиалогВыбора.ПолноеИмяФайла = ФайлВыгрузки;
	ДиалогВыбора.Фильтр = НСтр("ru = 'XML-файлы|*.xml|Все файлы|" + ПолучитьМаскуВсеФайлыКлиента() + "'", "ru");
	Результат = ДиалогВыбора.Выбрать();

	Если Результат Тогда
		ФайлВыгрузки = ДиалогВыбора.ПолноеИмяФайла;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
#Область ЗагрузкаПользователей
&НаСервере
Функция ЗагрузитьПользователейНаСервере(Адрес)

	Обработка = РеквизитФормыВЗначение("Объект");

	Возврат Обработка.ЗагрузитьПользователей(Адрес, ПриоритетФайла, ФормироватьПротокол);

КонецФункции

&НаКлиенте
Процедура ЗагрузитьПользователей(Команда)

	ИмяПротокола = "IBUsers_log.txt";
	Адрес = "";
	ОбратныйВызов = Новый ОписаниеОповещения("ЗагрузитьПользователейЗавершение", ЭтотОбъект, ИмяПротокола);
#Если ВебКлиент Тогда
	НачатьПомещениеФайла(ОбратныйВызов, Адрес, "", Истина);
#Иначе
	НачатьПомещениеФайла(ОбратныйВызов, Адрес, ФайлЗагрузки, Ложь);
#КонецЕсли

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьПользователейЗавершение(Результат, Адрес, ВыбранноеИмяФайла, ИмяПротокола) Экспорт

	Если Результат Тогда
		Состояние(НСтр("ru = 'Выполняется загрузка пользователей информационной базы...'", "ru"));
		Результат = ЗагрузитьПользователейНаСервере(Адрес);
		Если Результат.Статус = Ложь Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'При выполнении загрузки пользователей произошла ошибка.'", "ru"));

			Возврат;
		КонецЕсли;

		Если ФормироватьПротокол Тогда
			ПолучитьФайл(Результат.ФайлПротокола, ИмяПротокола, Истина);
		Иначе
			Текст = НСтр("ru = 'Загрузка пользователей завершена. Всего прочитано: %1. Загружено: %2. Совпадений: %3.'", "ru");
			Текст = СтрЗаменить(Текст, "%1", Результат.ИзФайла);
			Текст = СтрЗаменить(Текст, "%2", Результат.Загружено);
			Текст = СтрЗаменить(Текст, "%3", Результат.Совпадений);
			ПоказатьПредупреждение(, Текст);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ФайлЗагрузкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ДиалогВыбора = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбора.Заголовок = НСтр("ru = 'Укажите файл для загрузки списка пользователей'", "ru");
	ДиалогВыбора.ПолноеИмяФайла = ФайлЗагрузки;
	ДиалогВыбора.Фильтр = НСтр("ru = 'XML-файлы|*.xml|Все файлы|" + ПолучитьМаскуВсеФайлыКлиента() + "'", "ru");
	Результат = ДиалогВыбора.Выбрать();

	Если Результат Тогда
		ФайлЗагрузки = ДиалогВыбора.ПолноеИмяФайла;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

#КонецОбласти
