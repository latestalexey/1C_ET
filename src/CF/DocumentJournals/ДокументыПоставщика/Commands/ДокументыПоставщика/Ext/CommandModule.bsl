﻿//sza140110-2344 : 
//sza131023-1656 : 

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("Поставщик", ПараметрКоманды);
	ОткрытьФорму("ЖурналДокументов.ДокументыПоставщика.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);//, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры
