﻿///////////////////////////////////////////////////////////////////////////
// ОБЩИЕ КОМАНДЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ
	Если ЗначениеЗаполнено(Параметры.АдресХранилища) Тогда
	ПараметрыПередачи = ПолучитьИзВременногоХранилища(Параметры.АдресХранилища);
	Объект.ИспользоватьАвтосохранение 						= ПараметрыПередачи.ИспользоватьАвтосохранение;	
	Объект.ПериодАвтосохранения 							= ПараметрыПередачи.ПериодАвтосохранения;	
	Объект.ВыводитьВРезультатахЗапросаЗначенияСсылок		= ПараметрыПередачи.ВыводитьВРезультатахЗапросаЗначенияСсылок;
	Объект.ТипОбхода										= ПараметрыПередачи.ТипОбхода;
	Объект.ЧередованиеЦветовВрезультатеЗапроса				= ПараметрыПередачи.ЧередованиеЦветовВрезультатеЗапроса;
	
	Элементы.ТипОбхода.СписокВыбора.Добавить("Авто");
	Элементы.ТипОбхода.СписокВыбора.Добавить("Прямой");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Записать(Команда)
	ПараметрыПередачи = ПоместитьНастройкиВСтруктуру();
	
	// Передача в открывающую форму.
	Закрыть(); 
	Владелец		= ЭтаФорма.ВладелецФормы;
	
	Оповестить("ПередатьПараметрыНастроек" , ПараметрыПередачи);
	Оповестить("ПередатьПараметрыНастроекАвтоСохранения");
КонецПроцедуры


///////////////////////////////////////////////////////////////////////////
// ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаСервере
Функция ПоместитьНастройкиВСтруктуру()
	ПараметрыПередачи = Новый Структура;
	ПараметрыПередачи.Вставить("АдресХранилища", ОбъектОбработки().ПоместитьНастройкиВоВременноеХранилище(Объект));
	Возврат ПараметрыПередачи;
КонецФункции	
 