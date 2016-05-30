﻿//sza131203-0420 SZA: 
//sza130909-2142 : 

Процедура ПечатьДокумента(ТабДок, Ссылка) Экспорт
	
	Макет = Документы.ДвиженияДенег.ПолучитьМакет("Печать");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ДвиженияДенег.Дата,
	|	ДвиженияДенег.КлиентПоставщик,
	|	ДвиженияДенег.ПриходДенег,
	|	ДвиженияДенег.Статья,
	|	ДвиженияДенег.Сумма,
	|	ДвиженияДенег.ФормаОплаты,
	|	ДвиженияДенег.Комментарий,
	|	ДвиженияДенег.Валюта,
	|	ДвиженияДенег.ОбменВалют,
	|	ДвиженияДенег.Курс,
	|	ДвиженияДенег.СуммаОбмена,
	|	ДвиженияДенег.ВалютаОбмена,
	|	ДвиженияДенег.КурсОбмена,
	|	ДвиженияДенег.Ответственный,
	|	ДвиженияДенег.ДатаСоздания,
	|	ДвиженияДенег.ДатаРедакции,
	|	ДвиженияДенег.НачислениеИВыплатаЗаработнойПлаты,
	|	ДвиженияДенег.Платежи.(
	|		Ссылка,
	|		НомерСтроки,
	|		ПриходИлиРасход,
	|		Сумма,
	|		Валюта,
	|		Курс,
	|		Статья,
	|		ФормаОплаты,
	|		ХранилищеДенег,
	|		Заказ
	|	),
	|	ДвиженияДенег.Зарплата.(
	|		Ссылка,
	|		НомерСтроки,
	|		Сотрудник,
	|		ВидНачисления,
	|		Размер,
	|		Количество,
	|		СуммаНачисления,
	|		ВалютаНачисления,
	|		Курс,
	|		Сумма,
	|		Валюта,
	|		ДатаНачала,
	|		ДатаОкончания,
	|		КлиентПоставщик,
	|		Комментарий,
	|		ХранилищеДенег
	|	),
	|	ДвиженияДенег.Организация,
	|	ДвиженияДенег.Договор,
	|	ДвиженияДенег.ХранилищеДенег,
	|	ДвиженияДенег.Заказ
	|ИЗ
	|	Документ.ДвиженияДенег КАК ДвиженияДенег
	|ГДЕ
	|	ДвиженияДенег.Ссылка В(&Ссылка)";
	
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ТабДок.Очистить();
	ОбластьПШ = Макет.ПолучитьОбласть("Ш");
	ОбластьПС = Макет.ПолучитьОбласть("С");
	
	ВставлятьРазделительСтраниц = Ложь;
	
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		Если ОбщийМодульПовтор.ПолучитьПараметрСеанса("ВестиУчетСобственныхЮридическихЛицПС")
			и ЗначениеЗаполнено(Выборка.Организация) Тогда
			
			ОбщийМодульСервер.ДобавитьШапкуОрганизации(ТабДок, Выборка.Организация);
		КонецЕсли;
		
		Если Выборка.НачислениеИВыплатаЗаработнойПлаты Тогда 			
			ИмяДокумента = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Начисление, расчет и выдача Заработной платы")
		Иначе
			
			Если Выборка.ОбменВалют Тогда
				ИмяДокумента = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обмен валют");
				ТекстОбменВалют = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("на") + " " + Выборка.СуммаОбмена + " " + Выборка.ВалютаОбмена;
			Иначе			
				ИмяДокумента = ?(Выборка.ПриходДенег, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поступление денег"), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Расход денег"));
				ТекстОбменВалют = "";
			КонецЕсли;	
		КонецЕсли;
		
		ОбластьЗаголовок.Параметры.ИмяДокумента = ИмяДокумента;
		ТабДок.Вывести(ОбластьЗаголовок);
		
		Шапка.Параметры.Заполнить(Выборка);
		Если ЗначениеЗаполнено(Выборка.КлиентПоставщик) Тогда
			Если ТипЗнч(Выборка.КлиентПоставщик) = Тип("СправочникСсылка.Клиенты") Тогда
				Шапка.Параметры.КлиентЗаголовок  = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Клиент:");
			Иначе
				Шапка.Параметры.КлиентЗаголовок  = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поставщик:");
			КонецЕсли;
			
			Если не Выборка.КлиентПоставщик.НаименованиеДляПечати = "" Тогда
				Шапка.Параметры.КлиентПоставщик = Выборка.КлиентПоставщик.НаименованиеДляПечати;	
			КонецЕсли;
			
		иначе
			Шапка.Параметры.КлиентПоставщик  = "";
			Шапка.Параметры.КлиентЗаголовок  = "";
		КонецЕсли;
		
		Если НЕ ОбщийМодульПовтор.получитьЗначениеНастройкиИлиКонстанты("ВестиУчетВалют") Тогда
			Шапка.Параметры.Валюта = "";
		КонецЕсли;
		
		Шапка.Параметры.ТекстОбменВалют = ТекстОбменВалют;
		
		СтруктураДополнительныПараметровМакета = ОбщийМодульСервер.ПолучитьСтруктуруДополнительныхПараметровМакетаПечати();
		Если НЕ ОбщийМодульПовтор.ПолучитьПараметрСеанса("ВестиУчетСобственныхЮридическихЛицПС")
			или не ЗначениеЗаполнено(Выборка.Организация) Тогда
			
			Шапка.Параметры.ТекстВШапкеДокументовПриПечати = СтруктураДополнительныПараметровМакета.ТекстВШапкеДокументовПриПечати;	
		иначе
			Шапка.Параметры.ТекстВШапкеДокументовПриПечати = "";
		КонецЕсли;
		Шапка.Параметры.ТекстВПодвалеДокументовПриПечати = СтруктураДополнительныПараметровМакета.ТекстВПодвалеДокументовПриПечати;
		
		ХранилищеДенег = Выборка.ХранилищеДенег;
		Если ЗначениеЗаполнено(ХранилищеДенег) Тогда
			Шапка.Параметры.ФормаОплаты = ХранилищеДенег;
		КонецЕсли;
		
		ТабДок.Вывести(Шапка, Выборка.Уровень());
		
		ВыборкаС = Выборка.платежи.Выбрать();
		Если НЕ ВыборкаС.количество() = 0 Тогда
			ТабДок.Вывести(ОбластьПШ);
			
			Пока ВыборкаС.Следующий() Цикл
				
				ОбластьПС.Параметры.Заполнить(ВыборкаС);
				ХранилищеДенег = ВыборкаС.ХранилищеДенег;
				Если ЗначениеЗаполнено(ХранилищеДенег) Тогда
					ОбластьПС.Параметры.ФормаОплаты = ХранилищеДенег;
				КонецЕсли;
				
				ТабДок.Вывести(ОбластьПС, ВыборкаС.Уровень());
			КонецЦикла;
		КонецЕсли;
		
		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	
