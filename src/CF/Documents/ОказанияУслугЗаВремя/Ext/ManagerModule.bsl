﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza140722-0105 склад
// sza140305-1713
Процедура НаПечать(ДокументДляПечати, Ссылка) Экспорт

	ДокументДляПечати.ИмяПараметровПечати  = "докОказаниеУслугЗаВремя" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();
	СсылкаНаОбъектПечати = Ссылка[0];

	РазрядМетаданных = ""; ИмяМетаданных = "";
	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(, , СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Если ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		ДокументДляПечати = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ДокументДляПечати, СсылкаНаОбъектПечати, РазрядМетаданных, ИмяМетаданных);
	Иначе
		Макет = Документы.ОказанияУслугЗаВремя.ПолучитьМакет("НаПечать");
		ЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов(ССылка[0].Клиент, , ЛОЖЬ);
		Макет.КодЯзыкаМакета = ЯзыкаМакета.Код;

		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	ОказанияУслугЗаВремя.Валюта,
		|	ОказанияУслугЗаВремя.ВидЦен,
		|	ОказанияУслугЗаВремя.Дата,
		|	ОказанияУслугЗаВремя.ДатаНачалаОказанияУслуг,
		|	ОказанияУслугЗаВремя.ДатаОкончанияОказанияУслуг,
		|	ОказанияУслугЗаВремя.ДатаРедакции,
		|	ОказанияУслугЗаВремя.ДатаСоздания,
		|	ОказанияУслугЗаВремя.Договор,
		|	ОказанияУслугЗаВремя.Клиент,
		|	ВЫРАЗИТЬ(ОказанияУслугЗаВремя.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
		|	ОказанияУслугЗаВремя.Курс,
		|	ОказанияУслугЗаВремя.Номенклатура,
		|	ОказанияУслугЗаВремя.Номер,
		|	ОказанияУслугЗаВремя.Организация,
		|	ОказанияУслугЗаВремя.Ответственный,
		|	ОказанияУслугЗаВремя.ОткрыватьНовыйДокументОказанияУслугПриЗавершении,
		|	ОказанияУслугЗаВремя.ПоступилоДенег,
		|	ОказанияУслугЗаВремя.ПроцентСкидки,
		|	ОказанияУслугЗаВремя.Сотрудник,
		|	ОказанияУслугЗаВремя.СуммаБезСкидки,
		|	ОказанияУслугЗаВремя.ТовараВКоличестве,
		|	ОказанияУслугЗаВремя.ТовараНаСумму,
		|	ОказанияУслугЗаВремя.УслугаОказана,
		|	ОказанияУслугЗаВремя.ФормаОплаты,
		|	ОказанияУслугЗаВремя.ХранилищеДенег,
		|	ОказанияУслугЗаВремя.Цена,
		|	ОказанияУслугЗаВремя.ПредметСделки,
		|	ОказанияУслугЗаВремя.Склад
		|ИЗ Документ.ОказанияУслугЗаВремя КАК ОказанияУслугЗаВремя
		|ГДЕ ОказанияУслугЗаВремя.Ссылка В(&Ссылка)";
		Запрос.Параметры.Вставить("Ссылка", Ссылка);

		Выборка = Запрос.Выполнить().Выбрать();
		ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
		Шапка = Макет.ПолучитьОбласть("Шапка");
		ВставлятьРазделительСтраниц = ЛОЖЬ;

		Пока Выборка.Следующий() Цикл
			Если ВставлятьРазделительСтраниц Тогда
				ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;

			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
			ДокументДляПечати.Вывести(ОбластьЗаголовок);
			Шапка.Параметры.Заполнить(Выборка);
			Шапка.Параметры.ПредставлениеНоменклатуры = ОбщийМодульТекстСервер.ПолучитьОбщееНаименование(Выборка.Номенклатура, ЯзыкаМакета, Выборка.Клиент);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
			ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());

			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьТекстовоеПолеПредметСделки")
				И НЕ ПустаяСтрока(Выборка.ПредметСделки) Тогда

				ПредметСделки = Макет.ПолучитьОбласть("ПредметСделки");
				ПредметСделки.Параметры.Заполнить(Выборка);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ПредметСделки);
				ДокументДляПечати.Вывести(ПредметСделки);
			КонецЕсли;

			ВставлятьРазделительСтраниц = ИСТИНА;

		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
