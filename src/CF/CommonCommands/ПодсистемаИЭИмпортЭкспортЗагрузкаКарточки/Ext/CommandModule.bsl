﻿//sza101117-1527       
//sza101109-1806       
//sza101025

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Загрузил карточку из файла"), 2, ПараметрКоманды.Ссылка);
	ПодсистемаИЭИмпортЭкспортФСКлиент.ИмпортЭкспортОбработкаОбмена(
	ПодсистемаИЭИмпортЭкспортФСКлиент.СоздатьСтруктуруВызоваИмпЭкспОперации(ПараметрКоманды,, Ложь,, "К")
	); //Экспорт  (Истина) /Импорт (ложь), К/С/З - карточка, список, Товары 
	
КонецПроцедуры