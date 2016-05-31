﻿// sza131004-0252

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

	Процедура УстановитьЗначениеПараметраСеанса(Знач ИмяПараметра, УстановленныеПараметры)

		Если УстановленныеПараметры.Найти(ИмяПараметра) <> Неопределено Тогда
			Возврат;
		КонецЕсли;

		МенеджерОборудованияВызовСервера.УстановитьПараметрыСеансаПодключаемогоОборудования(ИмяПараметра, УстановленныеПараметры);

КонецПроцедуры

#КонецЕсли

Процедура УстановкаПараметровСеанса(ИменаПараметровСеанса)

	Если ИменаПараметровСеанса = Неопределено Тогда

		ОбщийМодульСервисСервер.УстановитьПараметрыСеансаЭлементарнаяТорговля(, ИСТИНА);
	Иначе
		#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
			УстановленныеПараметры = Новый Массив();

			Для Каждого ИмяПараметра Из ИменаПараметровСеанса Цикл
				УстановитьЗначениеПараметраСеанса(ИмяПараметра, УстановленныеПараметры);
			КонецЦикла;

		#КонецЕсли
	КонецЕсли;

КонецПроцедуры
