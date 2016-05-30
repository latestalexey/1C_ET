﻿//sza131119-2316
//sza101210-0151       
//sza101114-0312       
//sza101109-0052       
//sza101105-0306       
//sza101023
&НаСервере
Процедура ПроверитьЗаполненныеКомментарии() //Экспорт	
	ПодсистемаИЭИмпортЭкспортФС.ЗаполнитьКомментарииИТипы();
КонецПроцедуры //ПроверитьЗаполненныеКомментарии

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ	
	
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ПроверитьЗаполненныеКомментарии();
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьКомментарииИТипы1(Команда)
	
	Если Вопрос(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Вы уверены, что готовы обновить все комментарии и типы предопределенных полей для шаблонов?"), РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да ТОгда
		ПодсистемаИЭИмпортЭкспортФС.ЗаполнитьКомментарииИТипы(Истина);
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры
