﻿// sza140119-2251
// sza131023-0022 :

&НаКлиенте
Процедура ВыполнитьПоиск(Команда)
    ВыполнитьПоискНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоискНаКлиенте()

    Если ЭтоНавигационнаяСсылка(СтрокаПоиска) Тогда
        ПерейтиПоНавигационнойСсылке(СтрокаПоиска);

        Возврат;
    КонецЕсли;

    ЗначенияРезультата.Очистить();
    РезультатыПоиска = "";
    ТекущаяПозиция = 0;
    Если СтрокаПоиска <> "" Тогда
        ВыполнитьПоискНаСервере();
    Иначе
        РезультатыПоиска = ПустойHTML();
    КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ВыполнитьПоискНаСервере()

    Элемент = ПоследниеЗапросы.НайтиПоЗначению(СтрокаПоиска);

    Если Элемент = Неопределено Тогда
        ПоследниеЗапросы.Вставить(0, СтрокаПоиска);
        Пока ПоследниеЗапросы.Количество() > 10 Цикл
            ПоследниеЗапросы.Удалить(ПоследниеЗапросы[ПоследниеЗапросы.Количество() - 1]);

        КонецЦикла;

        ХранилищеСистемныхНастроек.Сохранить(ИмяФормы, "ПредыдущиеПоиски", ПоследниеЗапросы);
    КонецЕсли;

    ЗначенияРезультата.Очистить();
    РазмерПорции = 10;
    СписокПоиска = ПолнотекстовыйПоиск.СоздатьСписок(СтрокаПоиска, РазмерПорции);
    Если ТекущаяПозиция = 0 Тогда
        СписокПоиска.ПерваяЧасть();
    Иначе
        СписокПоиска.СледующаяЧасть(ТекущаяПозиция - РазмерПорции);
    КонецЕсли;

    ПолноеКоличество = СписокПоиска.ПолноеКоличество();
    ТекущаяПозиция = СписокПоиска.НачальнаяПозиция();
    Если ПолноеКоличество = 0 Тогда
        РезультатыПоиска = СформироватьНеНайдено(СтрокаПоиска);

        Возврат;
    КонецЕсли;

    ВсегоСтраниц = Цел((ПолноеКоличество - 1) / РазмерПорции) + 1;

    Если ПолноеКоличество > ВсегоСтраниц * РазмерПорции Тогда
        ВсегоСтраниц = ВсегоСтраниц + 1;
    КонецЕсли;

    ТекПозиция = Формат(1 + ТекущаяПозиция, "ЧН=; ЧГ=0");
    XML = СписокПоиска.ПолучитьОтображение(ВидОтображенияПолнотекстовогоПоиска.XML);
    ЗаписьXML = Новый ЗаписьXML();
    ЗаписьXML.Отступ = ЛОЖЬ;
    ЗаписьXML.УстановитьСтроку();

    Пока XML.Прочитать() Цикл
        ЗаписьXML.ЗаписатьТекущий(XML);
    КонецЦикла;

    XMLСтрока = ЗаписьXML.Закрыть();
    Преобразование = Новый ПреобразованиеXSL();
    ЗаписьXML = Новый ЗаписьXML();
    ЗаписьXML.УстановитьСтроку();
    ЗаписьXML.ЗаписатьОбъявлениеXML();
    ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:stylesheet");
    ЗаписьXML.ЗаписатьСоответствиеПространстваИмен("xsl", "http://www.w3.org/1999/XSL/Transform");
    ЗаписьXML.ЗаписатьАтрибут("version", "1.0");
        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:output");
        ЗаписьXML.ЗаписатьАтрибут("method", "html");
        ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:template");
        ЗаписьXML.ЗаписатьАтрибут("match", "/");
            ЗаписьXML.ЗаписатьНачалоЭлемента("html");
                ЗаписьXML.ЗаписатьНачалоЭлемента("head");
                    ЗаписьXML.ЗаписатьНачалоЭлемента("style");
                    ЗаписьXML.ЗаписатьАтрибут("type", "text/css");
                    ЗаписьXML.ЗаписатьТекст("
        |   html { overflow:auto; }
        |   body { margin: 10px; font-family: Arial,sans-serif; font-size: 10pt; overflow:auto; }
        |   table { font-family: Arial,sans-serif; font-size: 10pt; }
        |   ol li { color:#B3B3B3; }
        |   ol li div { color:#333333; }
        |   div.presentation { font-size: 11pt; }
        |   div.textPortion { padding-bottom: 16px; }
        |   span.bold { font-weight: bold; }
        |   div.presentation a { text-decoration:none;color:#0066CC; }
        |   div.presentation a:hover { text-decoration:underline; }
        |   ul li { padding-bottom:12px; }
        |   ul li a { font-size:10pt; border-bottom:1px #333333 dotted; color:#333333; text-decoration:none; }
        |   .nav TD { text-align: center; width:24px;}
        |   .nav TD a { text-decoration:none;color:#0066CC; }
        |   .nav TD a:hover { text-decoration:underline; }
        |   .gray { color:#B3B3B3; }");
                    ЗаписьXML.ЗаписатьКонецЭлемента();
                ЗаписьXML.ЗаписатьКонецЭлемента();
                ЗаписьXML.ЗаписатьНачалоЭлемента("body");
                    ЗаписьXML.ЗаписатьНачалоЭлемента("table");
                    ЗаписьXML.ЗаписатьАтрибут("style", "height:100%; width:100%;");
                        ЗаписьXML.ЗаписатьНачалоЭлемента("tr");
                            ЗаписьXML.ЗаписатьНачалоЭлемента("td");
                            ЗаписьXML.ЗаписатьАтрибут("style", "vertical-align:top");
                                ЗаписьXML.ЗаписатьНачалоЭлемента("div");
                                ЗаписьXML.ЗаписатьАтрибут("style", "overflow:auto;height:100%");
                                    ЗаписьXML.ЗаписатьНачалоЭлемента("table");
                                    ЗаписьXML.ЗаписатьАтрибут("cellspacing", "0");
                                    ЗаписьXML.ЗаписатьАтрибут("cellpadding", "0");
                                    ЗаписьXML.ЗаписатьАтрибут("style", "height:100%; width:100%;");
                                        ЗаписьXML.ЗаписатьНачалоЭлемента("tr");
                                            ЗаписьXML.ЗаписатьНачалоЭлемента("td");
                                            ЗаписьXML.ЗаписатьАтрибут("style", "vertical-align:top");
                                                ЗаписьXML.ЗаписатьНачалоЭлемента("ol");
                                                ЗаписьXML.ЗаписатьАтрибут("start", ТекПозиция);
                                                    ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:apply-templates");
                                                    ЗаписьXML.ЗаписатьАтрибут("select", "// item");
                                                    ЗаписьXML.ЗаписатьКонецЭлемента();
                                                ЗаписьXML.ЗаписатьКонецЭлемента();
                                            ЗаписьXML.ЗаписатьКонецЭлемента();
                                            ЗаписьXML.ЗаписатьНачалоЭлемента("td");
                                            ЗаписьXML.ЗаписатьАтрибут("style", "vertical-align:top; width:220px; padding-left:20px;");
			                                    ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:text");
                                                    СформироватьПоследниеЗапросы(ПоследниеЗапросы, ЗаписьXML);
                                                ЗаписьXML.ЗаписатьКонецЭлемента();
                                            ЗаписьXML.ЗаписатьКонецЭлемента();
                                        ЗаписьXML.ЗаписатьКонецЭлемента();
                                    ЗаписьXML.ЗаписатьКонецЭлемента();
                                ЗаписьXML.ЗаписатьКонецЭлемента();
                            ЗаписьXML.ЗаписатьКонецЭлемента();
                        ЗаписьXML.ЗаписатьКонецЭлемента();
                        ЗаписьXML.ЗаписатьНачалоЭлемента("tr");
                            ЗаписьXML.ЗаписатьНачалоЭлемента("td");
                            ЗаписьXML.ЗаписатьАтрибут("style", "height:40px;border-top:1px solid gray");
                            СформироватьСтрокуНавигации(ВсегоСтраниц, ТекущаяПозиция, РазмерПорции, ПолноеКоличество, ЗаписьXML);
                            ЗаписьXML.ЗаписатьКонецЭлемента();
                        ЗаписьXML.ЗаписатьКонецЭлемента();
                    ЗаписьXML.ЗаписатьКонецЭлемента();
                ЗаписьXML.ЗаписатьКонецЭлемента();
            ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:template");
        ЗаписьXML.ЗаписатьАтрибут("match", "item");
            ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:variable");
            ЗаписьXML.ЗаписатьАтрибут("name", "url");
            ЗаписьXML.ЗаписатьАтрибут("select", "index");
            ЗаписьXML.ЗаписатьКонецЭлемента();
            ЗаписьXML.ЗаписатьНачалоЭлемента("li");
                ЗаписьXML.ЗаписатьНачалоЭлемента("div");
                ЗаписьXML.ЗаписатьАтрибут("class", "presentation");
                    ЗаписьXML.ЗаписатьНачалоЭлемента("a");
                    ЗаписьXML.ЗаписатьАтрибут("id", "FullTextSearchListItem");
                    ЗаписьXML.ЗаписатьАтрибут("href", "#");
                    ЗаписьXML.ЗаписатьАтрибут("sel_num", "{$url}");
                        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:value-of");
                        ЗаписьXML.ЗаписатьАтрибут("select", "metadata");
                        ЗаписьXML.ЗаписатьКонецЭлемента();
                        ЗаписьXML.ЗаписатьТекст(": ");
                        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:value-of");
                        ЗаписьXML.ЗаписатьАтрибут("select", "presentation");
                        ЗаписьXML.ЗаписатьКонецЭлемента();
                    ЗаписьXML.ЗаписатьКонецЭлемента();
                ЗаписьXML.ЗаписатьКонецЭлемента();
                ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:apply-templates");
                ЗаписьXML.ЗаписатьАтрибут("select", "textPortion");
                ЗаписьXML.ЗаписатьКонецЭлемента();
            ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:template");
        ЗаписьXML.ЗаписатьАтрибут("match", "textPortion");
            ЗаписьXML.ЗаписатьНачалоЭлемента("div");
            ЗаписьXML.ЗаписатьАтрибут("class", "textPortion");
                ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:apply-templates");
                ЗаписьXML.ЗаписатьКонецЭлемента();
            ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:template");
        ЗаписьXML.ЗаписатьАтрибут("match", "foundWord");
            ЗаписьXML.ЗаписатьНачалоЭлемента("span");
            ЗаписьXML.ЗаписатьАтрибут("class", "bold");
                ЗаписьXML.ЗаписатьНачалоЭлемента("xsl:value-of");
                ЗаписьXML.ЗаписатьАтрибут("select", ".");
                ЗаписьXML.ЗаписатьКонецЭлемента();
            ЗаписьXML.ЗаписатьКонецЭлемента();
        ЗаписьXML.ЗаписатьКонецЭлемента();
    ЗаписьXML.ЗаписатьКонецЭлемента();
    ШаблонПреобразования = ЗаписьXML.Закрыть();
    Преобразование.ЗагрузитьИзСтроки(ШаблонПреобразования);
    РезультатыПоиска = Преобразование.ПреобразоватьИзСтроки(XMLСтрока);

    Для Каждого ЭлементСписка Из СписокПоиска Цикл
        ЗначенияРезультата.Добавить(ЭлементСписка.Значение);
    КонецЦикла;

КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОбновитьИндексыДляПоискаНаСервере()

	ПолнотекстовыйПоиск.ОбновитьИндекс(ИСТИНА, ЛОЖЬ);

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПолнотекстовыйИндекс(Команда)

	Состояние(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Обновление индекса.."));
	ОбновитьИндексыДляПоискаНаСервере();
	Элементы.ОбновитьПолнотекстовыйИндекс.Видимость = ЛОЖЬ;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()                                              // ПРИ ЗАКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)                                         // ПРИ ОТКРЫТИИ
	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
		ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
	КонецЕсли;

	Настройки = ХранилищеСистемныхНастроек.Загрузить(ИмяФормы, "ПредыдущиеПоиски");

	Если Настройки <> Неопределено Тогда
		ПоследниеЗапросы = Настройки;
	КонецЕсли;

	РезультатыПоиска = ПустойHTML();
//	ОбновитьИндексыДляПоискаНаСервере();

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаСервере
Функция   ПустойHTML()

    СтрокаПоследниеЗапросы = СформироватьПоследниеЗапросыHTML(ПоследниеЗапросы);

    Возврат "<html>
    |<head>
    |<style type=""text/css"">
    |   html { overflow:auto; }
    |   body { margin: 10px; font-family: Arial,sans-serif; font-size: 10pt; overflow:auto; }
    |   table { font-family: Arial,sans-serif; font-size: 10pt; }
    |   ul li { padding-bottom:12px; }
    |   ul li a { font-size:10pt; border-bottom:1px #333333 dotted; color:#333333; text-decoration:none; }
    |</style>
    |</head>
    |<body>
    |<table style=""height:100%; width:100%;"">
    |<tr>
    |<td>&nbsp;
    |</td>
    |<td style=""vertical-align:top; width:220px; padding-left:20px;"">"
    + СтрокаПоследниеЗапросы + "
    |</td>
    |</tr>
    |</table>
    |</body>
    |</html>";

КонецФункции

&НаКлиенте
Процедура РезультатыПоискаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)

    ЭлементHTML = ДанныеСобытия.Anchor;

    Если ЭлементHTML = Неопределено Тогда
        Возврат;
    КонецЕсли;

    Если ЭлементHTML.id = "FullTextSearchListItem" Тогда
        СтандартнаяОбработка = ЛОЖЬ;
        ВыбранныйНомер = ЭлементHTML.getAttribute("sel_num");
        НомерВСписке = Число(ВыбранныйНомер);
		ЗначениеДляОткрытия = ЗначенияРезультата[НомерВСписке].Значение;

		Если глВерсияПлатформы < 803040000  Тогда
			ПоказатьЗначение(Неопределено, ЗначениеДляОткрытия);
		Иначе
			Выполнить(" ПоказатьЗначение(, ЗначениеДляОткрытия); ");
		КонецЕсли;

		Возврат;
	КонецЕсли;

	Если ЭлементHTML.id = "PrevSearch" Тогда
        СтандартнаяОбработка = ЛОЖЬ;
        СтрокаПоиска = ЭлементHTML.getAttribute("prev_text");
        ВыполнитьПоискНаКлиенте();

        Возврат;
    КонецЕсли;

    Если ЭлементHTML.id = "prev" Тогда
        СтандартнаяОбработка = ЛОЖЬ;
        ТекущаяПозиция = ТекущаяПозиция - 10;
        ЗначенияРезультата.Очистить();
        ВыполнитьПоискНаСервере();

        Возврат;
    КонецЕсли;

    Если ЭлементHTML.id = "next" Тогда
        СтандартнаяОбработка = ЛОЖЬ;
        ТекущаяПозиция = ТекущаяПозиция + 10;
        ЗначенияРезультата.Очистить();
        ВыполнитьПоискНаСервере();

        Возврат;
    КонецЕсли;

    Если Лев(ЭлементHTML.id, 4) = "link" Тогда
        СтандартнаяОбработка = ЛОЖЬ;
        ТекущаяПозиция = (Число(Сред(ЭлементHTML.id, 5)) - 1) * 10;
        ЗначенияРезультата.Очистить();
        ВыполнитьПоискНаСервере();

        Возврат;
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)

    ВыполнитьПоискНаКлиенте();

КонецПроцедуры

&НаСервереБезКонтекста
Функция   СформироватьНеНайдено(СтрокаПоиска)

    ДокументHTML = Новый ДокументHTML("");
    Elem = ДокументHTML.СоздатьЭлемент("SPAN");
    Elem.ТекстовоеСодержимое = СтрокаПоиска;
    ЗаписьHTML = Новый ЗаписьHTML;
    ЗаписьHTML.УстановитьСтроку();
    ЗаписьDOM = Новый ЗаписьDOM;
    ЗаписьDOM.Записать(Elem, ЗаписьHTML);
    Стр = ЗаписьHTML.Закрыть();

    Возврат "<!DOCTYPE html>
|<html>
|<head>
|<meta content=text/html; charset=utf-8 http-equiv=Content-Type>
|<style>
|   html { overflow:auto; }
|	body {margin: 10px; font-family: Arial,sans-serif; font-size: 10pt; color:#333333; overflow:auto; }
|	li { padding-bottom:18px; }
|	.green { color: green; font-weight: bold; font-size: 11pt; }
|</style>
|</head>
|<body>
|<p style=font-size:12pt;>" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("По запросу") + " <b>&quot;""" + Стр + "&quot;</b> " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("ничего не найдено") + ".</p>
|<p class=green>" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Рекомендации") + ":</p>
|<ul>
|<li><b>" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Упростите запрос, исключив Из него какое-либо слово.") + "</b>
|<li><b>" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Воспользуйтесь поиском по началу слова.") + "</b><br>
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Используйте звездочку") + " (*) " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("в качестве окончания") + ".<br>
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Например, поиск") + " стро* " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("найдет все документы") + ",
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("которые содержат слова, начинающиеся на") + " стро &ndash;
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Журнал") + " &quot;" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Строительство и ремонт") + "&quot;,
|&quot;" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("ООО СтройКомплект") + "&quot; " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("и") + "&nbsp;" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("т.д.") + "
|<li><b>" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Воспользуйтесь нечетким поиском") + "</b>.<br>
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Используйте решетку") + " (#).<br>
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Например") + ", Сентинель#2
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("найдет все документы, содержащие такие слова, которые отличаются от слова") + " Сентинель
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("на одну или две буквы") + ".
|<li><b>" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Ищите синонимы") + ".</b><br>
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Используйте восклицательный знак") + " (!).<br>
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Например, поиск") + " !инструкция " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("найдет все документы в которых встречаются") + "
|" + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("слова инструкция, предписание, указание") + ".
|</ul>
|</body>
|</html>";

КонецФункции

&НаСервереБезКонтекста
Процедура СформироватьПоследниеЗапросы(ПоследниеЗапросы, Запись)

    Если ПоследниеЗапросы.Количество() = 0 Тогда
        Возврат;
    КонецЕсли;

    ДокументHTML = Новый ДокументHTML("");
    DivElem = ДокументHTML.СоздатьЭлемент("DIV");
    DivElem.УстановитьАтрибут("style", "color:#40AD74; font-size:11pt;");
    DivElem.ТекстовоеСодержимое = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Последние запросы");
    ULElem = ДокументHTML.СоздатьЭлемент("UL");
    ULElem.УстановитьАтрибут("style", "margin-left:16px;");

    Для Каждого Элемент Из ПоследниеЗапросы Цикл
        Значение = Элемент.Значение;
        LIElem = ДокументHTML.СоздатьЭлемент("LI");
        AElem = ДокументHTML.СоздатьЭлемент("A");
        AElem.УстановитьАтрибут("id", "PrevSearch");
        AElem.УстановитьАтрибут("href", "#");
        AElem.УстановитьАтрибут("prev_text", Значение);
        AElem.ТекстовоеСодержимое = Значение;
        LIElem.ДобавитьДочерний(AElem);
        ULElem.ДобавитьДочерний(LIElem);

    КонецЦикла;

    ЗаписьDOM = Новый ЗаписьDOM;
    ЗаписьDOM.Записать(DivElem, Запись);
    ЗаписьDOM.Записать(ULElem, Запись);

КонецПроцедуры

&НаСервереБезКонтекста
Функция   СформироватьПоследниеЗапросыHTML(ПоследниеЗапросы)

    Если ПоследниеЗапросы.Количество() = 0 Тогда
        Возврат "";
    КонецЕсли;

    ЗаписьHTML = Новый ЗаписьHTML;
    ЗаписьHTML.УстановитьСтроку();
    СформироватьПоследниеЗапросы(ПоследниеЗапросы, ЗаписьHTML);

    Возврат ЗаписьHTML.Закрыть();

КонецФункции

&НаСервереБезКонтекста
Процедура СформироватьСтрокуНавигации(ВсегоСтраниц, ТекущаяПозиция, РазмерПорции, ПолноеКоличество, Запись)

    Если ВсегоСтраниц <= 1 Тогда
        Возврат;
    КонецЕсли;

    ДокументHTML = Новый ДокументHTML("");
    TableElem = ДокументHTML.СоздатьЭлемент("TABLE");
    TableElem.УстановитьАтрибут("class", "nav");
    TRElem = ДокументHTML.СоздатьЭлемент("TR");
    TDElem = ДокументHTML.СоздатьЭлемент("TD");
    TDElem.УстановитьАтрибут("style", "text-align:right;width:100px;");

    Если ТекущаяПозиция > 0 Тогда
        AElem = ДокументHTML.СоздатьЭлемент("A");
        AElem.УстановитьАтрибут("href", "#");
        AElem.УстановитьАтрибут("id", "prev");
        AElem.ТекстовоеСодержимое = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Предыдущая");
        TDElem.ДобавитьДочерний(AElem);
    Иначе
        DivElem = ДокументHTML.СоздатьЭлемент("DIV");
        DivElem.УстановитьАтрибут("class", "gray");
        DivElem.ТекстовоеСодержимое = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Предыдущая");
        TDElem.ДобавитьДочерний(DivElem);
    КонецЕсли;

    TRElem.ДобавитьДочерний(TDElem);
    Страница = ТекущаяПозиция / РазмерПорции + 1;
    Первый = Страница - 5;
    Если Первый + 10 > ВсегоСтраниц Тогда
        Первый = ВсегоСтраниц - 10 + 1;
    КонецЕсли;

    Если Первый < 1 Тогда
        Первый = 1;
    КонецЕсли;

    Для Счетчик = Первый По Первый + 10 - 1 Цикл
        Если ПолноеКоличество <= (Счетчик - 1) * РазмерПорции Тогда
            Прервать;
        КонецЕсли;

        TDElem = ДокументHTML.СоздатьЭлемент("TD");

        Если Счетчик = Страница Тогда
            BElem = ДокументHTML.СоздатьЭлемент("B");
            BElem.ТекстовоеСодержимое = Строка(Счетчик);
            TDElem.ДобавитьДочерний(BElem);
        Иначе
            AElem = ДокументHTML.СоздатьЭлемент("A");
            AElem.УстановитьАтрибут("href", "#");
            AElem.УстановитьАтрибут("id", "link" + Строка(Счетчик));
            AElem.ТекстовоеСодержимое = Строка(Счетчик);
            TDElem.ДобавитьДочерний(AElem);
        КонецЕсли;

        TRElem.ДобавитьДочерний(TDElem);

    КонецЦикла;

    TDElem = ДокументHTML.СоздатьЭлемент("TD");
    Если ТекущаяПозиция + РазмерПорции < ПолноеКоличество Тогда
        AElem = ДокументHTML.СоздатьЭлемент("A");
        AElem.УстановитьАтрибут("href", "#");
        AElem.УстановитьАтрибут("id", "next");
        AElem.ТекстовоеСодержимое = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Следующая");
        TDElem.ДобавитьДочерний(AElem);
    Иначе
        DivElem = ДокументHTML.СоздатьЭлемент("DIV");
        DivElem.УстановитьАтрибут("class", "gray");
        DivElem.ТекстовоеСодержимое = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Следующая");
        TDElem.ДобавитьДочерний(DivElem);
    КонецЕсли;

    TRElem.ДобавитьДочерний(TDElem);
    TableElem.ДобавитьДочерний(TRElem);
    ЗаписьDOM = Новый ЗаписьDOM;
    ЗаписьDOM.Записать(TableElem, Запись);

КонецПроцедуры

&НаКлиенте
Функция   ЭтоНавигационнаяСсылка(Знач Стр)

    Ссылка = ВРег(Стр);

    Если Найти(Ссылка, "E1CIB/") = 1 Тогда
        Возврат ИСТИНА;
    КонецЕсли;

    Если Найти(Ссылка, "HTTP:") = 1 Или Найти(Ссылка, "HTTPS:") = 1 Тогда
        Возврат ИСТИНА;
    КонецЕсли;

    СсылкаИБ = ВРег(ПолучитьНавигационнуюСсылкуИнформационнойБазы());

    Если Найти(Ссылка, СсылкаИБ) = 1 Тогда
        Возврат ИСТИНА;
    КонецЕсли;

    Если Прав(СсылкаИБ, 1) = "/" Тогда
        СсылкаИБ = Лев(СсылкаИБ, СтрДлина(СсылкаИБ) - 1);
        Если Найти(Ссылка, СсылкаИБ) = 1 Тогда
            Возврат ИСТИНА;
        КонецЕсли;
    КонецЕсли;

    Возврат ЛОЖЬ;

КонецФункции
