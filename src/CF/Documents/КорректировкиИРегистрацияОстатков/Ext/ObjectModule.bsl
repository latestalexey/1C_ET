﻿// sza160302-0129 расчеты в валюте
// sza151210-2336 про
// sza151013-0340 другие регистры
// sza150110-0118 НЧ
// sza141226-0301 не уст завис цены\
// sza140703-1239  основной склад при отключенном учете
// sza140701-1320
// sza140615-1955
// sza130910-1741 :

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

	Процедура ОбработатьДвиженияДляНабора(Номенклатура, Склад, КоличествоСтруктура, Сумма, курс, УчетВаловойПрибыли) // для вложенных наборов

		Если НЕ Сторный Тогда
			ВидДвиженияНакопленияПриход = ВидДвиженияНакопления.Приход;
			ВидДвиженияНакопленияРасход = ВидДвиженияНакопления.Расход;
		Иначе
			ВидДвиженияНакопленияПриход = ВидДвиженияНакопления.Расход;
			ВидДвиженияНакопленияРасход = ВидДвиженияНакопления.Приход;
		КонецЕсли;

		ОбщееКоличество = Номенклатура.Состав.Итог("Количество");

		Если ОбщееКоличество = 0 Тогда
			ОбщееКоличество = 1;
		КонецЕсли;

		Для Каждого СтрокаСоставаНабора Из Номенклатура.Состав Цикл
			НоменклатураСостава = СтрокаСоставаНабора.Номенклатура;
			СуммаЭлемента = (Сумма / ОбщееКоличество) * СтрокаСоставаНабора.количество;
			Количество 	  = КоличествоСтруктура * СтрокаСоставаНабора.Количество * ?(ЗначениеЗаполнено(СтрокаСоставаНабора.ЕдиницаИзмерения), СтрокаСоставаНабора.ЕдиницаИзмерения.Количество, 1);

			Если ОбщийМодульПовтор.ЭтоНабор(НоменклатураСостава) Тогда
				ОбработатьДвиженияДляНабора(НоменклатураСостава, склад, Количество, СуммаЭлемента, курс, УчетВаловойПрибыли);
			Иначе
				СуммаТов = СуммаЭлемента * Курс;

				Если НЕ ОбщийМодульПовтор.ТоварНеУчитываетсяПоКоличеству(НоменклатураСостава) Тогда
					Движение = Движения.Товары.Добавить();
					Движение.ВидДвижения 	= ВидДвиженияНакопленияПриход;
					Движение.Период 		= Дата;
					Движение.Номенклатура 	= НоменклатураСостава;
					Движение.Склад 			= Склад;
					Движение.Количество 	= Количество;
					Движение.Комментарий	= Комментарий;
					Движение.Сумма 			= СуммаТов;
					Движение.СписаниеИлиОприходование = ИСТИНА;
				КонецЕсли;
			КонецЕсли;

		КонецЦикла;

	КонецПроцедуры

	Процедура ОбработкаПроведения(Отказ, Режим)

		Если НеПроводить Тогда
			НеПроводить = ЛОЖЬ;
			Записать(РежимЗаписиДокумента.Запись);
		Иначе
			Если НЕ Отказ Тогда

				ОбщийМодульСервер.УдалитьСвязанныеЦены(Ссылка);
				Движения.Товары.Записать();
				Движения.Расчеты.Записать();
				Движения.РасчетыСОтсрочкой.Записать();
				Движения.РасчетыСПоставщиками.Записать();
				Движения.РасчетыСПоставщикамиСОтсрочкой.Записать();
				Движения.РасчетыВВалюте.Записать();
				Движения.Деньги.Записать();
				Движения.Зарплата.Записать();
				Движения.ТоварыПереданныеНаКомиссию.Записать();
				Движения.ПродажиСотрудников.Записать();
				Движения.НакоплениеНаВаучеры.Записать();

				Если НЕ Сторный Тогда
					ВидДвиженияНакопленияПриход = ВидДвиженияНакопления.Приход;
					ВидДвиженияНакопленияРасход = ВидДвиженияНакопления.Расход;
				Иначе
					ВидДвиженияНакопленияПриход = ВидДвиженияНакопления.Расход;
					ВидДвиженияНакопленияРасход = ВидДвиженияНакопления.Приход;
				КонецЕсли;

				ОсновнаяВалюта = ОбщийМодульПовтор.ЗначениеПредопределенного("Справочники.Валюты.ОсновнаяВалюта");
				ИспользоватьМеханИзмОтсрочкиПлатежа = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьМеханИзмОтсрочкиПлатежа");
				ОсновнойСклад = ПредопределенноеЗначение("Справочник.Склады.ОсновнойСклад");
				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетТоваровПереданныхОтНасДляКомиссионнойТорговли") Тогда
					Для Каждого ТекСтрока Из ТоварыПереданныеНаКомиссию Цикл
						Движение = Движения.ТоварыПереданныеНаКомиссию.Добавить();
						Движение.ВидДвижения 	= ВидДвиженияНакопленияПриход;
						Движение.Период 		= ?(ЗначениеЗаполнено(ТекСтрока.ДатаПередачиНаКомиссию), ТекСтрока.ДатаПередачиНаКомиссию, Дата);
						Движение.Сумма 			= ТекСтрока.Сумма;
						Движение.Клиент  		= ТекСтрока.Клиент;
						Движение.Договор 		= ТекСтрока.Договор;
						Движение.Количество 	= ТекСтрока.Количество;
						Движение.Комментарий 	= ТекСтрока.ОСтроке;
						Движение.Номенклатура 	= ТекСтрока.Номенклатура;
						Движение.СерияНоменклатуры 	  = ТекСтрока.СерияНоменклатуры;
						Движение.ДатаОтчетаПоКомиссии = ?(ЗначениеЗаполнено(ТекСтрока.ДатаОтчетаПоКомиссии), ТекСтрока.ДатаОтчетаПоКомиссии, Дата);
					КонецЦикла;
				КонецЕсли;

				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетДвиженияДенег") Тогда
					Для Каждого ТекСтрокаДеньги Из Деньги Цикл
						Валюта = ?(ЗначениеЗаполнено(ТекСтрокаДеньги.Валюта), ТекСтрокаДеньги.Валюта, ОсновнаяВалюта);
						Движение = Движения.Деньги.Добавить();
						Движение.ВидДвижения 	= ВидДвиженияНакопленияПриход;
						Движение.Период 		= Дата;
						Движение.Статья 		= ТекСтрокаДеньги.Статья;
						Движение.Сумма 			= ОбщийМодульСервер.ПоКурсу(ТекСтрокаДеньги.ОстатокДенег, , Валюта, Дата);
						Движение.СуммаВВалюте 	= ТекСтрокаДеньги.ОстатокДенег;
						Движение.ФормаОплаты 	= ТекСтрокаДеньги.ФормаОплаты;
						Движение.ХранилищеДенег = ТекСтрокаДеньги.ХранилищеДенег;
						Движение.Валюта 		= Валюта;
					КонецЦикла;
				КонецЕсли;

				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоКлиентам") Тогда
					Для Каждого ТекСтрокаРасчеты Из Расчеты Цикл
						Движение = Движения.Расчеты.Добавить();
						Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
						Движение.Период 	 = Дата;
						Движение.Клиент 	 = ТекСтрокаРасчеты.Клиент;
						Движение.Договор	 = ТекСтрокаРасчеты.Договор;
						Движение.Сумма 		 = ТекСтрокаРасчеты.Сумма;
						Движение.Комментарий = ТекСтрокаРасчеты.Комментарий;
					КонецЦикла;

					Если ИспользоватьМеханИзмОтсрочкиПлатежа Тогда
						Для Каждого ТекСтрокаРасчеты Из Расчеты Цикл
							Движение = Движения.РасчетыСОтсрочкой.Добавить();
							Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
							Движение.Период 	 = Дата + ТекСтрокаРасчеты.ОстатокДнейОтсрочки * 3600 * 24;
							Движение.Клиент 	 = ТекСтрокаРасчеты.Клиент;
							Движение.Договор	 = ТекСтрокаРасчеты.Договор;
							Движение.Сумма 		 = ТекСтрокаРасчеты.Сумма;
							Движение.Комментарий = ТекСтрокаРасчеты.Комментарий;
						КонецЦикла;
					КонецЕсли;

					Для Каждого ТекСтрокаРасчеты Из Расчеты Цикл

						ВалютаКонтрагента = ОбщийМодульСервер.ПолучитьВалютуКонтрагента(ТекСтрокаРасчеты.Клиент);

						РасчетыВВалюте = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВалют")
						И ЗначениеЗаполнено(ВалютаКонтрагента)
						И НЕ ВалютаКонтрагента = ПредопределенноеЗначение("Справочник.Валюты.ОсновнаяВалюта");

						Если РасчетыВВалюте Тогда

							Если ТекСтрокаРасчеты.СуммаВВалюте = 0 Тогда
								СуммаВВалюте = ОбщийМодульСервер.ПоКурсу(ТекСтрокаРасчеты.Сумма, ВалютаКонтрагента, , Дата, ТекСтрокаРасчеты.Курс);
							Иначе
								СуммаВВалюте = ТекСтрокаРасчеты.СуммаВВалюте;
							КонецЕсли;

							Движение = Движения.РасчетыВВалюте.Добавить();
							Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
							Движение.КлиентПоставщик = ТекСтрокаРасчеты.Клиент;
							Движение.Договор 	 = ТекСтрокаРасчеты.Договор;
							Движение.Период 	 = Дата;
							Движение.Комментарий = ТекСтрокаРасчеты.Комментарий;
							Движение.Сумма 		 = СуммаВВалюте;
							Движение.Валюта 	 = ВалютаКонтрагента;
							Движение.СуммаВОсновнойВалюте = ТекСтрокаРасчеты.Сумма;
						КонецЕсли;

					КонецЦикла;
				КонецЕсли;

				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоПоставщикам") Тогда
					Для Каждого ТекСтрокаРасчеты Из РасчетыСПоставщиками Цикл
						Движение = Движения.РасчетыСПоставщиками.Добавить();
						Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
						Движение.Период 	 = Дата;
						Движение.Поставщик 	 = ТекСтрокаРасчеты.Поставщик;
						Движение.Договор	 = ТекСтрокаРасчеты.Договор;
						Движение.Сумма 		 = ТекСтрокаРасчеты.Сумма;
						Движение.Комментарий = ТекСтрокаРасчеты.Комментарий;
					КонецЦикла;

					Если ИспользоватьМеханИзмОтсрочкиПлатежа Тогда
						Для Каждого ТекСтрокаРасчеты Из РасчетыСПоставщиками Цикл
							Движение = Движения.РасчетыСПоставщикамиСОтсрочкой.Добавить();
							Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
							Движение.Период 	 = Дата + ТекСтрокаРасчеты.ОстатокДнейОтсрочки * 3600 * 24;
							Движение.Поставщик 	 = ТекСтрокаРасчеты.Поставщик;
							Движение.Договор	 = ТекСтрокаРасчеты.Договор;
							Движение.Сумма 		 = ТекСтрокаРасчеты.Сумма;
							Движение.Комментарий = ТекСтрокаРасчеты.Комментарий;
						КонецЦикла;
					КонецЕсли;

					Для Каждого ТекСтрокаРасчеты Из РасчетыСПоставщиками Цикл

						ВалютаКонтрагента = ОбщийМодульСервер.ПолучитьВалютуКонтрагента(ТекСтрокаРасчеты.Поставщик);

						РасчетыВВалюте = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВалют")
						И ЗначениеЗаполнено(ВалютаКонтрагента)
						И НЕ ВалютаКонтрагента = ПредопределенноеЗначение("Справочник.Валюты.ОсновнаяВалюта");

						Если РасчетыВВалюте Тогда

							Если ТекСтрокаРасчеты.СуммаВВалюте = 0 Тогда
								СуммаВВалюте = ОбщийМодульСервер.ПоКурсу(ТекСтрокаРасчеты.Сумма, ВалютаКонтрагента, , Дата, ТекСтрокаРасчеты.Курс);
							Иначе
								СуммаВВалюте = ТекСтрокаРасчеты.СуммаВВалюте;
							КонецЕсли;

							Движение = Движения.РасчетыВВалюте.Добавить();
							Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
							Движение.КлиентПоставщик = ТекСтрокаРасчеты.Поставщик;
							Движение.Договор 	 = ТекСтрокаРасчеты.Договор;
							Движение.Период 	 = Дата;
							Движение.Комментарий = ТекСтрокаРасчеты.Комментарий;
							Движение.Сумма 		 = СуммаВВалюте;
							Движение.Валюта 	 = ВалютаКонтрагента;
							Движение.СуммаВОсновнойВалюте = ТекСтрокаРасчеты.Сумма;
						КонецЕсли;

					КонецЦикла;
				КонецЕсли;

				Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПродажПоСотрудникам") Тогда
					Для Каждого ТекСтрока Из ПродажиСотрудников Цикл
						Движение = Движения.ПродажиСотрудников.Добавить();
						Движение.ВидДвижения = ВидДвиженияНакопленияПриход;
						Движение.Количество  = ТекСтрока.Количество;
						Движение.Номенклатура= ТекСтрока.Номенклатура;
						Движение.Сотрудник   = ТекСтрока.Сотрудник;
						Движение.Период 	 = Дата;
						Движение.Сумма 		 = ТекСтрока.Сумма;
						Движение.Комментарий = ТекСтрока.Комментарий;
					КонецЦикла;
				КонецЕсли;

				Если НЕ ВзаимозачетДолгаКонтрагентов Тогда

					Движения.Товары.Записывать 	= ИСТИНА;
					ЗначениеЗаполненоВидЦен 	= ЗначениеЗаполнено(ВидЦен);
					УчетВаловойПрибыли = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВаловойПрибыли");
					Если ЗначениеЗаполнено(ВидЦен) Тогда
						Курс = ОбщийМодульПовтор.ПолучитьТекущийКурс(ВидЦен.ВалютаЦены, Дата);
					Иначе
						Курс = 1;
					КонецЕсли;

					Для Каждого ТекСтрокаТовара Из Товары Цикл

						Если ЗначениеЗаполнено(ТекСтрокаТовара.СерияНоменклатуры)
							И НЕ ЗначениеЗаполнено(ТекСтрокаТовара.СерияНоменклатуры.ДокументПриобретения) Тогда

							СерияОбъект = ТекСтрокаТовара.СерияНоменклатуры.ПолучитьОбъект();
							СерияОбъект.ДокументПриобретения = Ссылка;
							СерияОбъект.Записать();
						КонецЕсли;

						Номенклатура = ТекСтрокаТовара.Номенклатура;
						КомментарийСтоки = ?(ЗначениеЗаполнено(ТекСтрокаТовара.ОСтроке), ТекСтрокаТовара.ОСтроке, Комментарий);
						Количество = ?(ЗначениеЗаполнено(ТекСтрокаТовара.ЕдиницаИзмерения), ТекСтрокаТовара.ЕдиницаИзмерения.Количество * ТекСтрокаТовара.Количество, ТекСтрокаТовара.Количество);
						Если НЕ ОбщийМодульПовтор.ЭтоНабор(Номенклатура) Тогда
							СуммаТов = ТекСтрокаТовара.Сумма * Курс;

							Если НЕ ОбщийМодульПовтор.ТоварНеУчитываетсяПоКоличеству(Номенклатура) Тогда
								Движение = Движения.Товары.Добавить();
								Движение.ВидДвижения  = ВидДвиженияНакопленияПриход;
								Движение.Период 	  = Дата;
								Движение.Номенклатура = Номенклатура;
								Движение.Склад 		  = ?(ЗначениеЗаполнено(ТекСтрокаТовара.Склад), ТекСтрокаТовара.Склад, ОсновнойСклад);
								Движение.Количество   = Количество;
								Движение.Сумма 		  = СуммаТов;
								Движение.Комментарий  = КомментарийСтоки;
								Движение.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
								Движение.СписаниеИлиОприходование = ИСТИНА;
							КонецЕсли;

							Если ЗначениеЗаполненоВидЦен Тогда
								СтрокаЦен = Новый Структура;
								СтрокаЦен.Вставить("Цена", ТекСтрокаТовара.Цена);
								СтрокаЦен.Вставить("Номенклатура", Номенклатура);
								ОбщийМодульСервер.УстановитьЦенуИВсеЗависимые(ВидЦен, СтрокаЦен, Ссылка, Комментарий, Дата, , , , , НеУстанавливатьЗависимыеЦены, ТекСтрокаТовара.ЕдиницаИзмерения,);
							КонецЕсли;
						Иначе // набор
							ОбработатьДвиженияДляНабора(Номенклатура, ?(ЗначениеЗаполнено(ТекСтрокаТовара.Склад), ТекСтрокаТовара.Склад, ОсновнойСклад), ТекСтрокаТовара.Количество, ТекСтрокаТовара.Сумма, курс, УчетВаловойПрибыли);
						КонецЕсли;

					КонецЦикла;

					Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетЗарплатыСотрудников") Тогда
						Движения.Зарплата.Записывать = ИСТИНА;
						Для Каждого ТекСтрокаЗП Из Зарплата Цикл
							Движение = Движения.Зарплата.Добавить();
							Движение.ВидДвижения   = ВидДвиженияНакопленияПриход; // начисление
							Движение.Период 	   = Дата;
							Движение.Валюта 	   = ТекСтрокаЗП.Валюта;
							Движение.ВидНачисления = ТекСтрокаЗП.ВидНачисления;
							Движение.Сумма 		   = ОбщийМодульСервер.ПоКурсу(ТекСтрокаЗП.Сумма, ТекСтрокаЗП.Валюта, , Дата);
							Движение.СуммаВВалюте  = ТекСтрокаЗП.Сумма;
							Движение.Комментарий   = ТекСтрокаЗП.Комментарий;
							Движение.Сотрудник 	   = ТекСтрокаЗП.Сотрудник;
							Движение.ОписаниеНачисления = ТекСтрокаЗП.ОписаниеНачисления;
						КонецЦикла;
					КонецЕсли;

					Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьВаучеры") Тогда
						Движения.НакоплениеНаВаучеры.Записывать = ИСТИНА;
						Для Каждого ТекСтрока Из НакоплениеНаВаучеры Цикл
							Движение = Движения.НакоплениеНаВаучеры.Добавить();
							Движение.ВидДвижения   = ВидДвиженияНакопленияПриход; // начисление
							Движение.Валюта        = ТекСтрока.Валюта;
							Движение.Ваучер		   = ТекСтрока.Ваучер;
							Движение.Комментарий   = ТекСтрока.Комментарий;
							Движение.Период        = Дата;
							Движение.Сумма		   = ТекСтрока.Сумма;
							Движение.СуммаВВалюте  = ТекСтрока.СуммаВВалюте;
						КонецЦикла;
					КонецЕсли;

					Если ОбщийМодульПовтор.ПолучитьПараметрСеанса("ИспользоватьСложныйМеханИзмЦенПС") Тогда
						Для Каждого СтрокаЦен Из Цены Цикл
							ОбщийМодульСервер.УстановитьЦенуИВсеЗависимые(СтрокаЦен.ВидЦен, СтрокаЦен, Ссылка, ?(ЗначениеЗаполнено(СтрокаЦен.ОСтроке), СтрокаЦен.ОСтроке, Комментарий), Дата, , , , ,НеУстанавливатьЗависимыеЦены);
						КонецЦикла;

					Иначе
						ОсновнаяФормулаПреобразованияЦен = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ОсновнаяФормулаПреобразованияЦен");
						ЗначениеЗаполненоОсновнаяФормулаПреобразованияЦен = ЗначениеЗаполнено(ОсновнаяФормулаПреобразованияЦен);

						Если УстанавливатьЦенуУказаннуюВТаблицеВКачествеЦеныДляРеализацииТовара
							ИЛИ ЗначениеЗаполненоОсновнаяФормулаПреобразованияЦен Тогда

							Формула = ?(ЗначениеЗаполненоОсновнаяФормулаПреобразованияЦен, ВРег(ОсновнаяФормулаПреобразованияЦен.Формула), "");
							ЕстьЛьготнаяЦена = НЕ найти(Формула, "ЛЬГОТНАЯЦЕНА") = 0;
							ЕстьЦена = НЕ найти(Формула, "ЦЕНА") = 0;
							Для Каждого СтрокаТовара Из Товары Цикл

								Если ЗначениеЗаполнено(СтрокаТовара.Номенклатура) Тогда

									Если УстанавливатьЦенуУказаннуюВТаблицеВКачествеЦеныДляРеализацииТовара
										И НЕ СтрокаТовара.Номенклатура.Цена = СтрокаТовара.Цена Тогда

										НоменклатураОбъект = СтрокаТовара.Номенклатура.ПолучитьОбъект();
										НоменклатураОбъект.Цена = СтрокаТовара.Цена ;
										НоменклатураОбъект.Записать();
									ИначеЕсли ЗначениеЗаполненоОсновнаяФормулаПреобразованияЦен Тогда

										Попытка
											Цена 	  = СтрокаТовара.Цена;
											НоваяЦена = 0;
											Формула   = ВРег(ОсновнаяФормулаПреобразованияЦен.Формула);
											НоменклатурнаяГруппа = СтрокаТовара.Номенклатура.НоменклатурнаяГруппа;

											Если ЕстьЦена Тогда
												Цена = СтрокаТовара.Цена;
											КонецЕсли;

											Если ЕстьЛьготнаяЦена Тогда
												ЛьготнаяЦена = ОбщийМодульСервер.ПолучитьЛьготнуюЦену(СтрокаТовара.Номенклатура, , Цена, ВидЦен);
											КонецЕсли;

											выполнить (" НоваяЦена = " + ОсновнаяФормулаПреобразованияЦен.Формула + ";");

											Если НЕ СтрокаТовара.Номенклатура.Цена = СтрокаТовара.Цена Тогда
												НоменклатураОбъект = СтрокаТовара.Номенклатура.ПолучитьОбъект();
												НоменклатураОбъект.Цена = НоваяЦена;
												НоменклатураОбъект.Записать();
											КонецЕсли;

										Исключение
											Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда

												ТекстОписаниеОшибки = ОписаниеОшибки();
												ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("При формировании цены ПроИзошла ошибка") + ": " + ТекстОписаниеОшибки, , Ссылка);
											КонецЕсли;

										КонецПопытки;
									КонецЕсли;
								КонецЕсли;
							КонецЦикла;
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;

			Движения.Товары.Записывать 	 = НЕ Отказ;
			Движения.Расчеты.Записывать  = НЕ Отказ;
			Движения.РасчетыСОтсрочкой.Записывать    = НЕ Отказ;
			Движения.РасчетыСПоставщиками.Записывать = НЕ Отказ;
			Движения.РасчетыСПоставщикамиСОтсрочкой.Записывать = НЕ Отказ;
			Движения.РасчетыВВалюте.Записывать 		 = НЕ Отказ;
			Движения.Деньги.Записывать 	 = НЕ Отказ;
			Движения.Зарплата.Записывать = НЕ Отказ;
			Движения.ПродажиСотрудников.Записывать 	 = НЕ Отказ;
			Движения.НакоплениеНаВаучеры.Записывать  = НЕ Отказ;
			Движения.ТоварыПереданныеНаКомиссию.Записывать = НЕ Отказ;
		КонецЕсли;

	КонецПроцедуры

	Процедура ОбработкаУдаленияПроведения(Отказ)

		Если НЕ Отказ Тогда
			Попытка // ЭтотОбъект
				Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002201", , Отказ, ЭтотОбъект);
			Исключение
			КонецПопытки;
		КонецЕсли;

		Если НЕ Отказ Тогда
			ОтборПоДокументу = Новый Структура;
			ОтборПоДокументу.Вставить("ДокументРегистрации", Ссылка);
			Выборка = РегистрыСведений.Цены.Выбрать(,, ОтборПоДокументу);

			Пока Выборка.Следующий() Цикл
				Выборка.ПолучитьМенеджерЗаписи().Удалить();
			КонецЦикла;

			Для Каждого ТекСтрокаТовара Из Товары Цикл

				Если ЗначениеЗаполнено(ТекСтрокаТовара.СерияНоменклатуры)
					И ТекСтрокаТовара.СерияНоменклатуры.ДокументПриобретения = Ссылка Тогда

					СерияОбъект = ТекСтрокаТовара.СерияНоменклатуры.ПолучитьОбъект();
					СерияОбъект.ДокументПриобретения = Неопределено;
					СерияОбъект.Записать();
				КонецЕсли;

			КонецЦикла;

			ОбщийМодульСервер.УдалитьСвязанныеЦены(Ссылка);
		КонецЕсли;

	КонецПроцедуры

	Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

		Если ОбменДанными.Загрузка Тогда
			Возврат;
		КонецЕсли;

		Если НЕ Отказ
			И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА)
			И Модифицированность()
			И РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда

			Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПриАвтоматическомПерепроведенииДокументовОтменитьПроверкиНаОтказ") Тогда
				ПодготовкаКПроведению(Отказ);
			КонецЕсли;

			Если ТовараВКоличестве = 0
				И ТовараНаСумму = 0
				И НЕ ВзаимозачетДолгаКонтрагентов
				И Цены.Количество() = 0
				И Расчеты.Количество() = 0
				И РасчетыСПоставщиками.Количество() = 0
				И Деньги.Количество() = 0
				И Зарплата = 0
				И РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда

				РежимЗаписи = РежимЗаписиДокумента.Запись;
			КонецЕсли;

			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект);
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "Расчеты", "Клиент", "-");
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект, "РасчетыСПоставщиками", "Поставщик", "-");
			КонецЕсли;
		КонецЕсли;

	КонецПроцедуры

	Процедура ПодготовкаКПроведению(Отказ) Экспорт

		Если НЕ Отказ
			И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

			Если Дата > ТекущаяДата()
				И ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002900", , , ЭтотОбъект) Тогда

				Дата = ТекущаяДата();
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Дата и время документа установлены сейчас."));
			КонецЕсли;

			ТекстОшибки = "";

			МассивПустыхСтрок = Новый Массив;
			Для Каждого СтрокаТаблицы Из расчеты Цикл
				Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.Клиент) Тогда
					МассивПустыхСтрок.Добавить(СтрокаТаблицы);
				ИначеЕсли ЗначениеЗаполнено(СтрокаТаблицы.Договор)
					И НЕ СтрокаТаблицы.Договор.КлиентПоставщик = СтрокаТаблицы.Клиент Тогда

					СтрокаТаблицы.Договор = ПредопределенноеЗначение("Справочник.Договора.ПустаяСсылка");
				КонецЕсли;
			КонецЦикла;

			Для Каждого СтрокаТаблицы Из МассивПустыхСтрок Цикл
				Расчеты.Удалить(СтрокаТаблицы);
			КонецЦикла;

			МассивПустыхСтрок = Новый Массив;

			Для Каждого СтрокаТаблицы Из РасчетыСПоставщиками Цикл
				Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.Поставщик) Тогда
					МассивПустыхСтрок.Добавить(СтрокаТаблицы);
				ИначеЕсли ЗначениеЗаполнено(СтрокаТаблицы.Договор)
					И НЕ СтрокаТаблицы.Договор.КлиентПоставщик = СтрокаТаблицы.Поставщик Тогда

					СтрокаТаблицы.Договор = ПредопределенноеЗначение("Справочник.Договора.ПустаяСсылка");
				КонецЕсли;
			КонецЦикла;

			Для Каждого СтрокаТаблицы Из МассивПустыхСтрок Цикл
				РасчетыСПоставщиками.Удалить(СтрокаТаблицы);
			КонецЦикла;

			МассивПустыхСтрок = Новый Массив;

			Для Каждого СтрокаТаблицы Из Деньги Цикл
				Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.ОстатокДенег) Тогда
					МассивПустыхСтрок.Добавить(СтрокаТаблицы);
				КонецЕсли;
			КонецЦикла;

			Для Каждого СтрокаТаблицы Из МассивПустыхСтрок Цикл
				Деньги.Удалить(СтрокаТаблицы);
			КонецЦикла;

			Если НЕ ВзаимозачетДолгаКонтрагентов Тогда
				Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("НеСворачиватьТоварыПоКоличествуВоВсехДокументах") Тогда
					Товары.Свернуть("Склад, Номенклатура, СерияНоменклатуры, ЕдиницаИзмерения, Цена, ОСтроке", "Количество, Сумма");
				КонецЕсли;

				МассивПустыхСтрок = Новый Массив;
				ВестиУчетПоСкладам = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетПоСкладам");
				Для Каждого СтрокаТовары Из Товары Цикл
					Если НЕ ЗначениеЗаполнено(СтрокаТовары.Номенклатура) Тогда
						МассивПустыхСтрок.Добавить(СтрокаТовары);
					ИначеЕсли ВестиУчетПоСкладам
						И НЕ ЗначениеЗаполнено(СтрокаТовары.Склад) Тогда

						Отказ = ИСТИНА;
						ТекстОшибки = ТекстОшибки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не во всех строках таблицы товары указан склад!");
						Попытка
							ТекстОшибки = ТекстОшибки + Символы.ПС + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Номер строки") + ": " + СтрокаТовары.НомерСтроки + Символы.пс;
						Исключение
						КонецПопытки;
						Прервать;
					КонецЕсли;
				КонецЦикла;

				Для Каждого СтрокаТовары Из МассивПустыхСтрок Цикл
					Товары.Удалить(СтрокаТовары);
				КонецЦикла;

				МассивПустыхСтрок = Новый Массив;

				Для Каждого СтрокаТаблицы Из Цены Цикл
					Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.Номенклатура) Тогда
						МассивПустыхСтрок.Добавить(СтрокаТаблицы);
					ИначеЕсли НЕ ЗначениеЗаполнено(СтрокаТаблицы.ВидЦен) Тогда
						Отказ = ИСТИНА;
						ТекстОшибки = ТекстОшибки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не во всех строках цен указан вид цен!");
						Попытка
							ТекстОшибки = ТекстОшибки + Символы.ПС + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Номер строки") + ": " + СтрокаТовары.НомерСтроки + Символы.пс;
						Исключение
						КонецПопытки;
						Прервать;
					КонецЕсли;
				КонецЦикла;

				Для Каждого СтрокаТаблицы Из МассивПустыхСтрок Цикл
					Цены.Удалить(СтрокаТаблицы);
				КонецЦикла;

				МассивПустыхСтрок = Новый Массив;

				Для Каждого СтрокаТовары Из Зарплата Цикл
					Если НЕ ЗначениеЗаполнено(СтрокаТовары.Сотрудник) Тогда
						МассивПустыхСтрок.Добавить(СтрокаТовары);
					КонецЕсли;
				КонецЦикла;

				Для Каждого СтрокаТовары Из МассивПустыхСтрок Цикл
					Зарплата.Удалить(СтрокаТовары);
				КонецЦикла;

				ОбщийМодульТоварСервер.ПроверитьИСортироватьТаблицуТовары(ЭтотОбъект);
				ТовараВКоличестве = Товары.Итог("Количество");

				Если ЗначениеЗаполнено(ВидЦен)
					И ЗначениеЗаполнено(ВидЦен.ВалютаЦены) Тогда

					ТовараНаСумму = ОбщийМодульСервер.ПоКурсу(Товары.Итог("Сумма"), ВидЦен.ВалютаЦены, , Дата);
				Иначе
					ТовараНаСумму = Товары.Итог("Сумма");
				КонецЕсли;
			Иначе  // взаимозачет
				ТовараНаСумму = Расчеты.Итог("Сумма") - РасчетыСПоставщиками.Итог("Сумма") + ОстатокДенег;
			КонецЕсли;

			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетДвиженияДенег")
				И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетДенегВНесколькихХранилищах")
				И ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВалют") Тогда

				Для Каждого СтрокаДенег Из Деньги Цикл
					Если НЕ СтрокаДенег.Валюта = ПредопределенноеЗначение("Справочник.Валюты.ОсновнаяВалюта") Тогда
						СтрокаДенег.ХранилищеДенег = ОбщийМодульПовтор.НайтиХранилищеДенегПоВалюте(СтрокаДенег.Валюта, СтрокаДенег.ХранилищеДенег);
					КонецЕсли;

				КонецЦикла;
			КонецЕсли;

			Если Отказ
				И НЕ ПустаяСтрока(ТекстОшибки) Тогда

				Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда
					ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ТекстОшибки, , Ссылка);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

	КонецПроцедуры

	Процедура ПриКопировании(ОбъектКопирования)
		Комментарий = "";
	КонецПроцедуры

#КонецЕсли
