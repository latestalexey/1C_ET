﻿// sza131020-2306 :

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура("ДокументСсылка", ПараметрКоманды);
	ОткрытьФорму("Отчет.ДвиженияДокумента.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);// , ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры
