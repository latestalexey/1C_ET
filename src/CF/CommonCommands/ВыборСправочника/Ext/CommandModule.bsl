﻿// sza140723-2226

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("ОбщаяФорма.ВыборСправочника", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно); // , ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры
