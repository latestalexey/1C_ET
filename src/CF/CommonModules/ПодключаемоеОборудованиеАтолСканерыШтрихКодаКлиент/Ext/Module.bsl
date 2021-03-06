﻿// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// ПРОГРАММНЫЙ ИНТЕРФЕЙС
// Функция осуществляет подключение устройства.
// 
// Параметры:
//  ОбъектДрайвера   - <*>
//           - ОбъектДрайвера драйвера торгового оборудования.
// 
// Возвращаемое значение:
//  <Булево> - Результат работы функции.
// 
// Функция получает, обрабатывает и перенаправляет на исполнение команду к драйверу
// 
Функция ВыполнитьКоманду(Команда, ВходныеПараметры = Неопределено, ВыходныеПараметры = Неопределено,
                         ОбъектДрайвера, Параметры, ПараметрыПодключения) Экспорт

	Результат = ИСТИНА;

	// Обязательные выходные
	Если ТипЗнч(ВыходныеПараметры) <> Тип("Массив") Тогда
		ВыходныеПараметры = Новый Массив();
	КонецЕсли;

	// Обработка события от устройства
	Если Команда = "ОбработатьСобытие" Тогда
		Событие = ВходныеПараметры[0];
		Данные  = ВходныеПараметры[1];

		Результат = ОбработатьСобытие(ОбъектДрайвера, Параметры, ПараметрыПодключения, Событие, Данные, ВыходныеПараметры);

	// Завершение обработки события от устройства
	ИначеЕсли Команда = "ЗавершитьОбработкуСобытия" Тогда
		Результат = ЗавершитьОбработкуСобытия(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Получение версии драйвера
	ИначеЕсли Команда = "ПолучитьВерсиюДрайвера" Тогда
		Результат = ПолучитьВерсиюДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Указанная команда не поддерживается данным драйвером
	Иначе
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Команда") + " ""%Команда%"" " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("не поддерживается данным драйвером."));
		ВыходныеПараметры[1] = СтрЗаменить(ВыходныеПараметры[1], "%Команда%", Команда);

		Результат = ЛОЖЬ;
	КонецЕсли;

	Возврат Результат;

КонецФункции

// Процедура вызывается, когда система готова принять следующее событие от устройства.
Функция ЗавершитьОбработкуСобытия(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = ИСТИНА;

	Попытка
		ОбъектДрайвера.НомерТекущегоУстройства = ПараметрыПодключения.ИДУстройства;
		ОбъектДрайвера.ПосылкаДанных = 1;
	Исключение
		ОбъектДрайвера.ОписаниеОшибки = ОбъектДрайвера.ОписаниеРезультата;
		Результат = ЛОЖЬ;
	КонецПопытки;

	Возврат Результат;

КонецФункции

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
// Функция осуществляет обработку внешних событий торгового оборудования.
// 
Функция ОбработатьСобытие(ОбъектДрайвера, Параметры, ПараметрыПодключения, Событие, Данные, ВыходныеПараметры)

	Результат = ИСТИНА;
	ШК        = "";

	Попытка
		ОбъектДрайвера.НомерТекущегоУстройства = ПараметрыПодключения.ИДУстройства;
		ОбъектДрайвера.ПосылкаДанных  = 0;
		ОбъектДрайвера.НомерСообщения = Число(Данные);

		ШК = СокрЛП(ОбъектДрайвера.Данные);
	Исключение
		ОбъектДрайвера.ОписаниеОшибки = ОбъектДрайвера.ОписаниеРезультата;
		Результат = ЛОЖЬ;
	КонецПопытки;

	ВыходныеПараметры.Добавить("ScanData");
	ВыходныеПараметры.Добавить(Новый Массив());
	ВыходныеПараметры[1].Добавить(ШК);
	ВыходныеПараметры[1].Добавить(Новый Массив);
	ВыходныеПараметры[1][1].Добавить(ШК);
	ВыходныеПараметры[1][1].Добавить(ШК);
	ВыходныеПараметры[1][1].Добавить(0);

	Возврат Результат;

КонецФункции

// Функция осуществляет отключение устройства.
// 
// Параметры:
//  ОбъектДрайвера - <*>
//         - ОбъектДрайвера драйвера торгового оборудования.
// 
// Возвращаемое значение:
//  <Булево> - Результат работы функции.
// 
Функция ОтключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры) Экспорт

	Результат = ИСТИНА;

	ОбъектДрайвера.НомерТекущегоУстройства = ПараметрыПодключения.ИДУстройства;
	ОбъектДрайвера.УстройствоВключено = 0;
	ОбъектДрайвера.УдалитьУстройство();

	Возврат Результат;

КонецФункции

Функция ПодключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры) Экспорт

	Результат = ИСТИНА;

	// Обязательные выходные
	Если ТипЗнч(ВыходныеПараметры) <> Тип("Массив") Тогда
		ВыходныеПараметры = Новый Массив();
	КонецЕсли;

	// Проверка настроенных параметров
	Порт              = Неопределено;
	Скорость          = Неопределено;
	БитДанных         = Неопределено;
	СтопБит           = Неопределено;
	Четность          = Неопределено;
	Чувствительность  = Неопределено;
	Префикс           = Неопределено;
	Суффикс           = Неопределено;
	Модель            = Неопределено;

	Параметры.Свойство("Порт"            , Порт);
	Параметры.Свойство("Скорость"        , Скорость);
	Параметры.Свойство("БитДанных"       , БитДанных);
	Параметры.Свойство("СтопБит"         , СтопБит);
	Параметры.Свойство("Четность"        , Четность);
	Параметры.Свойство("Чувствительность", Чувствительность);
	Параметры.Свойство("Префикс"         , Префикс);
	Параметры.Свойство("Суффикс"         , Суффикс);
	Параметры.Свойство("Модель"          , Модель);

	Если Порт              = Неопределено
	 Или Скорость          = Неопределено
	 Или БитДанных         = Неопределено
	 Или СтопБит           = Неопределено
	 Или Четность          = Неопределено
	 Или Чувствительность  = Неопределено
	 Или Префикс           = Неопределено
	 Или Суффикс           = Неопределено
	 Или Модель            = Неопределено Тогда
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не настроены параметры устройства.") + Символы.ПС +
		ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Для корректной работы устройства необходимо задать параметры его работы.") + Символы.ПС +
		ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Сделать это можно при помощи формы") + " """ + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Настройка параметров") +""" "+ ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("модели") + символы.ПС +
		ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("подключаемого оборудования в форме") + " """ + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Подключение и настройка оборудования") + """.");

		Результат = ЛОЖЬ;
	КонецЕсли;
	// Конец: Проверка настроенных параметров

	Если Результат Тогда
		ВыходныеПараметры.Добавить("BarCodeScaner");
		ВыходныеПараметры.Добавить(Новый Массив());
		ВыходныеПараметры[1].Добавить("BarCodeValue");

		ПрефиксДрайвера = "";
		СуффиксДрайвера = "";

		ОбъектДрайвера.ДобавитьУстройство();
		Если ОбъектДрайвера.Результат = 0 Тогда
			ПараметрыПодключения.Вставить("ИДУстройства", ОбъектДрайвера.НомерТекущегоУстройства);
			ОбъектДрайвера.НаименованиеТекущегоУстройства = Параметры.Модель;

			ОбъектДрайвера.НомерПорта       = Параметры.Порт;
			ОбъектДрайвера.СкоростьОбмена   = Параметры.Скорость;
			ОбъектДрайвера.Четность         = Параметры.Четность;
			ОбъектДрайвера.БитыДанных       = Параметры.БитДанных;
			ОбъектДрайвера.СтопБиты         = Параметры.СтопБит;
			ОбъектДрайвера.Чувствительность = Параметры.Чувствительность;
			ОбъектДрайвера.Модель           = 0;
			ОбъектДрайвера.СтараяВерсия     = 0;

			ПрефиксДрайвера = Параметры.Префикс;
			СуффиксДрайвера = Параметры.Суффикс;

			ТекПрефикс = СтрЗаменить(ПрефиксДрайвера, "#", Символы.ПС);
			КоличествоСимволов = СтрЧислоСтрок(ТекПрефикс);
			ПрефиксДрайвера = "";
			Для Тмп = 2 По КоличествоСимволов Цикл
				ПрефиксДрайвера = ПрефиксДрайвера + Символ(Число(СтрПолучитьСтроку(ТекПрефикс, Тмп)));
			КонецЦикла;

			ТекСуффикс = СтрЗаменить(СуффиксДрайвера, "#", Символы.ПС);
			КоличествоСимволов = СтрЧислоСтрок(ТекСуффикс);
			СуффиксДрайвера = "";
			Для Тмп = 2 По КоличествоСимволов Цикл
				СуффиксДрайвера = СуффиксДрайвера + Символ(Число(СтрПолучитьСтроку(ТекСуффикс, Тмп)));
			КонецЦикла;

			ОбъектДрайвера.Префикс = ПрефиксДрайвера;
			ОбъектДрайвера.Суффикс = СуффиксДрайвера;
		Иначе
			Результат = ЛОЖЬ;
			ОбъектДрайвера.ОписаниеОшибки = ОбъектДрайвера.ОписаниеРезультата;
		КонецЕсли;

		Если Результат Тогда
			ОбъектДрайвера.УстройствоВключено = 1;
			Если ОбъектДрайвера.Результат <> 0 Тогда
				Результат = ЛОЖЬ;

				ВыходныеПараметры.Очистить();
				ВыходныеПараметры.Добавить(999);
				ВыходныеПараметры.Добавить(ОбъектДрайвера.ОписаниеРезультата);

				ОбъектДрайвера.УстройствоВключено = 0;
				ОбъектДрайвера.УдалитьУстройство();
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;

КонецФункции

// Функция возвращает версию установленного драйвера
// 
Функция ПолучитьВерсиюДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = ИСТИНА;

	ВыходныеПараметры.Добавить(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Установлен"));
	ВыходныеПараметры.Добавить(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не определена"));

	Попытка
		ВыходныеПараметры[1] = ОбъектДрайвера.Версия;
	Исключение
	КонецПопытки;

	Возврат Результат;

КонецФункции



