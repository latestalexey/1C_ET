﻿//sza140118-1637 укр: 
//sza110209-1639 ЭтоПлатежныйдокумент
//sza101222-1256       
//sza101116-0101       
//sza101110-1852       
//sza101109-0209       
//sza101104
//sza101020
Процедура ПередЗаписью(Отказ)
	
	Если не ЭтотОБъект.ЭтоГруппа Тогда
		Если ПодсистемаИЭИмпортЭкспортФС.ШаблонФайлаФорматФайлаDBF(ЭтотОбъект) Тогда
			для каждого ПолеПоследовательности из ЭтотОбъект.ПоследовательностьПолейВФайле Цикл
				
				Если ПолеПоследовательности.ИмяПоляВФайле = "" Тогда
					Сообщение = Новый СообщениеПользователю;
					Сообщение.Текст = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не указано имя поля в файле ДБФ!");
					Сообщение.Поле  = ПоследовательностьПолейВФайле;
					Сообщение.УстановитьДанные(ЭтотОбъект);
					Сообщение.Сообщить();					
					
					ОбщийМодульСервисСервер.ДобавитьСообщениеПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не указано имя поля в файле ДБФ!"));
				КонецЕсли;
				
			КонецЦикла;
		КонецЕсли;
		
		Если ЭтотОбъект.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляОбменаСБанком Тогда
			ЭтотОбъект.ЭтоПлатежныйдокумент = Истина;
		Иначе
			ЭтотОбъект.ЭтоПлатежныйдокумент = Ложь;
		КонецЕсли;
		
		Если ЭтотОБъект.НомерПоляКотороеВсегдаЗаполнено = 0 Тогда
			ЭтотОБъект.НомерПоляКотороеВсегдаЗаполнено = 1;
		КонецЕсли;	
		
		Если ЭтотОбъект.РазделительПолей = "" Тогда
			ЭтотОбъект.РазделительПолей = ";";
		КонецЕсли;
		
		Если СокрЛП(ЭтотОбъект.КодировкаФайла) = "" Тогда
			ЭтотОбъект.КодировкаФайла = "ANSI";
		КонецЕсли;	
	КонецЕсли;
	
КонецПроцедуры
