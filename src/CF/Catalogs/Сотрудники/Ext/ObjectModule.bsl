﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// sza140928-1546
// sza140411-1702 :
// sza131018-1445
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Склады") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ХранилищеДенег = ДанныеЗаполнения.ХранилищеДенег;
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.ХранилищаДенег") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		ХранилищеДенег = ДанныеЗаполнения.Ссылка;

	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Пользователи") Тогда
		Комментарий = ДанныеЗаполнения.Комментарий;
		Наименование = ДанныеЗаполнения.Наименование;
		Фамилия = ДанныеЗаполнения.Наименование;
		Подпись = ДанныеЗаполнения.Подпись;
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если НЕ Отказ
		И НЕ ПометкаУдаления
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

		Если НЕ ЗначениеЗаполнено(Пол) Тогда
			КонецФамилии = НРег(Прав(СокрЛП(Фамилия), 2));
			КонецНаименования = НРег(Прав(СокрЛП(Наименование), 2));

			Если КонецФамилии = "ва"
				ИЛИ НЕ КонецФамилии = "ов"
				ИЛИ КонецНаименования = "на" Тогда

				Пол = ПредопределенноеЗначение("Перечисление.Пол.Женский");
			Иначе
				Пол = ПредопределенноеЗначение("Перечисление.Пол.Мужской");
			КонецЕсли;
		КонецЕсли;

		Отказ = ОбщийМодульСервер.ПроверитьУникальностьОКПО(Отказ, "Сотрудники", ОКПО, Ссылка);
		Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Сотрудники", Телефон, Ссылка);
		Если НЕ ПустаяСтрока(Телефон2) Тогда
			Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Сотрудники", Телефон2, Ссылка);
		КонецЕсли;

		Если НЕ ПустаяСтрока(Телефон3) Тогда
			Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Сотрудники", Телефон3, Ссылка);
		КонецЕсли;

		Если НЕ ПустаяСтрока(Телефон4) Тогда
			Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Сотрудники", Телефон4, Ссылка);
		КонецЕсли;

		Если НЕ ПустаяСтрока(Телефон5) Тогда
			Отказ = ОбщийМодульСервер.ПроверитьУникальностьНомераТелефона(Отказ, "Сотрудники", Телефон5, Ссылка);
		КонецЕсли;

		Если НЕ отказ
			И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьШтрихКоды")
			И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("НеПроверятьУникальностьШтрихКода")
			И НЕ ПустаяСтрока(ОсновнойШтрихКод) Тогда

			РезультатОбработки = ОбщийМодульТоварСервер.НайтиНоменклатуруПоШтрихКоду(ОсновнойШтрихКод);

			Если ЗначениеЗаполнено(РезультатОбработки) Тогда
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ошибка! Такой штрихкод найден") + " (" + ОсновнойШтрихКод + "): " + РезультатОбработки.Номенклатура);
				Отказ = ИСТИНА;
			Иначе
				РезультатОбработки = ОбщийМодульСервер.НайтиСотрудникаПоШтрихКоду(ОсновнойШтрихКод);

				Если ЗначениеЗаполнено(РезультатОбработки)
					И НЕ РезультатОбработки = Ссылка Тогда

					ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Такой штрихкод уже указан у сотрудника") + " (" + ОсновнойШтрихКод + "): " + РезультатОбработки);
					Отказ = ИСТИНА;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

		Если НЕ Отказ
			И Модифицированность() Тогда

			МассивПустыхСтрок = Новый массив;

			Для Каждого СтрокаСоставаНабора Из РасчетЗарплаты Цикл

				Если НЕ ЗначениеЗаполнено(СтрокаСоставаНабора.ВидНачисления)
					И НЕ ЗначениеЗаполнено(СтрокаСоставаНабора.Размер) Тогда

					МассивПустыхСтрок.Добавить(СтрокаСоставаНабора);
				КонецЕсли;
			КонецЦикла;

			Для Каждого СтрокаСоставаНабора Из МассивПустыхСтрок Цикл
				РасчетЗарплаты.Удалить(СтрокаСоставаНабора);
			КонецЦикла;

			МассивПустыхСтрок = Новый Массив;

			Для Каждого СтрокаСоставаНабора Из склады Цикл
				Если НЕ ЗначениеЗаполнено(СтрокаСоставаНабора.Склад) Тогда
					МассивПустыхСтрок.Добавить(СтрокаСоставаНабора);
				КонецЕсли;

			КонецЦикла;

			Для Каждого СтрокаСоставаНабора Из МассивПустыхСтрок Цикл
				Склады.Удалить(СтрокаСоставаНабора);
			КонецЦикла;

			БылиИзменения = ЛОЖЬ;

			Если НЕ ЗначениеЗаполнено(Клиент) Тогда
				КлиентОбъект = Справочники.Клиенты.СоздатьЭлемент();
				БылиИзменения = ИСТИНА;
			Иначе
				КлиентОбъект = Клиент.ПолучитьОбъект();
			КонецЕсли;

			Если ЗначениеЗаполнено(Адрес)
				И НЕ клиентОбъект.Адрес = Адрес Тогда

				БылиИзменения = ИСТИНА;
			КонецЕсли;

			ВидЦен = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВидЦенДляОтпускаТоваровСобственнымСотрудникам");

			Если ЗначениеЗаполнено(ВидЦен)
				И НЕ клиентОбъект.ВидЦен = ВидЦен Тогда

				КлиентОбъект.ВидЦен = ВидЦен;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(Комментарий)
				И НЕ клиентОбъект.Комментарий = Комментарий Тогда

				КлиентОбъект.Комментарий = Комментарий;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			РодительКлиент = Справочники.Клиенты.НайтиПоНаименованию(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Собственные Сотрудники"));

			Если НЕ ЗначениеЗаполнено(РодительКлиент) Тогда
				РодительКлиентОбъект = Справочники.Клиенты.СоздатьГруппу();
				РодительКлиентОбъект.Наименование 	= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Собственные Сотрудники");
				РодительКлиентОбъект.ВидЦен 		= ВидЦен;
				РодительКлиентОбъект.Записать();
				РодительКлиент = РодительКлиентОбъект.Ссылка;
			КонецЕсли;

			Если ЗначениеЗаполнено(РодительКлиент)
				И ОбщийМодульПовтор.ЭтоГруппа(РодительКлиент)
				И НЕ клиентОбъект.Родитель = РодительКлиент Тогда

				КлиентОбъект.Родитель = РодительКлиент;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если НЕ КлиентОбъект.Наименование = Наименование Тогда
				КлиентОбъект.Наименование 			= Наименование;
				КлиентОбъект.НаименованиеДляПечати 	= Наименование;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(ОКПО)
				И НЕ КлиентОбъект.ОКПО = ОКПО Тогда

				КлиентОбъект.ОКПО = ОКПО;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(Телефон)
				И НЕ КлиентОбъект.Телефон = Телефон Тогда

				КлиентОбъект.Телефон = Телефон;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(ЭлектроннаяПочта)
				И НЕ КлиентОбъект.ЭлектроннаяПочта = ЭлектроннаяПочта Тогда

				КлиентОбъект.ЭлектроннаяПочта = ЭлектроннаяПочта;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(ДатаРождения)
				И НЕ КлиентОбъект.ДатаРождения = ДатаРождения Тогда

				КлиентОбъект.ДатаРождения = ДатаРождения;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если НЕ КлиентОбъект.ЭтоСотрудник Тогда
				КлиентОбъект.ЭтоСотрудник = ИСТИНА;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если БылиИзменения Тогда
				Попытка
					КлиентОбъект.Записать();
					Клиент = клиентОбъект.Ссылка;
				Исключение
					Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда

						ТекстОписаниеОшибки = ОписаниеОшибки();
						ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ошибка при попытке записи связанного Клиента") + ": " + клиентОбъект + " " + ТекстОписаниеОшибки, , Ссылка);
					КонецЕсли;

				КонецПопытки;
			КонецЕсли;

			БылиИзменения = ЛОЖЬ;

			Если НЕ ЗначениеЗаполнено(Поставщик) Тогда
				ПоставщикОбъект = Справочники.Поставщики.СоздатьЭлемент();
				БылиИзменения = ИСТИНА;
			Иначе
				ПоставщикОбъект = Поставщик.ПолучитьОбъект();
			КонецЕсли;

			Если ЗначениеЗаполнено(Адрес)
				И НЕ ПоставщикОбъект.Адрес = Адрес Тогда

				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(ВидЦен)
				И НЕ ПоставщикОбъект.ВидЦен = ВидЦен Тогда

				ПоставщикОбъект.ВидЦен = ВидЦен;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(Комментарий)
				И НЕ ПоставщикОбъект.Комментарий = Комментарий Тогда

				ПоставщикОбъект.Комментарий = Комментарий;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			РодительПоставщик = Справочники.Поставщики.НайтиПоНаименованию(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Собственные Сотрудники"));

			Если НЕ ЗначениеЗаполнено(РодительПоставщик) Тогда
				РодительПоставщикОбъект = Справочники.Поставщики.СоздатьГруппу();
				РодительПоставщикОбъект.Наименование = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Собственные Сотрудники");
				РодительПоставщикОбъект.ВидЦен 		 = ВидЦен;
				РодительПоставщикОбъект.Записать();

				РодительПоставщик = РодительПоставщикОбъект.Ссылка;
			КонецЕсли;

			Если ЗначениеЗаполнено(РодительПоставщик)
				И ОбщийМодульПовтор.ЭтоГруппа(РодительПоставщик)
				И НЕ ПоставщикОбъект.Родитель = РодительПоставщик Тогда

				ПоставщикОбъект.Родитель = РодительПоставщик;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если НЕ ПоставщикОбъект.Наименование = Наименование Тогда
				ПоставщикОбъект.Наименование = Наименование;
				ПоставщикОбъект.НаименованиеДляПечати = Наименование;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(ОКПО)
				И НЕ ПоставщикОбъект.ОКПО = ОКПО Тогда

				ПоставщикОбъект.ОКПО = ОКПО;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(Телефон)
				И НЕ ПоставщикОбъект.Телефон = Телефон Тогда

				ПоставщикОбъект.Телефон = Телефон;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если ЗначениеЗаполнено(ЭлектроннаяПочта)
				И НЕ ПоставщикОбъект.ЭлектроннаяПочта = ЭлектроннаяПочта Тогда

				ПоставщикОбъект.ЭлектроннаяПочта = ЭлектроннаяПочта;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если НЕ ПоставщикОбъект.ЭтоСотрудник Тогда
				ПоставщикОбъект.ЭтоСотрудник = ИСТИНА;
				БылиИзменения = ИСТИНА;
			КонецЕсли;

			Если БылиИзменения Тогда
				Попытка
					ПоставщикОбъект.Записать();
					Поставщик = ПоставщикОбъект.Ссылка;
				Исключение
					Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда

						ТекстОписаниеОшибки = ОписаниеОшибки();
						ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ошибка при попытке записи связанного Поставщика") + ": " + ПоставщикОбъект + " " + ТекстОписаниеОшибки, , Ссылка);
					КонецЕсли;

				КонецПопытки;
			КонецЕсли;

			ОбщийМодульСервер.ПроверитьСменуНаименованияНаТекущемЯзыке(Наименование, Ссылка);

			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "Склады", "Склад", "-");
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "Регионы", "Регион", "-");
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "Категории", "Категория", "-");
			КонецЕсли;

			Если НЕ Отказ Тогда
				Если НЕ ПустаяСтрока(Подпись) Тогда
					Отказ = ОбщийМодульСервер.ПроверитьУникальностьЗначенияРеквизита(Отказ, "Сотрудники", Подпись, Ссылка, , , "Подпись");
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура ПриЗаписи(Отказ)

	Если НЕ Отказ
		И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА)
		И Модифицированность() Тогда

		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	Комментарий = "";
КонецПроцедуры

#КонецЕсли
