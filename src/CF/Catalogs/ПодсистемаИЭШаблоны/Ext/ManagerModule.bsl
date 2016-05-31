﻿// sza140104-0214 :
// sza131214-0131 :

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
Процедура НаПечать(ДокументДляПечати, Ссылка) Экспорт

	Макет = Справочники.ПодсистемаИЭШаблоны.ПолучитьМакет("НаПечать");
	Макет.КодЯзыкаМакета = ОбщийМодульПовтор.ПолучитьТекущийЯзыкДокументов();

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПодсистемаИЭШаблоны.АдресФайла,
	|	ПодсистемаИЭШаблоны.ВалютаНеНациональная,
	|	ПодсистемаИЭШаблоны.ВестиЖурналИмпортноЭкспортныхОпераций,
	|	ПодсистемаИЭШаблоны.ВидШаблона,
	|	ПодсистемаИЭШаблоны.ВсегдаСоздаватьНовыйЭлементИлиДокумент,
	|	ПодсистемаИЭШаблоны.ВставлятьМеждуТекстамиНазначенияСледующийТекст,
	|	ПодсистемаИЭШаблоны.ВыдаватьЗапросДляИнтервалаДокументов,
	|	ПодсистемаИЭШаблоны.ВыполнитьПрограммныйКодВНачалеЗагрузкиКаждогоПоля,
	|	ПодсистемаИЭШаблоны.ВыполнитьПрограммныйКодВНачалеЗагрузкиСтроки,
	|	ПодсистемаИЭШаблоны.ВыполнитьПрограммныйКодПередНачалом,
	|	ПодсистемаИЭШаблоны.ВыполнитьПрограммныйКодПослеОкончания,
	|	ПодсистемаИЭШаблоны.ВыполнитьПрограммныйКодПослеОкончанияЗагрузкиКаждогоПоля,
	|	ПодсистемаИЭШаблоны.ВыполнитьПрограммныйКодПослеОкончанияЗагрузкиСтроки,
	|	ПодсистемаИЭШаблоны.ВыполнятьПрограммы,
	|	ПодсистемаИЭШаблоны.ГруппаДляНовойНоменклатуры,
	|	ПодсистемаИЭШаблоны.ГруппаНовыхКлиентов,
	|	ПодсистемаИЭШаблоны.ДанныйШаблонИспользоватьТолькоДляОбъектовСОпределеннымиРеквизитами,
	|	ПодсистемаИЭШаблоны.ДляОбновленияСуществующихОбъектов,
	|	ПодсистемаИЭШаблоны.ДобаватьТекстВПодвалФайла,
	|	ПодсистемаИЭШаблоны.ДобавитьТекстВШапкуФайла,
	|	ПодсистемаИЭШаблоны.ДополнительноеЗаполнениеРеквизитовПриИмпорте,
	|	ПодсистемаИЭШаблоны.ДопустимоеЧислоПустыхСтрокПриПоискеКонцаФайла,
	|	ПодсистемаИЭШаблоны.ЕдиницаИзмеренияНоменклатуры,
	|	ПодсистемаИЭШаблоны.ЕслиКлиентНеНайденПриИмпортеОткрыватьПодборИзСуществующих,
	|	ПодсистемаИЭШаблоны.ЗагружатьВсеФайлыИзПапки,
	|	ПодсистемаИЭШаблоны.ЗнакМеждуИменемПоляИЗначением,
	|	ПодсистемаИЭШаблоны.ИмяРегистра,
	|	ПодсистемаИЭШаблоны.ИмяТаблицыШаблонаФайла,
	|	ПодсистемаИЭШаблоны.ИскатьВПодкаталогах,
	|	ПодсистемаИЭШаблоны.ИспользоватьВКачествеКлючевыхТолькоПоляИзТаблицы,
	|	ПодсистемаИЭШаблоны.ИспользоватьДополнительноеПоведение,
	|	ПодсистемаИЭШаблоны.ИспользоватьЗаголовкиБлоковДанных,
	|	ПодсистемаИЭШаблоны.ИспользоватьСтрокуЗаголовок,
	|	ПодсистемаИЭШаблоны.ИспользоватьТолькоДляИмпорта,
	|	ПодсистемаИЭШаблоны.ИспользоватьТолькоДляЭкспорта,
	|	ПодсистемаИЭШаблоны.КаждоеПолеНоваяСтрока,
	|	ПодсистемаИЭШаблоны.Код,
	|	ПодсистемаИЭШаблоны.КодировкаDOS,
	|	ПодсистемаИЭШаблоны.КодировкаФайла,
	|	ВЫРАЗИТЬ(ПодсистемаИЭШаблоны.Комментарий КАК СТРОКА(1000)) КАК Комментарий,
	|	ПодсистемаИЭШаблоны.Производитель,
	|	ПодсистемаИЭШаблоны.МаскаФайла,
	|	ПодсистемаИЭШаблоны.Наименование,
	|	ПодсистемаИЭШаблоны.НалогообложениеНДСПоУмолчанию,
	|	ПодсистемаИЭШаблоны.НаправлениеДеятельности,
	|	ПодсистемаИЭШаблоны.НеВыводитьСообщениеОЗавершенииОбмена,
	|	ПодсистемаИЭШаблоны.НеЗакрыватьОкноПеречняОбъектовОбмена,
	|	ПодсистемаИЭШаблоны.НеПропускатьНепроведенныеДокументы,
	|	ПодсистемаИЭШаблоны.НеПропускатьОбъектыПомеченныеНаУдаление,
	|	ПодсистемаИЭШаблоны.НеУчитыватьПоследнююСтрокуФайла,
	|	ПодсистемаИЭШаблоны.НоменклатурнаяГруппа,
	|	ПодсистемаИЭШаблоны.НомерДокументаУстанавливатьНоНомеруВходящегоИлиИсходящегоДокумента,
	|	ПодсистемаИЭШаблоны.НомерЛиста,
	|	ПодсистемаИЭШаблоны.НомерПоляКотороеВсегдаЗаполнено,
	|	ПодсистемаИЭШаблоны.ОбрабатыватьПлатежныеДокументы,
	|	ПодсистемаИЭШаблоны.ОстанавливатьОбменПоОшибке,
	|	ПодсистемаИЭШаблоны.ОтборДляКлиента,
	|	ПодсистемаИЭШаблоны.ОтборДляОрганизации,
	|	ПодсистемаИЭШаблоны.ОткрыватьФормуДокументовКоторыеНеУдалосьПровести,
	|	ПодсистемаИЭШаблоны.ОткрыватьФормуКаждогоЭлементаИлиДокумента,
	|	ПодсистемаИЭШаблоны.ПарольАрхива,
	|	ПодсистемаИЭШаблоны.ПоискВНазначенииПлатежаНомераСчетаИДоговора,
	|	ПодсистемаИЭШаблоны.ПоказыватьОбъектыОбмена,
	|	ПодсистемаИЭШаблоны.ПоказыватьПрогрессПроизводстваОбмена,
	|	ПодсистемаИЭШаблоны.ПопытатьсяПроводитьДокументы,
	|	ПодсистемаИЭШаблоны.ПризнакДебетаОтрицательнаяСумма,
	|	ПодсистемаИЭШаблоны.ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора,
	|	ПодсистемаИЭШаблоны.ПропуститьЧислоСимволовВКонцеСтроки,
	|	ПодсистемаИЭШаблоны.ПропуститьЧислоСимволовСНачалаСтроки,
	|	ПодсистемаИЭШаблоны.ПустыеСтрокиМеждуЗаписями,
	|	ПодсистемаИЭШаблоны.РазделителиВстречаютсяМеждуЗнаками,
	|	ПодсистемаИЭШаблоны.РазделительВСоставномНаименовании,
	|	ПодсистемаИЭШаблоны.РазделительДаты,
	|	ПодсистемаИЭШаблоны.РазделительПолей,
	|	ПодсистемаИЭШаблоны.РазделительПолейАльтернативный,
	|	ПодсистемаИЭШаблоны.РазделительЧисел,
	|	ПодсистемаИЭШаблоны.РассчитыватьСрокОкончанияОбмена,
	|	ПодсистемаИЭШаблоны.РезервБулево,
	|	ПодсистемаИЭШаблоны.РезервСтрока,
	|	ПодсистемаИЭШаблоны.РезервЧисло,
	|	ПодсистемаИЭШаблоны.СоздаватьБанковскиеСчетаКлиентов,
	|	ПодсистемаИЭШаблоны.СоздаватьДоговораКлиентов,
	|	ПодсистемаИЭШаблоны.СоздаватьКонтрагентовПоОКПО,
	|	ПодсистемаИЭШаблоны.СоздаватьМаркиНоменклатуры,
	|	ПодсистемаИЭШаблоны.СоздаватьМетодыПолученияНоменклатуры,
	|	ПодсистемаИЭШаблоны.СоздаватьЭлементыСправочникаНоменклатураВСлучаеИхОтсутствия,
	|	ПодсистемаИЭШаблоны.СообщатьОНедостаточномЗаполненииПриЭкспортеДокументовДляПОБанка,
	|	ПодсистемаИЭШаблоны.СоставлятьНаименованиеГруппыРодителяИзИменПолей,
	|	ПодсистемаИЭШаблоны.СоставлятьНаименованиеПоВыражениюИзИменПолей,
	|	ПодсистемаИЭШаблоны.СоставлятьХарактеристикуПоВыражениюИзИменПолей,
	|	ПодсистемаИЭШаблоны.СпособПополненияНоменклатуры,
	|	ПодсистемаИЭШаблоны.СпособСписания,
	|	ПодсистемаИЭШаблоны.СтатьяДДСПоступленияПоУмолчанию,
	|	ПодсистемаИЭШаблоны.СтатьяДДСРасходаПоУмолчанию,
	|	ПодсистемаИЭШаблоны.СтрокаСортировкиДляСпискаЗадачИмпортаЭкспорта,
	|	ПодсистемаИЭШаблоны.СуммироватьДанныеДокументовРасходДСПланПриВыгрузкеДляОдногоКлиентаОтОднойОрганизацииВТеченииСуток,
	|	ПодсистемаИЭШаблоны.СуммироватьТолькоЕслиПлатежкиСОднимНомером,
	|	ПодсистемаИЭШаблоны.СчетУчетаТоваров,
	|	ПодсистемаИЭШаблоны.СчетУчетаЗатрат,
	|	ПодсистемаИЭШаблоны.ТекстПроизвольногоЗапроса,
	|	ПодсистемаИЭШаблоны.ТипНоменклатуры,
	|	ПодсистемаИЭШаблоны.ТолькоПриходные,
	|	ПодсистемаИЭШаблоны.ТолькоРасходные,
	|	ПодсистемаИЭШаблоны.УдалятьФайлПослеУдачногоИмпорта,
	|	ПодсистемаИЭШаблоны.УсловиеДебета,
	|	ПодсистемаИЭШаблоны.УсловиеДебетаЗначение,
	|	ПодсистемаИЭШаблоны.УсловиеДебетаПоле,
	|	ПодсистемаИЭШаблоны.УсловиеЗаголовкаБлокаДанных,
	|	ПодсистемаИЭШаблоны.УсловиеЗаголовкаБлокаДанныхЗначение,
	|	ПодсистемаИЭШаблоны.УсловиеЗаголовкаБлокаДанныхНаличиеПодстроки,
	|	ПодсистемаИЭШаблоны.УсловиеЗаголовкаБлокаДанныхПоле,
	|	ПодсистемаИЭШаблоны.УстанавливатьДатуДокументамПриИмпортеЕслиНеОпределена,
	|	ПодсистемаИЭШаблоны.УстанавливатьДоговорКлиентаЕслиПодходитТолькоОдин,
	|	ПодсистемаИЭШаблоны.УстанавливатьПервыйПодходящийДоговорКлиента,
	|	ПодсистемаИЭШаблоны.УстанавливатьПризнакАвансаДокументамДенежныхСредств,
	|	ПодсистемаИЭШаблоны.УстанавливатьТекущуюДатуДляДокументовЕслиНеОпределена,
	|	ПодсистемаИЭШаблоны.УстанавливатьФлагОбменаЗагрузки,
	|	ПодсистемаИЭШаблоны.ФайлАрхив,
	|	ПодсистемаИЭШаблоны.ФильтроватьНеподходящиеСимволы,
	|	ПодсистемаИЭШаблоны.ФорматПолейДаты,
	|	ПодсистемаИЭШаблоны.ФорматФайла,
	|	ПодсистемаИЭШаблоны.ФормироватьПервуюСтрокуИзЗаголовковПолей,
	|	ПодсистемаИЭШаблоны.ЧислоСтрокСКонцаФайлаКоторыеСледуетПропустить,
	|	ПодсистемаИЭШаблоны.ЧислоСтрокСНачалаФайлаКоторыеСледуетПропустить,
	|	ПодсистемаИЭШаблоны.ЭтоПлатежныйДокумент,
	|	ПодсистемаИЭШаблоны.ПоследовательностьПолейВФайле.(
	|		НомерСтроки,
	|		ПолеТаблицы,
	|		ДанноеПолеКлючевоеДляПоискаИЗаписи,
	|		ИмяПоляВФайле,
	|		КомментарийПоля,
	|		ЕслиНеЗаполненоЗначитПринимаетПредыдущееЗначение
	|	),
	|	ПодсистемаИЭШаблоны.УсловияФильтра.(
	|		НомерСтроки,
	|		НомерПоля,
	|		УсловиеРавенства,
	|		ЗначениеПоля,
	|		ПоведениеПриОбмене,
	|		Комментарий
	|	),
	|	ПодсистемаИЭШаблоны.ДополнительноеПоведение.(
	|		НомерСтроки,
	|		ЭлементПоведения
	|	),
	|	ПодсистемаИЭШаблоны.ОтборПоОрганизациям.(
	|		НомерСтроки,
	|		Организация
	|	),
	|	ПодсистемаИЭШаблоны.ОтборПоСчетамИКассам.(
	|		НомерСтроки,
	|		ХранилищеДС
	|	),
	|	ПодсистемаИЭШаблоны.ПоследовательностьПолейВЗаголовкеБлокаДанных.(
	|		НомерСтроки,
	|		ПолеТаблицы,
	|		ИмяПоляВФайле,
	|		КомментарийПоля,
	|		ЕслиНеЗаполненоЗначитПринимаетПредыдущееЗначение,
	|		ДанноеПолеКлючевоеДляПоискаИЗаписи
	|	),
	|	ПодсистемаИЭШаблоны.ТолькоДляОбъектовСРеквизитами.(
	|		НомерСтроки,
	|		КачествоУсловия,
	|		НаименованиеРеквизита,
	|		ИмяТаблицыРеквизита,
	|		ЗначениеРеквизита,
	|		Комментарий
	|	),
	|	ПодсистемаИЭШаблоны.ДополнительноеЗаполнениеРеквизитов.(
	|		НомерСтроки,
	|		НаименованиеРеквизита,
	|		ИмяТаблицыРеквизита,
	|		ЗначениеРеквизита,
	|		УстанавливатьТолькоЕслиЗначениеНеЗаполнено,
	|		Комментарий
	|	),
	|	ПодсистемаИЭШаблоны.ПараметрыПроизвольногоЗапроса.(
	|		НомерСтроки,
	|		НаименованиеПараметра,
	|		ЗначениеПараметра,
	|		Комментарий
	|	)
	|ИЗ Справочник.ПодсистемаИЭШаблоны КАК ПодсистемаИЭШаблоны
	|ГДЕ ПодсистемаИЭШаблоны.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);

	Выборка = Запрос.Выполнить().Выбрать();
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьПоследовательностьПолейВФайлеШапка = Макет.ПолучитьОбласть("ПоследовательностьПолейВФайлеШапка");
	ОбластьПоследовательностьПолейВФайле = Макет.ПолучитьОбласть("ПоследовательностьПолейВФайле");
	ОбластьУсловияФильтраШапка = Макет.ПолучитьОбласть("УсловияФильтраШапка");
	ОбластьУсловияФильтра = Макет.ПолучитьОбласть("УсловияФильтра");
	ОбластьДополнительноеПоведениеШапка = Макет.ПолучитьОбласть("ДополнительноеПоведениеШапка");
	ОбластьДополнительноеПоведение = Макет.ПолучитьОбласть("ДополнительноеПоведение");
	ОбластьОтборПоОрганизациямШапка = Макет.ПолучитьОбласть("ОтборПоОрганизациямШапка");
	ОбластьОтборПоОрганизациям = Макет.ПолучитьОбласть("ОтборПоОрганизациям");
	ОбластьОтборПоСчетамИКассамШапка = Макет.ПолучитьОбласть("ОтборПоСчетамИКассамШапка");
	ОбластьОтборПоСчетамИКассам = Макет.ПолучитьОбласть("ОтборПоСчетамИКассам");
	ОбластьПоследовательностьПолейВЗаголовкеБлокаДанныхШапка = Макет.ПолучитьОбласть("ПоследовательностьПолейВЗаголовкеБлокаДанныхШапка");
	ОбластьПоследовательностьПолейВЗаголовкеБлокаДанных = Макет.ПолучитьОбласть("ПоследовательностьПолейВЗаголовкеБлокаДанных");
	ОбластьТолькоДляОбъектовСРеквизитамиШапка = Макет.ПолучитьОбласть("ТолькоДляОбъектовСРеквизитамиШапка");
	ОбластьТолькоДляОбъектовСРеквизитами = Макет.ПолучитьОбласть("ТолькоДляОбъектовСРеквизитами");
	ОбластьДополнительноеЗаполнениеРеквизитовШапка = Макет.ПолучитьОбласть("ДополнительноеЗаполнениеРеквизитовШапка");
	ОбластьДополнительноеЗаполнениеРеквизитов = Макет.ПолучитьОбласть("ДополнительноеЗаполнениеРеквизитов");
	ОбластьПараметрыПроизвольногоЗапросаШапка = Макет.ПолучитьОбласть("ПараметрыПроизвольногоЗапросаШапка");
	ОбластьПараметрыПроизвольногоЗапроса = Макет.ПолучитьОбласть("ПараметрыПроизвольногоЗапроса");
	ДокументДляПечати.ИмяПараметровПечати  = "ИЭШаблон" + СокрЛП(ИмяКомпьютера());
	ДокументДляПечати.КлючПараметровПечати = ДокументДляПечати.ИмяПараметровПечати;
	ДокументДляПечати.Очистить();
	ВставлятьРазделительСтраниц = ЛОЖЬ;

	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ДокументДляПечати.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(ОбластьЗаголовок);
		ДокументДляПечати.Вывести(ОбластьЗаголовок);
		Шапка.Параметры.Заполнить(Выборка);
		ОбщийМодульСервисСервер.ЗаменитьСвоиЗначенияПараметровПечати(Шапка);
		ДокументДляПечати.Вывести(Шапка, Выборка.Уровень());
		ДокументДляПечати.Вывести(ОбластьПоследовательностьПолейВФайлеШапка);
		ВыборкаПоследовательностьПолейВФайле = Выборка.ПоследовательностьПолейВФайле.Выбрать();

		Пока ВыборкаПоследовательностьПолейВФайле.Следующий() Цикл
			ОбластьПоследовательностьПолейВФайле.Параметры.Заполнить(ВыборкаПоследовательностьПолейВФайле);
			ДокументДляПечати.Вывести(ОбластьПоследовательностьПолейВФайле, ВыборкаПоследовательностьПолейВФайле.Уровень());
		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьУсловияФильтраШапка);
		ВыборкаУсловияФильтра = Выборка.УсловияФильтра.Выбрать();
		Пока ВыборкаУсловияФильтра.Следующий() Цикл
			ОбластьУсловияФильтра.Параметры.Заполнить(ВыборкаУсловияФильтра);
			ДокументДляПечати.Вывести(ОбластьУсловияФильтра, ВыборкаУсловияФильтра.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьДополнительноеПоведениеШапка);
		ВыборкаДополнительноеПоведение = Выборка.ДополнительноеПоведение.Выбрать();
		Пока ВыборкаДополнительноеПоведение.Следующий() Цикл
			ОбластьДополнительноеПоведение.Параметры.Заполнить(ВыборкаДополнительноеПоведение);
			ДокументДляПечати.Вывести(ОбластьДополнительноеПоведение, ВыборкаДополнительноеПоведение.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьОтборПоОрганизациямШапка);
		ВыборкаОтборПоОрганизациям = Выборка.ОтборПоОрганизациям.Выбрать();
		Пока ВыборкаОтборПоОрганизациям.Следующий() Цикл
			ОбластьОтборПоОрганизациям.Параметры.Заполнить(ВыборкаОтборПоОрганизациям);
			ДокументДляПечати.Вывести(ОбластьОтборПоОрганизациям, ВыборкаОтборПоОрганизациям.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьОтборПоСчетамИКассамШапка);
		ВыборкаОтборПоСчетамИКассам = Выборка.ОтборПоСчетамИКассам.Выбрать();
		Пока ВыборкаОтборПоСчетамИКассам.Следующий() Цикл
			ОбластьОтборПоСчетамИКассам.Параметры.Заполнить(ВыборкаОтборПоСчетамИКассам);
			ДокументДляПечати.Вывести(ОбластьОтборПоСчетамИКассам, ВыборкаОтборПоСчетамИКассам.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьПоследовательностьПолейВЗаголовкеБлокаДанныхШапка);
		ВыборкаПоследовательностьПолейВЗаголовкеБлокаДанных = Выборка.ПоследовательностьПолейВЗаголовкеБлокаДанных.Выбрать();
		Пока ВыборкаПоследовательностьПолейВЗаголовкеБлокаДанных.Следующий() Цикл
			ОбластьПоследовательностьПолейВЗаголовкеБлокаДанных.Параметры.Заполнить(ВыборкаПоследовательностьПолейВЗаголовкеБлокаДанных);
			ДокументДляПечати.Вывести(ОбластьПоследовательностьПолейВЗаголовкеБлокаДанных, ВыборкаПоследовательностьПолейВЗаголовкеБлокаДанных.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьТолькоДляОбъектовСРеквизитамиШапка);
		ВыборкаТолькоДляОбъектовСРеквизитами = Выборка.ТолькоДляОбъектовСРеквизитами.Выбрать();
		Пока ВыборкаТолькоДляОбъектовСРеквизитами.Следующий() Цикл
			ОбластьТолькоДляОбъектовСРеквизитами.Параметры.Заполнить(ВыборкаТолькоДляОбъектовСРеквизитами);
			ДокументДляПечати.Вывести(ОбластьТолькоДляОбъектовСРеквизитами, ВыборкаТолькоДляОбъектовСРеквизитами.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьДополнительноеЗаполнениеРеквизитовШапка);
		ВыборкаДополнительноеЗаполнениеРеквизитов = Выборка.ДополнительноеЗаполнениеРеквизитов.Выбрать();
		Пока ВыборкаДополнительноеЗаполнениеРеквизитов.Следующий() Цикл
			ОбластьДополнительноеЗаполнениеРеквизитов.Параметры.Заполнить(ВыборкаДополнительноеЗаполнениеРеквизитов);
			ДокументДляПечати.Вывести(ОбластьДополнительноеЗаполнениеРеквизитов, ВыборкаДополнительноеЗаполнениеРеквизитов.Уровень());

		КонецЦикла;

		ДокументДляПечати.Вывести(ОбластьПараметрыПроизвольногоЗапросаШапка);
		ВыборкаПараметрыПроизвольногоЗапроса = Выборка.ПараметрыПроизвольногоЗапроса.Выбрать();
		Пока ВыборкаПараметрыПроизвольногоЗапроса.Следующий() Цикл
			ОбластьПараметрыПроизвольногоЗапроса.Параметры.Заполнить(ВыборкаПараметрыПроизвольногоЗапроса);
			ДокументДляПечати.Вывести(ОбластьПараметрыПроизвольногоЗапроса, ВыборкаПараметрыПроизвольногоЗапроса.Уровень());

		КонецЦикла;

		ВставлятьРазделительСтраниц = ИСТИНА;
	КонецЦикла;

КонецПроцедуры

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
