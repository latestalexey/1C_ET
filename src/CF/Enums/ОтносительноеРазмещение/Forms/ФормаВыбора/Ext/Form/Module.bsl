﻿// sza131009-2157 :

&НаКлиенте
Процедура ПриЗакрытии()                                                  // ПРИ ЗАКРЫТИИ
		ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                                                    // ПРИ ОТКРЫТИИ
		ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры
