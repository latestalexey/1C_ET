﻿//sza131004-2215 Русский: 

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//Вставить содержимое обработчика.
	ПараметрыФормы = Новый Структура("ДокументПланПродаж", ПараметрКоманды.Ссылка);
	ОткрытьФорму("Отчет.ПланФактныйАнализПродаж.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);//, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры
