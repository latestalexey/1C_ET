﻿// sza131227-0210 :

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ДокументДляПечати = Новый ТабличныйДокумент;
	ДокументДляПечати.ИмяПараметровПечати = "КАРТОЧКА_П";
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	Печать(ДокументДляПечати, ПараметрКоманды);
	ДокументДляПечати.ОтображатьСетку = ЛОЖЬ;
	ДокументДляПечати.Защита = ЛОЖЬ;
	ДокументДляПечати.ТолькоПросмотр = ЛОЖЬ;
	ДокументДляПечати.ОтображатьЗаголовки = ЛОЖЬ;
	ДокументДляПечати.Показать();

КонецПроцедуры

&НаСервере
Процедура Печать(ДокументДляПечати, ПараметрКоманды)
	Справочники.ПодсистемаИЭПоля.Печать(ДокументДляПечати, ПараметрКоманды);
КонецПроцедуры