КонецПроцедуры

Процедура Ведомость(ТабДок, Ссылка) Экспорт
	
	Макет = Документы.ДвиженияДенег.ПолучитьМакет("Ведомость");
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ДвиженияДенег.Дата,
	|	ДвиженияДенег.Комментарий,
	|	ДвиженияДенег.Номер,
	|	ДвиженияДенег.Сумма,
	|	ДвиженияДенег.ФормаОплаты,
	|	ДвиженияДенег.Зарплата.(
	|		Ссылка,
	|		НомерСтроки,
	|		Сотрудник,
	|		ВидНачисления,
	|		Размер,
	|		Количество,
	|		СуммаНачисления,
	|		ВалютаНачисления,
	|		Курс,
	|		Сумма,
	|		Валюта,
	|		ДатаНачала,
	|		ДатаОкончания,
	|		Комментарий,
	|		ХранилищеДенег
	|	),
	|	ДвиженияДенег.ХранилищеДенег
	|ИЗ
	|	Документ.ДвиженияДенег КАК ДвиженияДенег
	|ГДЕ
	|	ДвиженияДенег.Ссылка В(&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	
	ОбластьЗаголовок 	= Макет.ПолучитьОбласть("Заголовок");
	Шапка 				= Макет.ПолучитьОбласть("Шапка");
	ОбластьШС 			= Макет.ПолучитьОбласть("ШС");
	ОбластьС 			= Макет.ПолучитьОбласть("С");
	Подвал 				= Макет.ПолучитьОбласть("Подвал");
	ОбластьЗарплата 	= Макет.ПолучитьОбласть("Зарплата");
	ОбластьЗарплатаШапка = Макет.ПолучитьОбласть("ЗарплатаШапка");
	ТабДок.Очистить();
	
	ОсновнаяВалюта = Справочники.Валюты.ОсновнаяВалюта ;
	СтруктураДополнительныПараметровМакета 				= ОбщийМодульСервер.ПолучитьСтруктуруДополнительныхПараметровМакетаПечати();
	Шапка.Параметры.ТекстВШапкеДокументовПриПечати   	= СтруктураДополнительныПараметровМакета.ТекстВШапкеДокументовПриПечати;
	Подвал.Параметры.ТекстВПодвалеДокументовПриПечати 	= СтруктураДополнительныПараметровМакета.ТекстВПодвалеДокументовПриПечати;
	
	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ТабДок.Вывести(ОбластьЗаголовок);
		
		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());
		
		ТабДок.Вывести(ОбластьЗарплатаШапка);
		
		ТаблицаПоСотрудникам = новый ТаблицаЗначений;
		ТаблицаПоСотрудникам.колонки.Добавить("Сотрудник");
		ТаблицаПоСотрудникам.колонки.Добавить("СуммаНачисления");
		ТаблицаПоСотрудникам.колонки.Добавить("Сумма");
		
		ВыборкаЗарплата = Выборка.Зарплата.Выбрать();
		Пока ВыборкаЗарплата.Следующий() Цикл
			ОбластьЗарплата.Параметры.Заполнить(ВыборкаЗарплата);
			ТабДок.Вывести(ОбластьЗарплата, ВыборкаЗарплата.Уровень());
			
			строкапосотруднику = ТаблицаПоСотрудникам.Добавить();
			строкапосотруднику.сотрудник 		= ВыборкаЗарплата.сотрудник;
			строкапосотруднику.СуммаНачисления 	= ОбщийМодульСервер.ПоКурсу(ВыборкаЗарплата.СуммаНачисления, , ВыборкаЗарплата.ВалютаНачисления, Выборка.Дата);
			строкапосотруднику.Сумма 			= ОбщийМодульСервер.ПоКурсу(ВыборкаЗарплата.Сумма, , ВыборкаЗарплата.Валюта, Выборка.Дата);
		КонецЦикла;		
		
		если не ТаблицаПоСотрудникам.Количество() = 0 тогда
			
			ТаблицаПоСотрудникам.Свернуть("Сотрудник", "СуммаНачисления, Сумма");
			ТаблицаПоСотрудникам.Сортировать("Сотрудник");
			
			ТаблицаПоСотрудникам.колонки.Добавить("Остаток");
			
			областьШС.Параметры.ОсновнаяВалюта = ОсновнаяВалюта;
			ТабДок.Вывести(областьШС);                         	
			
			для каждого строкапосотруднику из ТаблицаПоСотрудникам цикл
				строкапосотруднику.остаток = строкапосотруднику.СуммаНачисления - строкапосотруднику.Сумма;
				ОбластьС.Параметры.Заполнить(строкапосотруднику);
				ТабДок.Вывести(ОбластьС);
			КонецЦикла;
		КонецЕсли;
		
		Подвал.Параметры.Заполнить(Выборка);
		Подвал.Параметры.валюта = ОсновнаяВалюта;
		Если ЗначениеЗаполнено(Выборка.ХранилищеДенег) Тогда
			Подвал.Параметры.ФормаОплаты = Выборка.ХранилищеДенег;
		КонецЕсли;		
		ТабДок.Вывести(Подвал);
		
		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	
КонецПроцедуры
