﻿//sza131024-2044 

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("Документ.КорректировкиИРегистрацияОстатков.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);//, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры
