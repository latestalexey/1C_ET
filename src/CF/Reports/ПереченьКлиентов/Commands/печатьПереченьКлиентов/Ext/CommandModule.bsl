﻿// sza130927-1506 :

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	// Вставить содержимое обработчика.
	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("Отчет.ПереченьКлиентов.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);// , ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры
