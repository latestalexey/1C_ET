﻿// sza150210-0244

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура("Номенклатура", ПараметрКоманды);
	ОткрытьФорму("Отчет.ИсторияЦенНоменклатуры.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);// , ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры
