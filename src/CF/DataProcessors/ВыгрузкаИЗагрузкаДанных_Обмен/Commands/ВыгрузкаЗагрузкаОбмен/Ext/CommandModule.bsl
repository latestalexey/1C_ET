﻿//sza131022-0144 Хозяин: 

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//Вставить содержимое обработчика.
	ПараметрыФормы = Новый Структура("", );
	ОткрытьФорму("Обработка.ВыгрузкаИЗагрузкаДанных_Обмен.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);//, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры
