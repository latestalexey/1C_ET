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
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
// Функция осуществляет вывод списка строк на дисплей покупателя.
// 
Функция ВывестиСтрокуНаДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, СтрокаТекста, ВыходныеПараметры)

	Результат = ИСТИНА;

	МассивСтрок = Новый Массив();
	МассивСтрок.Добавить(СтрПолучитьСтроку(СтрокаТекста, Параметры.ОтображатьНаДисплее));

	Ответ = ОбъектДрайвера.ВывестиСтрокуНаДисплейПокупателя(ПараметрыПодключения.ИДУстройства, МассивСтрок);
	Если НЕ Ответ Тогда
		Результат = ЛОЖЬ;
		ОбъектДрайвера.ПолучитьОшибку(ОбъектДрайвера.ОписаниеОшибки);
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(ОбъектДрайвера.ОписаниеОшибки);
	КонецЕсли;

	Возврат Результат;
	
КонецФункции

// Функция получает, обрабатывает и перенаправляет на исполнение команду к драйверу
// 
Функция ВыполнитьКоманду(Команда, ВходныеПараметры = Неопределено, ВыходныеПараметры = Неопределено,
                         ОбъектДрайвера, Параметры, ПараметрыПодключения) Экспорт

	Результат = ИСТИНА;

	ВыходныеПараметры = Новый Массив();

	// Вывод строк на дисплей
	Если Команда = "ВывестиСтрокуНаДисплейПокупателя" ИЛИ Команда = "DisplayText" Тогда
		СтрокаТекста = ВходныеПараметры[0];
		Результат = ВывестиСтрокуНаДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, СтрокаТекста, ВыходныеПараметры);

	// Очистка дисплея
	ИначеЕсли Команда = "ОчиститьДисплейПокупателя" ИЛИ Команда = "ClearText" Тогда
		Результат = ОчиститьДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Тестирование устройства
	ИначеЕсли Команда = "ТестУстройства" ИЛИ Команда = "CheckHealth" Тогда
		Результат = ТестУстройства(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Получить параметры вывода
	ИначеЕсли Команда = "ПолучитьПараметрыВывода" Тогда
		Результат = ПолучитьПараметрыВывода(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Получение версии драйвера
	ИначеЕсли Команда = "ПолучитьВерсиюДрайвера" Тогда
		Результат = ПолучитьВерсиюДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Указанная команда не поддерживается данным драйвером
	Иначе
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Команда ""%Команда%"" не поддерживается данным драйвером.'"));
		ВыходныеПараметры[1] = СтрЗаменить(ВыходныеПараметры[1], "%Команда%", Команда);
		Результат = ЛОЖЬ;

	КонецЕсли;

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

	ВыходныеПараметры = Новый Массив();

	ОбъектДрайвера.Отключить(ПараметрыПодключения.ИДУстройства);

	Возврат Результат;

КонецФункции

// Функция осуществляет очистку дисплея покупателя.
// 
Функция ОчиститьДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = ИСТИНА;

	Ответ = ОбъектДрайвера.ОчиститьДисплейПокупателя(ПараметрыПодключения.ИДУстройства);
	Если НЕ Ответ Тогда
		Результат = ЛОЖЬ;
		ОбъектДрайвера.ПолучитьОшибку(ОбъектДрайвера.ОписаниеОшибки);
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(ОбъектДрайвера.ОписаниеОшибки);
	КонецЕсли;

	Возврат Результат;

КонецФункции

Функция ПодключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры) Экспорт

	Результат = ИСТИНА;
	ВыходныеПараметры = Новый Массив();
	ПараметрыПодключения.Вставить("ИДУстройства", Неопределено);

	// Проверка настроенных параметров
	Порт			= Неопределено;
	Таймаут			= Неопределено;
	КолвоПовторов	= Неопределено;
	Параметры.Свойство("Порт",			Порт);
	Параметры.Свойство("Таймаут",		Таймаут);
	Параметры.Свойство("КолвоПовторов", КолвоПовторов);
	
	Если Порт = Неопределено
		ИЛИ Таймаут = Неопределено
		ИЛИ КолвоПовторов = Неопределено Тогда
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Не настроены параметры устройства.
		|Для корректной работы устройства необходимо задать параметры его работы.
		|Сделать это можно при помощи формы ""Настройка параметров"" модели
		|подключаемого оборудования в форме ""Подключение и настройка оборудования"".'"));

		Результат = ЛОЖЬ;
	КонецЕсли;

	МассивЗначений = Новый Массив;
	МассивЗначений.Добавить(Параметры.Порт);
	МассивЗначений.Добавить(Параметры.Таймаут);
	МассивЗначений.Добавить(Параметры.КолвоПовторов);
	
	Если Результат Тогда
		Ответ = ОбъектДрайвера.Подключить(МассивЗначений, ПараметрыПодключения.ИДУстройства);
		Если НЕ Ответ Тогда
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить(ОбъектДрайвера.ТекстОшибки);
			Результат = ЛОЖЬ;
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;

КонецФункции

// Функция возвращает версию установленного драйвера
// 
Функция ПолучитьВерсиюДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = ИСТИНА;

	ВыходныеПараметры.Добавить(НСтр("ru='Установлен'"));
	ВыходныеПараметры.Добавить(НСтр("ru='Не определена'"));

	Попытка
		ВыходныеПараметры[1] = ОбъектДрайвера.ПолучитьНомерВерсии();
	Исключение
	КонецПопытки;

	Возврат Результат;

КонецФункции

// Функция возвращает параметры вывода на дисплей покупателя)
Функция ПолучитьПараметрыВывода(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = ИСТИНА;
	ВыходныеПараметры.Очистить();  
	ВыходныеПараметры.Добавить(20);
	ВыходныеПараметры.Добавить(2);
		
	Возврат Результат;

КонецФункции

// Функция осуществляет тестирование устройства.
// 
Функция ТестУстройства(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = ИСТИНА;

	Результат = ПодключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
	Если НЕ Результат Тогда
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка при подключении устройства'"));
	Иначе
		СтрокаТекста = НСтр("ru='Наименование товара'")+Символы.ПС+НСтр("ru='Итоговая сумма'");
		Результат = ВывестиСтрокуНаДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, СтрокаТекста, ВыходныеПараметры);
		МенеджерОборудованияКлиент.Пауза(5);
		Если Результат Тогда
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(НСтр("ru='Тест успешно выполнен'"));
		КонецЕсли;
	КонецЕсли;

	ОтключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	Возврат Результат;

КонецФункции



