﻿// sza140411-1606 :
// sza101109-1811
// sza101025

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", , , );

	Если НЕ Отказ Тогда
		ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выгрузил таблицу документа в файл"), 2, ПараметрКоманды);
		ПодсистемаИЭКлиент.ИмпортЭкспортОбработкаОбмена(
		ПодсистемаИЭКлиент.СоздатьСтруктуруВызоваИмпЭкспОперации(ПараметрКоманды,, ИСТИНА,, "К")
		); // Экспорт  (ИСТИНА) /Импорт (ЛОЖЬ, К/С/З - карточка, список, Товары
	КонецЕсли;

КонецПроцедуры
