﻿// sza151210-2337 про
// sza150111-0523 НЧ
// sza140701-1320
// sza140610-1354
// sza130915-1930 :

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Функция   ОбработатьДвиженияДляНабора(Отказ, Номенклатура, КоличествоСтруктура, Сумма = 0, ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка, ПоведениеПрограммыПриРасходеТоваровБезОстатка) // для вложенных наборов

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

		Для Каждого СтрокаСоставаНабора Из Номенклатура.Состав цикл
			НоменклатураСостава = СтрокаСоставаНабора.Номенклатура;
			Количество = КоличествоСтруктура * СтрокаСоставаНабора.Количество * ?(ЗначениеЗаполнено(СтрокаСоставаНабора.ЕдиницаИзмерения), СтрокаСоставаНабора.ЕдиницаИзмерения.Количество, 1);
			СуммаЭлемента = 0; // СуммаЭлемента при перемещении пренебречь

			Если ОбщийМодульПовтор.ЭтоНабор(НоменклатураСостава) Тогда
				ОбработатьДвиженияДляНабора(Отказ, НоменклатураСостава, КоличествоСтруктура * СтрокаСоставаНабора.количество, СуммаЭлемента, ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка, ПоведениеПрограммыПриРасходеТоваровБезОстатка);
			Иначе

				ЭлементПредопределенный = ОбщийМодульПовтор.ТоварНеУчитываетсяПоКоличеству(НоменклатураСостава);

				Если НЕ ЭлементПредопределенный Тогда
					Отказ = ОбщийМодульСервер.ПроверитьОстатокТоваров(ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка, ПоведениеПрограммыПриРасходеТоваровБезОстатка, Склад, НоменклатураСостава, Количество, Дата, ИСТИНА, , Ссылка);
					Если НЕ Отказ Тогда
						ЦенаСписания  	= ОбщийМодульСервер.ПолучитьЦенуСписания(НоменклатураСостава, Количество, Дата, , , Склад);
						СуммаСписания 	= ЦенаСписания * Количество;
						Движение = Движения.Товары.Добавить();
						Движение.Количество 	= Количество;
						Движение.ВидДвижения 	= ВидДвиженияНакопленияРасход;
						Движение.Период 		= Дата;
						Движение.Номенклатура 	= НоменклатураСостава;
						Движение.Склад 			= Склад;
						Движение.ВнутреннееПеремещение = ИСТИНА;
						Движение.Сумма 			= СуммаСписания;
						Движение = Движения.Товары.Добавить();
						Движение.ВидДвижения 	= ВидДвиженияНакопленияПриход;
						Движение.Период 		= Дата;
						Движение.Номенклатура 	= НоменклатураСостава;
						Движение.Склад 			= СкладКуда;
						Движение.Количество	 	= Количество;
						Движение.Сумма			= СуммаСписания;
						Движение.ВнутреннееПеремещение = ИСТИНА;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;

		КонецЦикла;

		Возврат Отказ;

	КонецФункции

	Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)

		Если ЗначениеЗаполнено(ДанныеЗаполнения) Тогда
			Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ПоступленияТовара") Тогда
				Комментарий 		= ДанныеЗаполнения.Комментарий;
				Склад 				= ДанныеЗаполнения.Склад;
				ВидЦен 				= ДанныеЗаполнения.ВидЦен;
				ТовараВКоличестве 	= ДанныеЗаполнения.ТовараВКоличестве;
				ТовараНаСумму 		= ДанныеЗаполнения.ТовараНаСумму;
				НаправлениеДеятельности = ДанныеЗаполнения.НаправлениеДеятельности;

				Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
					НоваяСтрока = Товары.Добавить();
					НоваяСтрока.Номенклатура 	= ТекСтрокаТовара.Номенклатура;
					НоваяСтрока.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
					НоваяСтрока.ЕдиницаИзмерения  = ТекСтрокаТовара.ЕдиницаИзмерения;
					НоваяСтрока.Количество 		= ТекСтрокаТовара.Количество;
					НоваяСтрока.Цена 			= ТекСтрокаТовара.Цена;
					НоваяСтрока.Сумма 			= ТекСтрокаТовара.Сумма;
					НоваяСтрока.ОСтроке			= ТекСтрокаТовара.ОСтроке;

				КонецЦикла;
			ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.События") Тогда
				Комментарий 		= ДанныеЗаполнения.Комментарий;
				ВидЦен 				= ДанныеЗаполнения.ВидЦен;
				ТовараВКоличестве 	= ДанныеЗаполнения.ТовараВКоличестве;
				ТовараНаСумму 		= ДанныеЗаполнения.ТовараНаСумму;
				НаправлениеДеятельности = ДанныеЗаполнения.Направление;

				Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
					НоваяСтрока = Товары.Добавить();
					НоваяСтрока.Номенклатура 	= ТекСтрокаТовара.Номенклатура;
					НоваяСтрока.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
					НоваяСтрока.Количество 		= ТекСтрокаТовара.Количество;
					НоваяСтрока.Цена 			= ТекСтрокаТовара.Цена;
					НоваяСтрока.Сумма 			= НоваяСтрока.Цена * НоваяСтрока.Количество ;
					НоваяСтрока.ОСтроке			= НоваяСтрока.ОСтроке;

				КонецЦикла;
			ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.КорректировкиИРегистрацияОстатков") Тогда
				Комментарий 		= ДанныеЗаполнения.Комментарий;
				ВидЦен 				= ДанныеЗаполнения.ВидЦен;
				ТовараВКоличестве 	= ДанныеЗаполнения.ТовараВКоличестве;
				ТовараНаСумму 		= ДанныеЗаполнения.ТовараНаСумму;
				НаправлениеДеятельности = ДанныеЗаполнения.НаправлениеДеятельности;

				Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
					НоваяСтрока = Товары.Добавить();
					НоваяСтрока.Номенклатура 	= ТекСтрокаТовара.Номенклатура;
					НоваяСтрока.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
					НоваяСтрока.ЕдиницаИзмерения  = ТекСтрокаТовара.ЕдиницаИзмерения;
					НоваяСтрока.Количество 		= ТекСтрокаТовара.Количество;
					НоваяСтрока.Цена 			= ТекСтрокаТовара.Цена;
					НоваяСтрока.Сумма 			= НоваяСтрока.Цена * НоваяСтрока.Количество ;

				КонецЦикла;
			ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.УстановкиЦен") Тогда
				Комментарий = ДанныеЗаполнения.Комментарий;
				ВидЦен 		= ДанныеЗаполнения.ВидЦен;

				Для Каждого ТекСтрокаТовара Из ДанныеЗаполнения.Товары Цикл
					НоваяСтрока = Товары.Добавить();
					НоваяСтрока.Количество 		= 1;
					НоваяСтрока.Номенклатура 	= ТекСтрокаТовара.Номенклатура;
					НоваяСтрока.ЕдиницаИзмерения= ТекСтрокаТовара.ЕдиницаИзмерения;
					НоваяСтрока.Цена 			= ТекСтрокаТовара.Цена;
					НоваяСтрока.Сумма 			= НоваяСтрока.Цена *НоваяСтрока.Количество;

				КонецЦикла;
			КонецЕсли;

			ТовараВКоличестве 	= Товары.Итог("Количество");
			ТовараНаСумму 		= Товары.Итог("Сумма");
		КонецЕсли;

	КонецПроцедуры

	Процедура ОбработкаПроведения(Отказ, Режим)

		Если НеПроводить Тогда
			НеПроводить = ЛОЖЬ;
			Записать(РежимЗаписиДокумента.Запись);
		Иначе
			Если НЕ Отказ Тогда

				Движения.Товары.Записать();
				Движения.ВнутренниеЗаказыТоваров.Записать();
				Если НЕ Сторный Тогда
					ВидДвиженияНакопленияПриход = ВидДвиженияНакопления.Приход;
					ВидДвиженияНакопленияРасход = ВидДвиженияНакопления.Расход;
				Иначе
					ВидДвиженияНакопленияПриход = ВидДвиженияНакопления.Расход;
					ВидДвиженияНакопленияРасход = ВидДвиженияНакопления.Приход;
				КонецЕсли;

				ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка");
				ПоведениеПрограммыПриРасходеТоваровБезОстатка = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПоведениеПрограммыПриРасходеТоваровБезОстатка");
				ОстаткиСледуетПроверять = (ЗначениеЗаполнено(ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка)
				И НЕ ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка = Перечисления.ИгнорироватьРазрешитьЗапретить.Игнорировать )
				ИЛИ (ЗначениеЗаполнено(ПоведениеПрограммыПриРасходеТоваровБезОстатка)
				И НЕ ПоведениеПрограммыПриРасходеТоваровБезОстатка = Перечисления.ИгнорироватьРазрешитьЗапретить.Игнорировать);
				СтруктураТаблиц 	= ОбщийМодульСервер.ПолучитьТаблицыЦенСписанияИОстатков(Ссылка, склад, дата, ОстаткиСледуетПроверять);
				ТаблицаЦенСписания  = СтруктураТаблиц.ТаблицаЦенСписания;

				Если ОстаткиСледуетПроверять Тогда
					ГотоваяТаблицаОстатков = СтруктураТаблиц.ТаблицаОстатков;
				КонецЕсли;

				ИспользуетсяСкладВПути = ЗначениеЗаполнено(ДатаПрибытия) и не ДатаПрибытия = дата и ЗначениеЗаполнено(СкладВПути);
				ДатаПоступления = ?(ИспользуетсяСкладВПути, ДатаПрибытия, Дата);
				ВестиУчетВнутреннихЗаказов = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ВестиУчетВнутреннихЗаказов");
				Если ВестиУчетВнутреннихЗаказов Тогда
					СтруктураТаблиц = ОбщийМодульСервер.ПолучитьТаблицуОстатковВнутреннихЗаказов(Ссылка, Склад, ДатаПоступления);
					ТаблицаВнутреннихЗаказов = СтруктураТаблиц.ТаблицаВнутреннихЗаказов;
				КонецЕсли;

				Для Каждого ТекСтрокаТовара Из Товары Цикл
					Номенклатура = ТекСтрокаТовара.Номенклатура;
					НоменклатураПредопределенный = ОбщийМодульПовтор.ТоварНеУчитываетсяПоКоличеству(Номенклатура);
					КомментарийСтроки = ?(ЗначениеЗаполнено(ТекСтрокаТовара.ОСтроке), ТекСтрокаТовара.ОСтроке, Комментарий);
					Количество = ?(ЗначениеЗаполнено(ТекСтрокаТовара.ЕдиницаИзмерения), ТекСтрокаТовара.ЕдиницаИзмерения.Количество * ТекСтрокаТовара.Количество, ТекСтрокаТовара.Количество);
					СуммаОстаток 	  = 0;
					КоличествоОстаток = 0;

					Если ОстаткиСледуетПроверять Тогда
						СтрокаОстаток = ГотоваяТаблицаОстатков.найти(номенклатура, "Номенклатура");
						Если НЕ СтрокаОстаток = Неопределено Тогда
							КоличествоОстаток = СтрокаОстаток.КоличествоОстаток;
							СуммаОстаток = СтрокаОстаток.СуммаОстаток;
						КонецЕсли;
					КонецЕсли;

					Если ОстаткиСледуетПроверять
						И НЕ НоменклатураПредопределенный
						И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПриАвтоматическомПерепроведенииДокументовОтменитьПроверкиНаОтказ") Тогда

						Отказ = ОбщийМодульСервер.ПроверитьОстатокТоваров(ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка, ПоведениеПрограммыПриРасходеТоваровБезОстатка, Склад, Номенклатура, ТекСтрокаТовара.Количество, Дата, ИСТИНА, КоличествоОстаток, Ссылка);
					КонецЕсли;

					Если НЕ Отказ Тогда
						Если ОбщийМодульПовтор.ЭтоНабор(Номенклатура) Тогда
							Отказ = ОбработатьДвиженияДляНабора(Отказ, Номенклатура, Количество, ТекСтрокаТовара.Сумма, ПоведениеПрограммыПриРасходеТоваровНижеРекомендованногоМинимальногоОстатка, ПоведениеПрограммыПриРасходеТоваровБезОстатка);
						ИначеЕсли НЕ НоменклатураПредопределенный Тогда
							СтруктураОстатка = Новый Структура;
							СтруктураОстатка.Вставить("Количество", КоличествоОстаток);
							СтруктураОстатка.Вставить("Сумма", СуммаОстаток);
							Движение = Движения.Товары.Добавить();
							Движение.Количество 	= Количество;
							Движение.ВидДвижения 	= ВидДвиженияНакопленияРасход;
							Движение.Период 		= Дата;
							Движение.Номенклатура 	= Номенклатура;
							Движение.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
							Движение.Склад 			= Склад;
							Движение.Комментарий	= КомментарийСтроки;
							Движение.ВнутреннееПеремещение = ИСТИНА;

							Если НЕ ТаблицаЦенСписания = Неопределено Тогда
								СтрокаЦеныСписания = ТаблицаЦенСписания.найти(номенклатура, "Номенклатура");
								Если НЕ СтрокаЦеныСписания = Неопределено Тогда
									ЦенаСписания = СтрокаЦеныСписания.Цена;
								Иначе
									ЦенаСписания = ОбщийМодульСервер.ПолучитьЦенуНаСервере(номенклатура, ИСТИНА, дата, ЛОЖЬ, , , , , Ссылка, , ТекСтрокаТовара.ЕдиницаИзмерения);
								КонецЕсли;
							Иначе
								ЦенаСписания = ОбщийМодульСервер.ПолучитьЦенуНаСервере(номенклатура, ИСТИНА, дата, ЛОЖЬ, , , , , Ссылка, , ТекСтрокаТовара.ЕдиницаИзмерения);
							КонецЕсли;

							СуммаСписания = ЦенаСписания * ТекСтрокаТовара.Количество;
							Движение.Сумма = СуммаСписания;
							Если ИспользуетсяСкладВПути Тогда
								Движение = Движения.Товары.Добавить();
								Движение.ВидДвижения 	= ВидДвиженияНакопленияПриход;
								Движение.Период 		= Дата;
								Движение.Номенклатура 	= Номенклатура;
								Движение.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
								Движение.Склад 			= СкладВПути;
								Движение.Количество 	= Количество;
								Движение.Сумма 			= СуммаСписания;
								Движение.Комментарий	= КомментарийСтроки;
								Движение.ВнутреннееПеремещение = ИСТИНА;
								Движение = Движения.Товары.Добавить();
								Движение.ВидДвижения 	= ВидДвиженияНакопленияРасход;
								Движение.Период 		= ДатаПрибытия;
								Движение.Номенклатура 	= Номенклатура;
								Движение.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
								Движение.Склад 			= СкладВПути;
								Движение.Количество 	= Количество;
								Движение.Сумма 			= СуммаСписания;
								Движение.Комментарий	= КомментарийСтроки;
								Движение.ВнутреннееПеремещение = ИСТИНА;
							КонецЕсли;

							Движение = Движения.Товары.Добавить();
							Движение.ВидДвижения 	= ВидДвиженияНакопленияПриход;
							Движение.Период 		= ДатаПоступления;
							Движение.Номенклатура 	= Номенклатура;
							Движение.СерияНоменклатуры = ТекСтрокаТовара.СерияНоменклатуры;
							Движение.Склад 			= СкладКуда;
							Движение.Количество 	= Количество;
							Движение.Сумма 			= СуммаСписания;
							Движение.Комментарий	= КомментарийСтроки;
							Движение.ВнутреннееПеремещение = ИСТИНА;
						КонецЕсли;
					КонецЕсли;

				КонецЦикла;

				Если ВестиУчетВнутреннихЗаказов Тогда
					ТолькоТовары = Новый ТаблицаЗначений;
					ТолькоТовары.Колонки.Добавить("Номенклатура");
					ТолькоТовары.Колонки.Добавить("Количество");

					Для Каждого СтрокаТаблицыИсточника Из Товары Цикл
						СтрокаТаблицыПриемника = ТолькоТовары.Добавить();
						СтрокаТаблицыПриемника.Номенклатура = СтрокаТаблицыИсточника.Номенклатура;
						СтрокаТаблицыПриемника.Количество = ?(ЗначениеЗаполнено(СтрокаТаблицыИсточника.ЕдиницаИзмерения), СтрокаТаблицыИсточника.ЕдиницаИзмерения.Количество * СтрокаТаблицыИсточника.Количество, СтрокаТаблицыИсточника.Количество);

					КонецЦикла;

					ТолькоТовары.Свернуть("Номенклатура", "Количество");
					Для Каждого ТекСтрокаТовара Из ТолькоТовары Цикл
						Номенклатура = ТекСтрокаТовара.Номенклатура;
						Количество 	 = ТекСтрокаТовара.Количество;
						СтрокаСписанияВнутреннегоЗаказа = ТаблицаВнутреннихЗаказов.Найти(Номенклатура, "Номенклатура");

						Если НЕ СтрокаСписанияВнутреннегоЗаказа = Неопределено Тогда
							КоличествоНедополученнойРанее = СтрокаСписанияВнутреннегоЗаказа.Количество;
							Если КоличествоНедополученнойРанее > 0 Тогда
								Если КоличествоНедополученнойРанее > Количество Тогда
									КоличествоКСписанию = Количество;
								Иначе
									КоличествоКСписанию = КоличествоНедополученнойРанее;
								КонецЕсли;

								Движение = Движения.ВнутренниеЗаказыТоваров.Добавить();
								Движение.Количество 	= КоличествоКСписанию;
								Движение.ВидДвижения 	= ВидДвиженияНакопленияРасход;
								Движение.Период 		= ДатаПоступления;
								Движение.Номенклатура 	= Номенклатура;
								Движение.Склад 			= СкладКуда;
							КонецЕсли;
						КонецЕсли;

					КонецЦикла;
				КонецЕсли;
			КонецЕсли;

			Движения.Товары.Записывать = НЕ Отказ;
			Движения.ВнутренниеЗаказыТоваров.Записывать = НЕ Отказ;
		КонецЕсли;

	КонецПроцедуры

	Процедура ОбработкаУдаленияПроведения(Отказ)

		Если НЕ Отказ Тогда
			Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("000811", , Отказ, ЭтотОбъект);
		КонецЕсли;

	КонецПроцедуры

	Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

		Если ОбменДанными.Загрузка Тогда
			Возврат;
		КонецЕсли;

		Если НЕ Отказ
			И НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА) Тогда

			Если Модифицированность() Тогда
				Если ДатаПрибытия < Дата Тогда
					ДатаПрибытия = Дата;
				КонецЕсли;

				Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
					Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ПриАвтоматическомПерепроведенииДокументовОтменитьПроверкиНаОтказ") Тогда
						ПодготовкаКПроведению(Отказ);
					КонецЕсли;

					Если ТовараВКоличестве = 0
						И РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда

						РежимЗаписи = РежимЗаписиДокумента.Запись;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;

			Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ФормироватьОписаниеТаблицОбъектовДляИхСписков") Тогда
				ОбщийМодульСервер.ОформитьОписаниеТаблицы(ЭтотОбъект);
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

			ИспользоватьЕдиницыИзмеренияНоменклатуры = ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьЕдиницыИзмеренияНоменклатуры");

			Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("НеСворачиватьТоварыПоКоличествуВоВсехДокументах") Тогда
				Товары.Свернуть("Номенклатура, СерияНоменклатуры, Цена, ЕдиницаИзмерения, ОСтроке", "Количество, Сумма");
			КонецЕсли;

			МассивПустыхСтрок 	= Новый Массив;
			МассивНоменклатуры 	= Новый Массив;
			Для Каждого СтрокаТовары Из Товары цикл
				НоменклатураСтроки = СтрокаТовары.Номенклатура;

				Если ИспользоватьЕдиницыИзмеренияНоменклатуры
					И ЗначениеЗаполнено(СтрокаТовары.ЕдиницаИзмерения) Тогда

					НоменклатураПовторяется = НЕ МассивНоменклатуры.Найти(СтрокаТовары.ЕдиницаИзмерения) = Неопределено;
				Иначе
					НоменклатураПовторяется = НЕ МассивНоменклатуры.Найти(НоменклатураСтроки) = Неопределено;
				КонецЕсли;

				Если НЕ ЗначениеЗаполнено(НоменклатураСтроки) Тогда
					МассивПустыхСтрок.Добавить(СтрокаТовары);
				ИначеЕсли НоменклатураСтроки.НеОтслеживатьОстаток Тогда
					Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда
						ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("В строке") + " № " + СтрокаТовары.НомерСтроки + символы.ПС + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("попытка перенести номенклатуру, которая не учитывается по количеству") + ": " + НоменклатураСтроки, , Ссылка);
					КонецЕсли;

					Отказ = ИСТИНА;
				ИначеЕсли НоменклатураПовторяется Тогда
					Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда
						ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("В строке") + " № " + СтрокаТовары.НомерСтроки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("повторяется номенклатура") + ": " + НоменклатураСтроки, , Ссылка);
					КонецЕсли;
				ИначеЕсли НЕ НоменклатураСтроки.СерийныйУчет Тогда

					Если ИспользоватьЕдиницыИзмеренияНоменклатуры
						И ЗначениеЗаполнено(СтрокаТовары.ЕдиницаИзмерения) Тогда

						МассивНоменклатуры.Добавить(СтрокаТовары.ЕдиницаИзмерения);
					Иначе
						МассивНоменклатуры.Добавить(НоменклатураСтроки);
					КонецЕсли;
				КонецЕсли;

			КонецЦикла;

			Если НЕ Отказ Тогда
				Для Каждого СтрокаТовары Из МассивПустыхСтрок цикл
					Товары.Удалить(СтрокаТовары);
				КонецЦикла;

				Если Склад = СкладКуда Тогда
					Если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() Тогда
						ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Нельзя выбирать в качестве источника и получателя один склад!"), , Ссылка);
					КонецЕсли;

					Отказ = ИСТИНА;
				Иначе
					Попытка // ЭтотОбъект
						ОбщийМодульТоварСервер.ПроверитьИСортироватьТаблицуТовары(ЭтотОбъект);
					Исключение
					КонецПопытки;
					ТовараВКоличестве = Товары.Итог("Количество");

					Если ЗначениеЗаполнено(ВидЦен) Тогда
						ТовараНаСумму = ОбщийМодульСервер.ПоКурсу(Товары.Итог("Сумма"), , ВидЦен.ВалютаЦены, Дата);
					Иначе
						ТовараНаСумму = товары.Итог("Сумма");
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;

	КонецПроцедуры

	Процедура ПриКопировании(ОбъектКопирования)
		Комментарий = "";
	КонецПроцедуры

#КонецЕсли
