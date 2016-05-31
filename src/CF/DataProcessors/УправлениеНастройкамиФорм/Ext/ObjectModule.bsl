﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// Процедура добавляет стандартную форму в список форм
//
// Параметры :
//  Префикс - префикс имени формы
//  ПрефиксПредставления - префикс представления формы
//  МетаданныеФорм - коллекция метаданных форм
//  Картинка - картинка объекта метаданных
//  Список - список значений, в который помещается список имен форм
// Процедура добавляет стандартную форму в список форм
//
// Параметры :
//  Префикс - префикс имени формы
//  ПрефиксПредставления - префикс представления формы
//  ОбъектМетаданных - объект метаданных, для которого получается форма
//  ИмяФормы - имя формы
//  ПредставлениеФормы - представление формы
//  Картинка - картинка объекта метаданных
//  Список - список значений, в который помещается список имен форм
Процедура ДобавитьСтандартнуюФорму(Префикс, ПрефиксПредставления, ОбъектМетаданных, ИмяФормы, ПредставлениеФормы, Картинка, Список)

	Если ОбъектМетаданных["Основная" + ИмяФормы] = Неопределено Тогда
		Список.Добавить(Префикс + "." + ИмяФормы, ПрефиксПредставления + "." + ПредставлениеФормы, Ложь, Картинка);
	КонецЕсли;

КонецПроцедуры

// Процедура получает список сохраненных настроек для переданных форм
//
// Параметры :
//  СписокФорм - список форм, для которых нужно получить список настроек
//  Пользователь - имя пользователя, настройки форм которого нужно получить
//  СписокФормССохраненнымиНастройками - список значений в который будут добавлены настройки форм.
Процедура ПолучитьСписокСохраненныхНастроек(СписокФорм, Пользователь, СписокФормССохраненнымиНастройками) Экспорт

	Для каждого Элемент Из СписокФорм Цикл
		Описание = ХранилищеСистемныхНастроек.ПолучитьОписание(Элемент.Значение + "/НастройкиФормы", , Пользователь);
		Если Описание <> Неопределено Тогда
			СписокФормССохраненнымиНастройками.Добавить(Элемент.Значение, Элемент.Представление, Элемент.Пометка, Элемент.Картинка);
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

