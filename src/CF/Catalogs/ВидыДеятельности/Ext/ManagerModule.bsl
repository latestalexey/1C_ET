﻿// sza160128-0135

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)

	Если ОбщийМодульПовтор.ВывестиНаименованияНаДругомЯзыке() Тогда
		ВозможноеПредставление = ОбщийМодульПовтор.ПолучитьПредставлениеНаЯзыке(Данные.Ссылка, , ИСТИНА);
		Если НЕ ВозможноеПредставление = Неопределено Тогда
			Представление = ВозможноеПредставление;
			СтандартнаяОбработка = ЛОЖЬ;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
