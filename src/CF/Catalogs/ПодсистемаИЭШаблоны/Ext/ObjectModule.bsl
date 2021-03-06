﻿// sza160221-0153
// sza140904-0256
// sza140118-1637 укр:
// sza110209-1639 ЭтоПлатежныйДокумент
// sza101222-1256
// sza101116-0101
// sza101110-1852
// sza101109-0209
// sza101104
// sza101020

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	Процедура ПередЗаписью(Отказ)

		Если НЕ ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("МассоваяЗагрузка", ИСТИНА)
			И НЕ ЭтоГруппа Тогда

			ФорматФайлаDBF = ПодсистемаИЭ.ШаблонФайлаФорматФайлаDBF(ЭтотОбъект);
			КлючевоеДляПоискаИЗаписи = ЛОЖЬ;
			Для Каждого ПолеПоследовательности Из ПоследовательностьПолейВФайле Цикл

				Если ФорматФайлаDBF
					И ПолеПоследовательности.ИмяПоляВФайле = "" Тогда

					ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не указано имя поля в файле ДБФ!"), ЭтотОбъект);
				КонецЕсли;

				Если ПолеПоследовательности.ДанноеПолеКлючевоеДляПоискаИЗаписи Тогда
					КлючевоеДляПоискаИЗаписи = ИСТИНА;
				КонецЕсли;
			КонецЦикла;

			Если НЕ КлючевоеДляПоискаИЗаписи Тогда
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Не установлено ключевое поле!"), ЭтотОбъект);
			КонецЕсли;

			Если ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляОбменаСБанком Тогда
				ЭтоПлатежныйДокумент = ИСТИНА;
			Иначе
				ЭтоПлатежныйДокумент = ЛОЖЬ;
			КонецЕсли;

			Если НомерПоляКотороеВсегдаЗаполнено = 0 Тогда
				НомерПоляКотороеВсегдаЗаполнено = 1;
			КонецЕсли;

			Если РазделительПолей = "" Тогда
				РазделительПолей = ";";
			КонецЕсли;

			Если СокрЛП(КодировкаФайла) = "" Тогда
				КодировкаФайла = "ANSI";
			КонецЕсли;

			ТекстПроизвольногоЗапроса = СтрЗаменить(ТекстПроизвольногоЗапроса, "|", " ");
		КонецЕсли;

	КонецПроцедуры

#КонецЕсли
