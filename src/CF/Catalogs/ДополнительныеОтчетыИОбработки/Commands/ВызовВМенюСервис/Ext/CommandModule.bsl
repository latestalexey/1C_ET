﻿// sza151218-1914

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ОбработкаДляСервис = ОбщийМодульСервисСервер.ОпределитьОбработкуДляМенюСервис();

	Если ЗначениеЗаполнено(ОбработкаДляСервис) Тогда
		ОбщийМодульКлиент.ВыполнитьОбработкуПоПараметрам(ОбработкаДляСервис);
	КонецЕсли;

КонецПроцедуры
