﻿// sza101117-1521
// sza101116-0219
// sza101111-1458
// sza101109-0200
// sza101104
// sza101025

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", , , );

	Если НЕ Отказ Тогда
	ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выгрузил список в файл"), 2, ПараметрКоманды);
	ПодсистемаИЭКлиент.ИмпортЭкспортОбработкаОбмена(
	ПодсистемаИЭКлиент.СоздатьСтруктуруВызоваИмпЭкспОперации(ПараметрКоманды,, ИСТИНА,, "С", "LISTofALL")
	); // Экспорт  (ИСТИНА) /Импорт (ЛОЖЬ, К/С/З - карточка, список, Товары
	КонецЕсли;

КонецПроцедуры
