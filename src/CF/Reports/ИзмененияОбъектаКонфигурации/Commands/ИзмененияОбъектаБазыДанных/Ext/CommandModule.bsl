﻿// sza150619-0615

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура("ОбъектБазыДанных", ПараметрКоманды);
	ОткрытьФорму("Отчет.ИзмененияОбъектаКонфигурации.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник);//, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры
