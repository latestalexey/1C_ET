﻿//sza140119-0207
//sza130920-1735 : 

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Если Не Отказ Тогда
		
		ОбщийМодульСервер.УдалитьСвязанныеЦены(Ссылка);
		
		Товары.Свернуть("Номенклатура, Цена, СтараяЦена, РазницаЦены", "Комментарий");
		
		массивпустыхстрок  = новый массив;
		массивноменклатуры = Новый массив;
		
		для каждого СтрокаТовары из товары цикл
			Если НЕ ЗначениеЗаполнено(СтрокаТовары.Номенклатура) Тогда
				массивпустыхстрок.Добавить(СтрокаТовары);
				
			иначеесли не СтрокаТовары.РазницаЦены = 0
				и не массивноменклатуры.Найти(СтрокаТовары.Номенклатура) = Неопределено тогда
				
				если ОбщийМодульПовторВТеченииСервера.ВыводитьСообщенияМожно() тогда
					//Сообщение = Новый СообщениеПользователю;
					//Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("На строке №") + " " + СтрокаТовары.НомерСтроки + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке(" повторяется номенклатура:" + СтрокаТовары.Номенклатура);
					//Сообщение.Сообщить();	
					ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("На строке №") + " " + СтрокаТовары.НомерСтроки + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("повторяется номенклатура:" + СтрокаТовары.Номенклатура), , Ссылка);
				КонецЕсли;
				Отказ = истина;			
				
			иначе
				массивноменклатуры.Добавить(СтрокаТовары.Номенклатура);
				
			КонецЕсли;                                    	
		КонецЦикла;
		
		если не отказ тогда
			для каждого СтрокаТовары из массивпустыхстрок цикл
				товары.Удалить(СтрокаТовары);	
			КонецЦикла;	
			
			Если ОбщийМодульПовтор.ПолучитьПараметрСеанса("ИспользоватьСложныйМеханизмЦенПС")
				И ЗначениеЗаполнено(ВидЦен) тогда
				
				Для каждого СтрокаЦен Из Товары Цикл
					
					Если ЗначениеЗаполнено(СтрокаЦен.Номенклатура) 
						и не СтрокаЦен.Цена = СтрокаЦен.СтараяЦена Тогда
						
						ОбщийМодульСервер.УстановитьЦенуИВсеЗависимые(ВидЦен, СтрокаЦен, Ссылка, Комментарий, Дата);
						
					КонецЕсли;			
				КонецЦикла; 	
			КонецЕсли; 	
		КонецЕсли;	
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаУдаленияПроведения(Отказ)
	
	Если Не Отказ Тогда
		ОбщийМодульСервер.УдалитьСвязанныеЦены(Ссылка);	
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(ДанныеЗаполнения) Тогда
		Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ПеремещенияТовара") Тогда
			ВидЦен = ДанныеЗаполнения.ВидЦен;
			Комментарий = ДанныеЗаполнения.Комментарий;
			Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;
				НоваяСтрока.Цена = ТекСтрокаТовары.Цена;
			КонецЦикла;
			
		ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ПоступленияТовара") Тогда
			ВидЦен = ДанныеЗаполнения.ВидЦен;
			Комментарий = ДанныеЗаполнения.Комментарий;
			Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;
				НоваяСтрока.Цена = ТекСтрокаТовары.Цена;
			КонецЦикла;
			
		ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.РасходыТовара") Тогда
			ВидЦен = ДанныеЗаполнения.ВидЦен;
			Комментарий = ДанныеЗаполнения.Комментарий;
			Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;
				НоваяСтрока.Цена = ТекСтрокаТовары.Цена;
			КонецЦикла;
			
		ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Инвентаризации") Тогда
			ВидЦен = ДанныеЗаполнения.ВидЦен;
			Комментарий = ДанныеЗаполнения.Комментарий;
			Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;
				НоваяСтрока.Цена = ТекСтрокаТовары.Цена;
			КонецЦикла;
			
		ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.КорректировкиИРегистрацияОстатков") Тогда
			ВидЦен = ДанныеЗаполнения.ВидЦен;
			Комментарий = ДанныеЗаполнения.Комментарий;
			Для Каждого ТекСтрокаТовары Из ДанныеЗаполнения.Товары Цикл
				НоваяСтрока = Товары.Добавить();
				НоваяСтрока.Номенклатура = ТекСтрокаТовары.Номенклатура;
				НоваяСтрока.Цена = ТекСтрокаТовары.Цена;
			КонецЦикла;
		КонецЕсли;	
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	если не отказ 
		и товары.итог("Цена") = 0     // или товары.итог("разница") = 0 ?
		и РежимЗаписи = РежимЗаписиДокумента.Проведение тогда
		
		РежимЗаписи = РежимЗаписиДокумента.Запись;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	ЭтотОбъект.комментарий = "";
КонецПроцедуры
