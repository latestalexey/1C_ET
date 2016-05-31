﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ УПРАВЛЕНИЯ
// Процедура - обаботчик события, при нажатии на кнопку "ОК" Командной панели "ОсновныеДействияФормы"
//

&НаКлиенте
Процедура ОсновныеДействияФормыОК(Команда)

	ОповеститьОВыборе(Новый Структура("Источник, Результат, Выражение",
		"ФормаРедактированияВыражения", ИСТИНА, ПолеТекстовогоДокумента.ПолучитьТекст()));

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

	НадписьТекстВыражения =
	"В тексте выражения можно использовать следующие предопределенные параметры:
	|   Результат      - результат вычисления (на входе - значение по умолчанию)
	|   ТекстЯчейки    - текст текущей ячейки
	|   ТекстыЯчеек    - массив текстов ячеек строки
	|   ТекущиеДанные  - структура загруженных значений
	|   ОписаниеОшибки - описание ошибки, выводимое в примечание ячейки и в окно сообщений
	|Встроенные функции, функции общих модулей.";

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры
