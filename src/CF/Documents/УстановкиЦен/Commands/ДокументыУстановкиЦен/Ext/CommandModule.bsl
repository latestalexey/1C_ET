﻿// sza140420-1542
// sza131025-1550 :

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002350", , , );

	Если НЕ Отказ Тогда
		ПараметрыФормы = Новый Структура("", );
		ОткрытьФорму("Документ.УстановкиЦен.ФормаСписка", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);// , ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	КонецЕсли;

КонецПроцедуры
