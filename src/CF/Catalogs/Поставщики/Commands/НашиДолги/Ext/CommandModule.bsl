﻿// sza130917-1535 :

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("Справочник.Поставщики.Форма.ПоставщикиСДолгамиИлиПереплатой", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);// , ПараметрыВыполненияКоманды.НавигационнаяСсылка);

КонецПроцедуры
