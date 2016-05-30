﻿//sza140104-0215 : 
//sza131111-0049 : 

Процедура Печать(ТабДок, Ссылка) Экспорт
	
	Макет = Справочники.Склады.ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Склады.ВидЦенРеализацииСЭтогоСклада,
	|	Склады.Код,
	|	Склады.Комментарий,
	|	Склады.Наименование,
	|	Склады.ОбязательныйВидЦенПриПеремещенииНаЭтотСклад,
	|	Склады.ОтветственныйСотрудник,
	|	Склады.СкладПополнения,
	|	Склады.ФормулаТекстаЭтикетки
	|ИЗ
	|	Справочник.Склады КАК Склады
	|ГДЕ
	|	Склады.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;

КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	Если НЕ ОбщийМодульПовтор.ТекущийЯзыкРусский()
		и ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ПоддерживатьНаименованияНаДругихЯзыкахКромеРусского", Истина) Тогда
		
		ВозможноеПредставление = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(Данные.ссылка, , Истина);
		Если НЕ ВозможноеПредставление = Неопределено Тогда
			Представление = ВозможноеПредставление;
			СтандартнаяОбработка = Ложь;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры
