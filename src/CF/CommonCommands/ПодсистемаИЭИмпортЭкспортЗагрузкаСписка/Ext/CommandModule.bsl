﻿//sza101117-1528       
//sza101116-0219       
//sza101109-1808       
//sza101025

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОбщийМодульКлиент.ДобавитьСобытиеЖурнала(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Загрузил список из файла"), 2, ПараметрКоманды);
	ПодсистемаИЭИмпортЭкспортФСКлиент.ИмпортЭкспортОбработкаОбмена(
	ПодсистемаИЭИмпортЭкспортФСКлиент.СоздатьСтруктуруВызоваИмпЭкспОперации(ПараметрКоманды,, Ложь,, "С")
	); //Экспорт  (Истина) /Импорт (ложь), К/С/З - карточка, список, Товары 
	
КонецПроцедуры