// Процедура получает список форм
//
// Параметры :
//  Список - список значений, в который помещается список имен форм
Процедура ПолучитьСписокФорм(Список) Экспорт

	Для Каждого Форма Из Метаданные.ОбщиеФормы Цикл
		Список.Добавить("ОбщаяФорма." + Форма.Имя, ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Общая форма.") + Форма.Синоним, Ложь, БиблиотекаКартинок.Форма);
	КонецЦикла;

	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаГруппы", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма группы"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбораГруппы", "Форма выбора группы");
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.Справочники, "Справочник", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Справочник"), ИменаСтандартныхФорм, БиблиотекаКартинок.Справочник, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("Форма", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.КритерииОтбора, "КритерийОтбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Критерий отбора"), ИменаСтандартныхФорм, БиблиотекаКартинок.КритерийОтбора, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаСохранения", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма сохранения"));
	ИменаСтандартныхФорм.Добавить("ФормаЗагрузки", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.ХранилищаНастроек, "ХранилищеНастроек", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Хранилище настроек"), ИменаСтандартныхФорм, БиблиотекаКартинок.ХранилищеНастроек, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.Документы, "Документ", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Документ"), ИменаСтандартныхФорм, БиблиотекаКартинок.Документ, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("Форма", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.ЖурналыДокументов, "ЖурналДокументов", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Журнал документов"), ИменаСтандартныхФорм, БиблиотекаКартинок.ЖурналДокументов, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.Перечисления, "Перечисление", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Перечисление"), ИменаСтандартныхФорм, БиблиотекаКартинок.Перечисление, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("Форма", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма"));
	ИменаСтандартныхФорм.Добавить("ФормаНастроек", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма настроек"));
	ИменаСтандартныхФорм.Добавить("ФормаВарианта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма варианта"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.Отчеты, "Отчет", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Отчет"), ИменаСтандартныхФорм, БиблиотекаКартинок.Отчет, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("Форма", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.Обработки, "Обработка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обработка"), ИменаСтандартныхФорм, БиблиотекаКартинок.Обработка, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаЗаписи", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма записи"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.РегистрыСведений, "РегистрСведений", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Регистр сведений"), ИменаСтандартныхФорм, БиблиотекаКартинок.РегистрСведений, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.РегистрыНакопления, "РегистрНакопления", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Регистр накопления"), ИменаСтандартныхФорм, БиблиотекаКартинок.РегистрНакопления, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаГруппы", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма группы"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбораГруппы", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора группы"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.ПланыВидовХарактеристик, "ПланВидовХарактеристик", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("План видов характеристик"), ИменаСтандартныхФорм, БиблиотекаКартинок.ПланВидовХарактеристик, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.ПланыСчетов, "ПланСчетов", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("План счетов"), ИменаСтандартныхФорм, БиблиотекаКартинок.ПланСчетов, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.РегистрыБухгалтерии, "РегистрБухгалтерии", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Регистр бухгалтерии"), ИменаСтандартныхФорм, БиблиотекаКартинок.РегистрБухгалтерии, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.ПланыВидовРасчета, "ПланВидовРасчета", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("План видов расчета"), ИменаСтандартныхФорм, БиблиотекаКартинок.ПланВидовРасчета, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.РегистрыРасчета, "РегистрРасчета", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Регистр расчета"), ИменаСтандартныхФорм, БиблиотекаКартинок.РегистрРасчета, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.БизнесПроцессы, "БизнесПроцесс", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Бизнес процесс"), ИменаСтандартныхФорм, БиблиотекаКартинок.БизнесПроцесс, Список);
	ИменаСтандартныхФорм = Новый СписокЗначений;
	ИменаСтандартныхФорм.Добавить("ФормаОбъекта", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма объекта"));
	ИменаСтандартныхФорм.Добавить("ФормаСписка", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма списка"));
	ИменаСтандартныхФорм.Добавить("ФормаДляВыбора", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Форма выбора"));
	ПолучитьСписокФормОбъектаМетаданных(Метаданные.Задачи, "Задача", ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Задача"), ИменаСтандартныхФорм, БиблиотекаКартинок.Задача, Список);

КонецПроцедуры

Процедура ПолучитьСписокФормИзСпискаМетаданныхФорм(Префикс, ПрефиксПредставления, МетаданныеФорм, Картинка, Список)

	Для каждого Форма Из МетаданныеФорм Цикл
		Список.Добавить(Префикс + ".Форма." + Форма.Имя, ПрефиксПредставления + "." + Форма.Синоним, Ложь, Картинка);
	КонецЦикла;

КонецПроцедуры

// Процедура получает список форм для списка объекта метаданных одного типа
//
// Параметры :
//  СписокОбъектовМетаданных - список объектов метаданных, для которых нужно получить список форм
//  ИмяОбъектаМетаданных - имя объекта метаданных
//  ПредставлениеОбъектаМетаданных - представление объекта метаданных
//  ИменаСтандартныхФорм - имена стандартных форм объекта метаданных
//  Картинка - картинка объекта метаданных
//  Список - список значений, в который помещается список имен форм
Процедура ПолучитьСписокФормОбъектаМетаданных(СписокОбъектовМетаданных, ИмяОбъектаМетаданных, ПредставлениеОбъектаМетаданных, ИменаСтандартныхФорм, Картинка, Список)

	Для каждого Объект Из СписокОбъектовМетаданных Цикл
		Префикс = ИмяОбъектаМетаданных + "." + Объект.Имя;
		ПрефиксПредставления = ПредставлениеОбъектаМетаданных + "." + Объект.Синоним;
		ПолучитьСписокФормИзСпискаМетаданныхФорм(Префикс, ПрефиксПредставления, Объект.Формы, Картинка, Список);

		Для каждого ИмяСтандартнойФормы Из ИменаСтандартныхФорм Цикл
			ДобавитьСтандартнуюФорму(Префикс, ПрефиксПредставления, Объект, ИмяСтандартнойФормы.Значение, ИмяСтандартнойФормы.Представление, Картинка, Список);
		КонецЦикла;
	КонецЦикла;

КонецПроцедуры

// Процедура позволяет скопировать настройки форм от одного пользователя другому
//
// Параметры :
//  ПользовательИсточник - имя пользователя, настройки форм которого копируются
//  ПользователиПриемник - имя пользователя которому копируются настройки форм
//  МассивНастроекДляКопирования - имена форм, настройки которых нужно скопировать
Процедура СкопироватьНастройкиФорм(ПользовательИсточник, ПользователиПриемник, МассивНастроекДляКопирования) Экспорт

	Для каждого Элемент Из МассивНастроекДляКопирования Цикл
		Настройка = ХранилищеСистемныхНастроек.Загрузить(Элемент + "/НастройкиФормы", "", , ПользовательИсточник);
		Если Настройка <> Неопределено Тогда
			Для каждого ПользовательПриемник Из ПользователиПриемник Цикл
				ХранилищеСистемныхНастроек.Сохранить(Элемент + "/НастройкиФормы", "", Настройка, , ПользовательПриемник);

			КонецЦикла;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

// Процедура позволяет удалить настройки форм
//
// Параметры :
//  Пользователь - имя пользователя, настройки форм которого удаляются
//  МассивНастроекДляУдаления - имена форм, настройки которых нужно удалить
Процедура УдалитьНастройкиФорм(Пользователь, МассивНастроекДляУдаления) Экспорт

	Для каждого Элемент Из МассивНастроекДляУдаления Цикл
		ХранилищеСистемныхНастроек.Удалить(Элемент + "/НастройкиФормы", "", Пользователь);
	КонецЦикла;

КонецПроцедуры

#КонецЕсли
