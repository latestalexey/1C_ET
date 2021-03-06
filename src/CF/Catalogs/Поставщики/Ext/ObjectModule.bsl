﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza151215-2231 вд
// sza151210-2216 про
// sza140924-1157
// sza140601-2055
// sza130915-1735 :
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Клиенты") Тогда
		Адрес 				= ДанныеЗаполнения.Адрес;
		ВидЦен 				= ДанныеЗаполнения.ВидЦен;
		Комментарий 		= ДанныеЗаполнения.Комментарий;
		МФО 				= ДанныеЗаполнения.МФО;
		Наименование 		= ДанныеЗаполнения.Наименование;
		НаименованиеБанка 	= ДанныеЗаполнения.НаименованиеБанка;
		НаименованиеДляПечати = ДанныеЗаполнения.НаименованиеДляПечати;
		НомерСчета 			= ДанныеЗаполнения.НомерСчета;
		ОКПО 				= ДанныеЗаполнения.ОКПО;
		ОсновнаяВалюта 		= ДанныеЗаполнения.ОсновнаяВалюта;
		ПравовойСтатус 		= ДанныеЗаполнения.ПравовойСтатус;
		Регион 				= ДанныеЗаполнения.Регион;
		Склад 				= ДанныеЗаполнения.Склад;
		Телефон 			= ДанныеЗаполнения.Телефон;
		Телефон2 			= ДанныеЗаполнения.Телефон2;
		Телефон3 			= ДанныеЗаполнения.Телефон3;
		Телефон4 			= ДанныеЗаполнения.Телефон4;
		Телефон5 			= ДанныеЗаполнения.Телефон5;
		ХранилищеДенег 		= ДанныеЗаполнения.ХранилищеДенег;
		ЭлектроннаяПочта 	= ДанныеЗаполнения.ЭлектроннаяПочта;
		ЭтоСотрудник 		= ДанныеЗаполнения.ЭтоСотрудник;
		ИНН 				= ДанныеЗаполнения.ИНН;
		ЯзыкОбщения 		= ДанныеЗаполнения.ЯзыкОбщения;
		ЯзыкДокументов  	= ДанныеЗаполнения.ЯзыкДокументов;
		Локация         	= ДанныеЗаполнения.Локация;
		КорреспондентскийСчет = ДанныеЗаполнения.КорреспондентскийСчет;
		СпособДоставки		= ДанныеЗаполнения.СпособДоставки;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Производители") Тогда
		Адрес 				= ДанныеЗаполнения.Адрес;
		Комментарий 		= ДанныеЗаполнения.Комментарий;
		Наименование 		= ДанныеЗаполнения.Наименование;
		Регион 				= ДанныеЗаполнения.Регион;
		Производитель 		= ДанныеЗаполнения.Ссылка;
		Телефон 			= ДанныеЗаполнения.Телефон;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Сотрудники") Тогда
		Адрес				= ДанныеЗаполнения.Адрес;
		Комментарий 		= ДанныеЗаполнения.Комментарий;
		Наименование 		= ДанныеЗаполнения.Наименование;
		ОКПО 				= ДанныеЗаполнения.ОКПО;
		ИНН 				= ДанныеЗаполнения.ИНН;
		Телефон 			= ДанныеЗаполнения.Телефон;
		Телефон2 			= ДанныеЗаполнения.Телефон2;
		Телефон3 			= ДанныеЗаполнения.Телефон3;
		Телефон4 			= ДанныеЗаполнения.Телефон4;
		Телефон5 			= ДанныеЗаполнения.Телефон5;
		ХранилищеДенег 		= ДанныеЗаполнения.ХранилищеДенег;
		ЭлектроннаяПочта 	= ДанныеЗаполнения.ЭлектроннаяПочта;
		ЭтоСотрудник 		= ИСТИНА;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ПометкаУдаления
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		Если НЕ ЭтоГруппа
			И Модифицированность() Тогда

			Если НЕ ЗначениеЗаполнено(НаименованиеДляПечати) Тогда
				НаименованиеДляПечати = Наименование;
			КонецЕсли;

			Если ЗначениеЗаполнено(Родитель)
				И ЗначениеЗаполнено(Родитель.ВидЦен)
				И (не ЗначениеЗаполнено(ВидЦен) или ВидЦен <> Родитель.ВидЦен) Тогда

				ВидЦен = Родитель.ВидЦен;
			КонецЕсли;

			Отказ = ОбщийМодульСервер.ПроверитьУникальностьОКПО(Отказ, "Поставщики", ОКПО, Ссылка);
			Отказ = ОбщийМодульСервер.ПроверитьУникальностьЗначенияРеквизита(Отказ, "Поставщики", Наименование, Ссылка);

			Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Поставщики", Телефон, Ссылка);

			Если НЕ ПустаяСтрока(Телефон2) Тогда
				Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Поставщики", Телефон2, Ссылка);
			КонецЕсли;

			Если НЕ ПустаяСтрока(Телефон3) Тогда
				Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Поставщики", Телефон3, Ссылка);
			КонецЕсли;

			Если НЕ ПустаяСтрока(Телефон4) Тогда
				Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Поставщики", Телефон4, Ссылка);
			КонецЕсли;

			Если НЕ ПустаяСтрока(Телефон5) Тогда
				Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Поставщики", Телефон5, Ссылка);
			КонецЕсли;
		ИначеЕсли Модифицированность() Тогда

			Если НЕ Отказ
				И ЗначениеЗаполнено(Ссылка)
				И ЗначениеЗаполнено(ВидЦен) Тогда

				Запрос = Новый Запрос;
				Запрос.Текст = "ВЫБРАТЬ Поставщики.Ссылка
				|ИЗ Справочник.Поставщики КАК Поставщики
				|ГДЕ Поставщики.Родитель = &Родитель И Поставщики.ВидЦен <> &ВидЦен";
				Запрос.УстановитьПараметр("Родитель", Ссылка);
				Запрос.УстановитьПараметр("ВидЦен", ВидЦен);

				РезультатЗапроса = Запрос.Выполнить();

				Если НЕ РезультатЗапроса.Пустой() Тогда
					ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
					Счетчик  = 0;
					Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
						ПоставщикОбъект = ВыборкаДетальныеЗаписи.ссылка.ПолучитьОбъект();
						ПоставщикОбъект.ВидЦен = ВидЦен;
						ПоставщикОбъект.Записать();
						Счетчик = Счетчик  + 1;

					КонецЦикла;

					Если НЕ Счетчик =0 Тогда
						Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда
							ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Вид цен установлен для") + " " + Счетчик + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Поставщиков этой группы."), , ссылка);
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		Если НЕ Отказ
			И ЗначениеЗаполнено(Ссылка)
			И Модифицированность() Тогда

			ОбновитьПовторноИспользуемыеЗначения(); // ненаименования на языках, прочее

			ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(Наименование, Ссылка, , Отказ);
			ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(НаименованиеДляПечати, Ссылка, "НаименованиеДляПечати", Отказ);
			Если НЕ ЭтоГруппа Тогда

				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетЗарплатыСотрудников")
					И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПродажПоСотрудникам")
					И ЗакрепленныеСотрудники.Количество() = 0 Тогда

					Сотрудники = ОбщийМодульСервер.ПолучитьСотрудниковКлиента(Регион, Локация, Категория);

					Если НЕ Сотрудники.Количество() = 0 Тогда
						Для Каждого Сотрудник Из Сотрудники Цикл
							СтрокаСотрудника = ЗакрепленныеСотрудники.Добавить();
							СтрокаСотрудника.Сотрудник = Сотрудник.Значение;

						КонецЦикла;
					КонецЕсли;
				КонецЕсли;

				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
					ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "ЗакрепленныеСотрудники", "Сотрудник", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("закрепленных сотрудников"));
				КонецЕсли;
			КонецЕсли;

			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "ВидыДеятельности", "ВидДеятельности", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Видов деятельности"));
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриЗаписи(Отказ)

	Если НЕ Отказ
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВидовДеятельности")
			И ЗначениеЗаполнено(Родитель) Тогда

			Запрос = Новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	ВидыДеятельности.ВидДеятельности
			|ИЗ Справочник.Поставщики.ВидыДеятельности КАК ВидыДеятельности
			|ГДЕ ВидыДеятельности.Ссылка = &Родитель";
			Запрос.УстановитьПараметр("Родитель", Родитель);
			МассивУстановленных = Новый Массив;

			РезультатЗапроса = Запрос.Выполнить();

			Если НЕ РезультатЗапроса.Пустой() Тогда
				ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
				Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
					МассивУстановленных.Добавить(ВыборкаДетальныеЗаписи.ВидДеятельности);

				КонецЦикла;
			КонецЕсли;

			МассивНеУстановленных = Новый Массив;
			МассивКУстановке = Новый Массив;

			Запрос = Новый Запрос;
			Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
			               |	ВидыДеятельности.ВидДеятельности
			               |ИЗ Справочник.Поставщики.ВидыДеятельности КАК ВидыДеятельности
			               |ГДЕ ВидыДеятельности.Ссылка В ИЕРАРХИИ(&Родитель)
			               |	И ВидыДеятельности.Ссылка <> &Родитель";
			Запрос.УстановитьПараметр("Родитель", Родитель);

			РезультатЗапроса = Запрос.Выполнить();

			Если НЕ РезультатЗапроса.Пустой() Тогда
				ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
				Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
					ВидДеятельности = ВыборкаДетальныеЗаписи.ВидДеятельности;
					МассивКУстановке.Добавить(ВидДеятельности);

					Если МассивУстановленных.Найти(ВидДеятельности) = Неопределено Тогда
						МассивНеУстановленных.Добавить(ВидДеятельности);
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;

			ЗаменитьПолностью = ЛОЖЬ;

			Для Каждого Установленный Из МассивУстановленных Цикл
				Если МассивКУстановке.Найти(Установленный) = Неопределено Тогда // есть дырки
					ЗаменитьПолностью = ИСТИНА;
					Прервать;
				КонецЕсли;

			КонецЦикла;

			Если ЗаменитьПолностью Тогда
				РодительОбъект = Родитель.ПолучитьОбъект();
				РодительОбъект.ВидыДеятельности.Очистить();
				Для Каждого КУстановке Из МассивКУстановке Цикл
					СтрокаДеятельности = РодительОбъект.ВидыДеятельности.Добавить();
					СтрокаДеятельности.ВидДеятельности = КУстановке;

				КонецЦикла;

				РодительОбъект.Записать();
			ИначеЕсли НЕ МассивНеУстановленных.Количество() = 0 Тогда
				РодительОбъект = Родитель.ПолучитьОбъект();
				Для Каждого НеУстановленный Из МассивНеУстановленных Цикл
					СтрокаДеятельности = РодительОбъект.ВидыДеятельности.Добавить();
					СтрокаДеятельности.ВидДеятельности = НеУстановленный;

				КонецЦикла;

				РодительОбъект.Записать();
			КонецЕсли;
		КонецЕсли;

		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)

	Комментарий = "";
	НаименованиеДляПечати = "";

КонецПроцедуры

#КонецЕсли
