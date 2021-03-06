﻿// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ
// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // /
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ
&НаКлиенте
Процедура ВыбратьИЗакрыть(Команда)

	Если ЗначениеЗаполнено(РабочееМесто) Тогда
		Параметры.РабочееМесто = РабочееМесто;

		Если МенеджерОборудованияВызовСервера.ПравоДоступаСохранениеДанныхПользователя() Тогда
			СписокНастроек = Новый Структура();
			СписокНастроек.Вставить("ОткрытьФормуВыбораРМПриПервомОбращении", ОткрыватьПриПервомОбращении);
			МенеджерОборудованияКлиент.СохранитьПользовательскиеНастройкиПодключаемогоОборудования(СписокНастроек);
		КонецЕсли;
		
		ОчиститьСообщения();
		
		СтруктураВозврата = Новый Структура("РабочееМесто", РабочееМесто);
		Закрыть(СтруктураВозврата);
		
	Иначе
		
		ОчиститьСообщения();
		ОбщегоНазначения.СообщитьПользователю(НСтр("ru='Выберите рабочее место'"), РабочееМесто, "РабочееМесто");
		
	КонецЕсли;

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
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
		КонецЕсли;
		
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест"
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	РабочееМесто = МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента();

	ОткрыватьПриПервомОбращении = Параметры.ОткрыватьПриПервомОбращении;
	ИдентификаторКлиента        = Параметры.ИдентификаторКлиента;

	// Если передали имя компьютера, то значит необходимо выбрать рабочее место
	// из уже существующего (не пустого) списка рабочих мест
	Если НЕ ПустаяСтрока(ИдентификаторКлиента) Тогда
		НовыйМассив = Новый Массив();
		НовыйМассив.Добавить(Новый ПараметрВыбора("Отбор.ПометкаУдаления", ЛОЖЬ));
		НовыйМассив.Добавить(Новый ПараметрВыбора("Отбор.Код", ИдентификаторКлиента));
		НовыйФиксированныйМассив = Новый ФиксированныйМассив(НовыйМассив);
		Элементы.РабочееМесто.ПараметрыВыбора = НовыйФиксированныйМассив;
	КонецЕсли;
	
	Элементы.ОткрыватьПриПервомОбращении.Доступность = МенеджерОборудованияВызовСервера.ПравоДоступаСохранениеДанныхПользователя();
	
КонецПроцедуры



