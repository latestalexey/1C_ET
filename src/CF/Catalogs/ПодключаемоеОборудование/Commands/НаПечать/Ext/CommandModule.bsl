﻿// sza140922-1530

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ТабДок = Новый ТабличныйДокумент;
	ТабДок.ИмяПараметровПечати = "ПО";
	ТабДок.КлючПараметровПечати = ТабДок.ИмяПараметровПечати;
	
	НаПечать(ТабДок, ПараметрКоманды);

	ТабДок.ОтображатьСетку = ЛОЖЬ;
	ТабДок.Защита = ЛОЖЬ;
	ТабДок.ТолькоПросмотр = ЛОЖЬ;
	ТабДок.ОтображатьЗаголовки = ЛОЖЬ;
	ТабДок.Показать();
	
КонецПроцедуры

&НаСервере
Процедура НаПечать(ТабДок, ПараметрКоманды)
	Справочники.ПодключаемоеОборудование.НаПечать(ТабДок, ПараметрКоманды);
КонецПроцедуры
