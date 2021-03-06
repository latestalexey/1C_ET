﻿// sza151208-0141 
// sza150505-0407 ППФ
// sza141016-1536
// sza140917-0046
&НаКлиенте
Процедура ПериодДляОтчетаПриИзменении(Элемент)
	
	Отчет.ДатаНачала 	= ПериодДляОтчета.ДатаНачала;
	Отчет.ДатаОкончания = ПериодДляОтчета.ДатаОкончания;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаПриИзменении(Элемент)
	
	ПериодДляОтчета.ДатаНачала = Отчет.ДатаНачала;
	Если Отчет.ДатаОкончания < Отчет.ДатаНачала Тогда
		Отчет.ДатаОкончания = Отчет.ДатаНачала;
		ПериодДляОтчета.ДатаОкончания = Отчет.ДатаОкончания;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаОкончанияПриИзменении(Элемент)
	
	ПериодДляОтчета.ДатаОкончания = Отчет.ДатаОкончания;
	Если Отчет.ДатаОкончания < Отчет.ДатаНачала Тогда
		Отчет.ДатаНачала = Отчет.ДатаОкончания;
		ПериодДляОтчета.ДатаНачала = Отчет.ДатаНачала;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ОпределитьПроизвольнуюПечатнуюФорму();
	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю
	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000605", ЭтаФорма, Отказ, );	
	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);	
		КонецЕсли;
		
		ИспользоватьПроизвольныеПечатныеФормы = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьПроизвольныеПечатныеФормы");
		
		Отчет.ДатаНачала = ТекущаяДата();
		Отчет.ДатаОкончания = Отчет.ДатаНачала + 24*3600*2;
		ПериодДляОтчета.ДатаНачала = Отчет.ДатаНачала;
		ПериодДляОтчета.ДатаОкончания = Отчет.ДатаОкончания;
		
		Если НЕ ЗначениеЗаполнено(Отчет.ОтветственныйЗаДоставку) Тогда
			Отчет.ОтветственныйЗаДоставку = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ОтветственныйЗаДоставкуПоУмолчанию");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьКартуКурьера(Команда)
	
	ПараметрыФормыПечати = Новый Структура;
	ФормаПечати = получитьформу("ОбщаяФорма.ФормаПечати", ПараметрыФормыПечати);
	НаПечать(ФормаПечати.Результат);
	
	ФормаПечати.Результат.ОтображатьСетку = ЛОЖЬ;
	ФормаПечати.Результат.Защита 			= ИСТИНА;
	ФормаПечати.Результат.ТолькоПросмотр 	= ИСТИНА;
	ФормаПечати.Результат.ОтображатьЗаголовки = ЛОЖЬ;
	ФормаПечати.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("печать: Карта курьера");
	ФормаПечати.Открыть();	
	
КонецПроцедуры

&НаСервере
Процедура НаПечать(ТабДок);
	
	СтруктураОтчета = Новый Структура;
	
	ЕстьКарта = ЛОЖЬ;
	
	ТабДок.ИмяПараметровПечати  = "КартаКурьера" + СокрЛП(ИмяКомпьютера());
	ТабДок.КлючПараметровПечати = ТабДок.ИмяПараметровПечати;
	
	ТабДок.Очистить();
	
	РазрядМетаданных = "Отчеты"; ИмяМетаданных = "КартаКурьера";
	//	ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(Перечисления.ВидыПечатныхФорм.КартаКурьера, , , РазрядМетаданных, ИмяМетаданных);
	
	ЗначениеЗаполненоПроизвольнаяПечатнаяФорма =  ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма);
	
	Если НЕ ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда	
		Макет = Отчеты.КартаКурьера.ПолучитьМакет("Макет");
		Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();
		
		ОбластьШапка = Макет.ПолучитьОбласть("Ш");
		ОбластьШапкаКлиента = Макет.ПолучитьОбласть("ШК");
		ОбластьСтрока = Макет.ПолучитьОбласть("С");
		ОбластьПодвал = Макет.ПолучитьОбласть("П");	
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Отчет.ОтветственныйЗаДоставку) Тогда
		СтруктураОтчета.Вставить("Дата", НачалоДня(Отчет.ДатаНачала));
		СтруктураОтчета.Вставить("ОтветственныйЗаДоставкуСтрока", ?(ЗначениеЗаполнено(Отчет.ОтветственныйЗаДоставку), "" + Отчет.ОтветственныйЗаДоставку + " " + ОбщийМодульСервер.ПолучитьТекстТелефонов(Отчет.ОтветственныйЗаДоставку), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не указан")));
		СтруктураОтчета.Вставить("ОтветственныйЗаДоставку", Отчет.ОтветственныйЗаДоставку);
		Если НЕ ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда	
			ОбластьШапка.Параметры.Заполнить(СтруктураОтчета);
			ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьШапка);
			ТабДок.Вывести(ОбластьШапка);
		КонецЕсли;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РасходыТовара.ОтветственныйЗаДоставку КАК ОтветственныйЗаДоставку,
	|	РасходыТовара.КлиентОповещен,
	|	РасходыТовара.ТалонТрек,
	|	РасходыТовара.СпособДоставки,
	|	РасходыТовара.ЗаказОплачен,
	|	РасходыТовара.ДатаОтправки,
	|	РасходыТовара.ДатаОповещения,
	|	РасходыТовара.Комментарий,
	|	РасходыТовара.Телефон,
	|	РасходыТовара.Адрес,
	|	РасходыТовара.ТовараНаСумму,
	|	РасходыТовара.ПоступилоДенег,
	|	РасходыТовара.Дата,
	|	РасходыТовара.КлиентПоставщик КАК Контрагент,
	|	РасходыТовара.Ссылка,
	|	РасходыТовара.Организация,
	|	РасходыТовара.Ответственный
	|ИЗ Документ.РасходыТовара КАК РасходыТовара
	|ГДЕ РасходыТовара.Проведен = ИСТИНА
	|	И (РасходыТовара.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания
	|			ИЛИ РасходыТовара.ДатаОтправки МЕЖДУ &ДатаНачала И &ДатаОкончания)
	|	И РасходыТовара.ТоварОтправлен = ЛОЖЬ
	|	И (&НетОтбораПоСпособуДоставки
	|			ИЛИ РасходыТовара.СпособДоставки = &СпособДоставки)
	|	И (&НетОтбораПоРегиону
	|			ИЛИ РасходыТовара.КлиентПоставщик.Регион = &Регион)
	|	И (&НетОтбораПоЛокации
	|			ИЛИ РасходыТовара.КлиентПоставщик.Локация = &Локация)
	|	И (&НетОтбораПоОтветственому
	|			ИЛИ РасходыТовара.ОтветственныйЗаДоставку = &ОтветственныйЗаДоставку)
	|УПОРЯДОЧИТЬ ПО ОтветственныйЗаДоставку";
	
	Запрос.УстановитьПараметр("ДатаНачала", НачалоДня(Отчет.ДатаНачала));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецДня(Отчет.ДатаОкончания));
	Запрос.УстановитьПараметр("Локация", Отчет.ОтборПоЛокации);
	Запрос.УстановитьПараметр("НетОтбораПоЛокации", не ЗначениеЗаполнено(Отчет.ОтборПоЛокации));
	Запрос.УстановитьПараметр("НетОтбораПоРегиону", Не ЗначениеЗаполнено(Отчет.ОтборПоРегиону));
	Запрос.УстановитьПараметр("НетОтбораПоОтветственому", не ЗначениеЗаполнено(Отчет.ОтветственныйЗаДоставку));
	Запрос.УстановитьПараметр("НетОтбораПоСпособуДоставки", не ЗначениеЗаполнено(Отчет.ОтборПоСпособуДоставки));
	Запрос.УстановитьПараметр("ОтветственныйЗаДоставку", Отчет.ОтветственныйЗаДоставку);
	Запрос.УстановитьПараметр("Регион", Отчет.ОтборПоРегиону);
	Запрос.УстановитьПараметр("СпособДоставки", Отчет.ОтборПоСпособуДоставки);
	
	РезультатЗапроса = Запрос.Выполнить();	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ОтветственныйЗаДоставку = Неопределено;
	
	МассивЭлементовОтчета = Новый Массив;
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		Контрагент = ВыборкаДетальныеЗаписи.Контрагент;
		Если ЗначениеЗаполнено(Контрагент) Тогда // только если есть контрагент
			
			ЕстьКарта = ИСТИНА;
			
			КонтрагентИТелефон = ОбщийМодульПовтор.ПолучитьКрасивоеНаименованиеОбъекта(Контрагент) + " " + ОбщийМодульСервер.ПолучитьТекстТелефонов(Контрагент);
			Адрес = ?(ПустаяСтрока(Контрагент.ЮридическийАдрес), Контрагент.Адрес, Контрагент.ЮридическийАдрес);
			
			ЗначениеДополнительныхРеквизитов = "";
			Если ТипЗнч(Контрагент) = Тип("СправочникСсылка.Клиенты") Тогда
				НаименованияДополнительныхРеквизитов = ОбщийМодульПовтор.ПолучитьДополнительныеРеквизитыКлиентов();
				
				Если НЕ НаименованияДополнительныхРеквизитов = Неопределено Тогда
					
					Счетчик = 1;
					Для Каждого ДопРеквизит Из НаименованияДополнительныхРеквизитов Цикл
						
						Если Счетчик <= 10 Тогда							
							ДополнительныйРеквизит = ДопРеквизит.ДополнительныйРеквизит;
							НаименованиеДопРеквизита = ОбщийМодульПовтор.получитьПредставлениеНаЯзыке(ДополнительныйРеквизит);
							РеквизитКлиента = "";
							
							Выполнить(" РеквизитКлиента = Контрагент.РеквизитКлиента" + СокрЛП(Счетчик) + ";");
							ЗначениеДополнительныхРеквизитов = ЗначениеДополнительныхРеквизитов + НаименованиеДопРеквизита + ": " + РеквизитКлиента + Символы.ПС;
						КонецЕсли;
						
						Счетчик = Счетчик + 1;
					КонецЦикла;	
				КонецЕсли;
			КонецЕсли; 
			
			ЭлементОтчета = Новый Структура;
			ЭлементОтчета.Вставить("Дата", НачалоДня(Отчет.ДатаНачала));
			ЭлементОтчета.Вставить("ДатаНачала", НачалоДня(Отчет.ДатаНачала));
			ЭлементОтчета.Вставить("ДатаОкончания", КонецДня(Отчет.ДатаОкончания));
			ЭлементОтчета.Вставить("Ссылка", ВыборкаДетальныеЗаписи.Ссылка);
			
			Если НЕ ЗначениеЗаполнено(Отчет.ОтветственныйЗаДоставку) 
				И НЕ ОтветственныйЗаДоставку = ВыборкаДетальныеЗаписи.ОтветственныйЗаДоставку Тогда
				
				ОтветственныйЗаДоставку = ВыборкаДетальныеЗаписи.ОтветственныйЗаДоставку;
				ЭлементОтчета.Вставить("ОтветственныйЗаДоставку", ОтветственныйЗаДоставку);
				
				Если НЕ ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда
					ОбластьШапка.Параметры.Заполнить(ЭлементОтчета);
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьШапка);
					ТабДок.Вывести(ОбластьШапка);	
				КонецЕсли;
				
			Иначе
				ЭлементОтчета.Вставить("ОтветственныйЗаДоставку", ПредопределенноеЗначение("Справочник.Сотрудники.ПустаяСсылка"));
			КонецЕсли;
			
			СтруктураОтчета.Вставить("ОтветственныйЗаДоставку", ЭлементОтчета.ОтветственныйЗаДоставку);
			СтруктураОтчета.Вставить("ОтветственныйЗаДоставкуСтрока", ?(ЗначениеЗаполнено(ЭлементОтчета.ОтветственныйЗаДоставку), "" + ЭлементОтчета.ОтветственныйЗаДоставку + " " + ОбщийМодульСервер.ПолучитьТекстТелефонов(ЭлементОтчета.ОтветственныйЗаДоставку), ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не указан")));
			ЭлементОтчета.Вставить("Организация", ВыборкаДетальныеЗаписи.Организация);
			СтруктураОтчета.Вставить("Организация", ЭлементОтчета.Организация);
			ЭлементОтчета.Вставить("ТалонТрек", ВыборкаДетальныеЗаписи.ТалонТрек);
			ЭлементОтчета.Вставить("Комментарий", ВыборкаДетальныеЗаписи.Комментарий);
			ЭлементОтчета.Вставить("ТоварОплачен", ВыборкаДетальныеЗаписи.ПоступилоДенег);
			ЭлементОтчета.Вставить("Адрес", Адрес);
			ЭлементОтчета.Вставить("ЗначениеДополнительныхРеквизитов", ЗначениеДополнительныхРеквизитов);
			ЭлементОтчета.Вставить("Контрагент", Контрагент);
			ЭлементОтчета.Вставить("КонтрагентИТелефон", КонтрагентИТелефон);
			
			Если НЕ ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда
				ОбластьШапкаКлиента.Параметры.Заполнить(ЭлементОтчета);		
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьШапкаКлиента);
				ТабДок.Вывести(ОбластьШапкаКлиента);
			КонецЕсли;
			
			ЭлементОтчета.Вставить("Ответственный", ?(ЗначениеЗаполнено(ВыборкаДетальныеЗаписи.Ответственный), " (" + ВыборкаДетальныеЗаписи.Ответственный + ")", ""));
			
			МассивСтрокЭлементаОтчета = Новый Массив;
			
			СуммаИтого = 0;
			Для Каждого СтрокаТовара Из ВыборкаДетальныеЗаписи.Ссылка.Товары Цикл
				
				СтрокаЭлементаОтчета = Новый Структура;
				Сумма = СтрокаТовара.Сумма;
				
				СтрокаЭлементаОтчета.Вставить("Номенклатура", СтрокаТовара.Номенклатура);
				СтрокаЭлементаОтчета.Вставить("НоменклатураСтрока", ОбщийМодульПовтор.ПолучитьКрасивоеНаименованиеОбъекта(СтрокаТовара.Номенклатура) + ЭлементОтчета.Ответственный); 
				СтрокаЭлементаОтчета.Вставить("Количество", СтрокаТовара.Количество);
				СтрокаЭлементаОтчета.Вставить("Цена", СтрокаТовара.Цена);
				СтрокаЭлементаОтчета.Вставить("Сумма", Сумма);
				
				СуммаИтого = СуммаИтого + Сумма;
				Если НЕ ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда
					ОбластьСтрока.Параметры.Заполнить(СтрокаЭлементаОтчета);		
					ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьСтрока);
					ТабДок.Вывести(ОбластьСтрока);
				Иначе
					МассивСтрокЭлементаОтчета.Добавить(СтрокаЭлементаОтчета);
				КонецЕсли;		 
			КонецЦикла;
			
			ЭлементОтчета.Вставить("ПрограммноеИмяТаблицы", "Карта");
			ЭлементОтчета.Вставить("СтрокиЭлемента", МассивСтрокЭлементаОтчета);
			ЭлементОтчета.Вставить("СуммаИтого", СуммаИтого);		
			ЭлементОтчета.Вставить("Сумма", СуммаИтого);
			
			Если НЕ ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда
				ОбластьПодвал.Параметры.Заполнить(ЭлементОтчета);
				ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьПодвал);
				ТабДок.Вывести(ОбластьПодвал);	
			Иначе
				МассивЭлементовОтчета.Добавить(ЭлементОтчета);
			КонецЕсли;	
		КонецЕсли;
		
	КонецЦикла;	
	
	Если ЗначениеЗаполненоПроизвольнаяПечатнаяФорма Тогда
		СтруктураОтчета.Вставить("ЭлементыОтчета", МассивЭлементовОтчета);	
		СтруктураОтчета.Вставить("ЭтоВычисленнаяСтруктура", ИСТИНА);
		
		МассивИменОтобранныхОбластейПечати = Новый Массив;
		МассивИменОтобранныхОбластейПечати.Добавить("ЗАГОЛОВОК");		
		ТабДок = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ТабДок, СтруктураОтчета, РазрядМетаданных, ИмяМетаданных, , МассивИменОтобранныхОбластейПечати);
		
		МассивИменОтобранныхОбластейПечати.Очистить();
		МассивИменОтобранныхОбластейПечати.Добавить("ШАПКАКАРТА");
		МассивИменОтобранныхОбластейПечати.Добавить("СТРОКАКАРТА");
		МассивИменОтобранныхОбластейПечати.Добавить("ИТОГИКАРТА");
		
		Для Каждого ЭлементОтчета Из МассивЭлементовОтчета Цикл
			СтруктураТаблиц = Новый Структура("Карта", ЭлементОтчета.СтрокиЭлемента);
			Для Каждого ЭлементСтруктурыЭлементаОтчета Из ЭлементОтчета Цикл
				СтруктураОтчета.Вставить(ЭлементСтруктурыЭлементаОтчета.Ключ, ЭлементСтруктурыЭлементаОтчета.Значение);
			КонецЦикла;
			ТабДок = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ТабДок, СтруктураОтчета, РазрядМетаданных, ИмяМетаданных, СтруктураТаблиц, МассивИменОтобранныхОбластейПечати);
		КонецЦикла;
		
		МассивИменОтобранныхОбластейПечати.Очистить();
		МассивИменОтобранныхОбластейПечати.Добавить("ПОДВАЛ");
		ТабДок = ОбщийМодульТекстСервер.СформироватьДокументПоПроизвольнойФорме(ПроизвольнаяПечатнаяФорма, , ТабДок, СтруктураОтчета, РазрядМетаданных, ИмяМетаданных, , МассивИменОтобранныхОбластейПечати);
		
	КонецЕсли;
	
	Если НЕ ЕстьКарта Тогда
		Сообщить(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Данных для курьера нет!"));
	КонецЕсли;
	
КонецПроцедуры

Процедура ОпределитьПроизвольнуюПечатнуюФорму()
	
	Если ИспользоватьПроизвольныеПечатныеФормы
		И НЕ ЗначениеЗаполнено(ПроизвольнаяПечатнаяФорма) Тогда
		
		ПроизвольнаяПечатнаяФорма = ОбщийМодульТекстСервер.ОпределитьПроизвольнуюПечатнуюФорму(ПредопределенноеЗначение("Перечисление.ВидыПечатныхФорм.КартаКурьера"), Отчет.ДатаНачала);
	КонецЕсли;
	
КонецПроцедуры
