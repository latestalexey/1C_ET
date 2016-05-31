﻿// sza141224-1541 остроке поля
// sza140420-2103
// sza140115-1150 :
// sza131227-1839
// sza131119-2322
// sza110426-2358 ПризнакДебетаОтрицательнаяСумма
// sza110302-0002 СуммироватьТолькоЕслиПлатежкиСОднимНомером
// sza110224-1842
// sza110217-1136 СообщатьОНедостаточномЗаполненииПриЭкспортеДокументовДляПОБанка
// sza110216-1635 файл архив
// sza110214-1435 ПодсистемаИЭ.КонстантыОтносительныйАдресФайловПолучить()
// sza110213-0113 ИскатьВПодкаталогах
// sza110211-1208 загрузка папки
// sza110209-1214 удалять файл
// sza110207-1738 ВставлятьМеждуТекстамиНазначенияСледующийТекст
// sza110202-1753
// sza110128-0225
// sza110126-1820
// sza110126-0009
// sza110120-0213
// sza110119-1544
// sza110118-1722
// sza110114-1724
// sza110112-1607
// sza110111-0045
// sza110110-1612
// sza110110-0305
// sza110109-2232
// sza110108-0122
// sza110107-1157
// sza110106-1823
// sza101227-2349
// sza101222-2035
// sza101222-1312
// sza101222-0131
// sza101216-0153
// sza101210-0254
// sza101207-1617
// sza101206-1602
// sza101206-1330
// sza101205-2155
// sza101204-0120
// sza101203-0151
// sza101201-1315
// sza101116-1358
// sza101115-1808
// sza101114-0223
// sza101110-1747
// sza101109-1703
// sza101109-0032
// sza101105-1627
// sza101103
// sza101025
//

&НаСервере
Процедура ВыполнитьЗагрузкуШаблоновНаСервере(АдресФайла)

	БазаДБФБазаШаблонов = Новый XBase;
	БазаДБФБазаШаблонов.ОткрытьФайл(АдресФайла);
	КоличествоЗаписейДБФБазаШаблонов = БазаДБФБазаШаблонов.КоличествоЗаписей();
	Если БазаДБФБазаШаблонов.Первая() Тогда

		ЗапШаблонСТакимИменем = Новый Запрос;
		ЗапШаблонСТакимИменем.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1 ШаблонФайла.Ссылка
		|ИЗ Справочник.ПодсистемаИЭШаблоны КАК ШаблонФайла
		|ГДЕ ШаблонФайла.Наименование = &Наименование И ШаблонФайла.ПометкаУдаления = ЛОЖЬ"; // ВЫБРАТЬ ПЕРВЫЕ 1

		Пока ИСТИНА Цикл
			ИмяТекущегоШаблона = СокрЛП(БазаДБФБазаШаблонов.NAIMENSH);
			ЗапШаблонСТакимИменем.УстановитьПараметр("Наименование", ИмяТекущегоШаблона);

			ВзШаблонСТакимИменем = ЗапШаблонСТакимИменем.Выполнить();

			Если ВзШаблонСТакимИменем.Пустой() Тогда
				ШаблонФайла = Справочники.ПодсистемаИЭШаблоны.СоздатьЭлемент();
			Иначе
				ВШаблонСТакимИменем = ВзШаблонСТакимИменем.Выбрать();
				ВШаблонСТакимИменем.Следующий();
				ШаблонФайла = ВШаблонСТакимИменем.Ссылка.ПолучитьОбъект();
			КонецЕсли;

			ШаблонФайла.КодировкаDOS 	 = ?(БазаДБФБазаШаблонов.CODE_DOS = 1, ИСТИНА, ЛОЖЬ);
			ШаблонФайла.Комментарий 	 = СокрЛП(БазаДБФБазаШаблонов.COMMENTR);
			ШаблонФайла.Наименование 	 = СокрЛП(БазаДБФБазаШаблонов.NAIMENSH);
			ШаблонФайла.РазделительПолей = СокрЛП(БазаДБФБазаШаблонов.RAZDELIT);
			ШаблонФайла.ФормироватьПервуюСтрокуИзЗаголовковПолей = ?(БазаДБФБазаШаблонов.FORMPERS = 1, ИСТИНА, ЛОЖЬ);
			ШаблонФайла.ИспользоватьСтрокуЗаголовок = СокрЛП(БазаДБФБазаШаблонов.STROZAGO);
			ШаблонФайла.РазделительЧисел = СокрЛП(БазаДБФБазаШаблонов.RAZDELCH);
			ШаблонФайла.СоздаватьЭлементыСправочникаНоменклатураВСлучаеИхОтсутствия = ?(БазаДБФБазаШаблонов.SOZDELNM = 1, ИСТИНА, ЛОЖЬ);
			ШаблонФайла.ФорматПолейДаты  = СокрЛП(БазаДБФБазаШаблонов.FORMDATA);
			ШаблонФайла.НеПропускатьНепроведенныеДокументы = ?(БазаДБФБазаШаблонов.NEPRNPRV = 1, ИСТИНА, ЛОЖЬ);
			ШаблонФайла.НеПропускатьОбъектыПомеченныеНаУдаление = ?(БазаДБФБазаШаблонов.NEPRUDAL = 1, ИСТИНА, ЛОЖЬ);
			ШаблонФайла.НомерПоляКотороеВсегдаЗаполнено = БазаДБФБазаШаблонов.NOMPOLVZ;
			ШаблонФайла.ЧислоСтрокСНачалаФайлаКоторыеСледуетПропустить = БазаДБФБазаШаблонов.PROPSTRK;
			ШаблонФайла.АдресФайла = СокрЛП(БазаДБФБазаШаблонов.ADRSFILE);
			ШаблонФайла.ВыдаватьЗапросДляИнтервалаДокументов = ?(БазаДБФБазаШаблонов.ZAPRINDO = 1, ИСТИНА, ЛОЖЬ);
			БазаДБФПоляШаблонов = Новый XBase;
			БазаДБФПоляШаблонов.ОткрытьФайл(лев(АдресФайла, стрдлина(АдресФайла)-5)+"1.DBf");
			КоличествоЗаписейДБФПоляШаблонов = БазаДБФПоляШаблонов.КоличествоЗаписей();
			ШаблонФайла.ПоследовательностьПолейВЗаголовкеБлокаДанных.Очистить();
			ШаблонФайла.ПоследовательностьПолейВФайле.Очистить();

			Если БазаДБФПоляШаблонов.Первая() Тогда
				Пока ИСТИНА Цикл
					Если БазаДБФПоляШаблонов.COD = БазаДБФБазаШаблонов.COD Тогда
						Попытка
							Если БазаДБФПоляШаблонов.ZBD = 1 Тогда

								полеНовогоШаблона = ШаблонФайла.ПоследовательностьПолейВЗаголовкеБлокаДанных.Добавить();
							Иначе
								полеНовогоШаблона = ШаблонФайла.ПоследовательностьПолейВФайле.Добавить();
							КонецЕсли;

						Исключение 	// устарел
							полеНовогоШаблона = ШаблонФайла.ПоследовательностьПолейВФайле.Добавить();
						КонецПопытки;

						Если НЕ СокрЛП(БазаДБФПоляШаблонов.POLETABL) = "" Тогда
							полеНовогоШаблона.ПолеТаблицы = Справочники.ПодсистемаИЭПоля.НайтиПоКоду(БазаДБФПоляШаблонов.POLETABL);
						Иначе
							полеНовогоШаблона.ПолеТаблицы = Справочники.ПодсистемаИЭПоля.НайтиПоНаименованию(СокрЛП(БазаДБФПоляШаблонов.POLNTABL), ИСТИНА);

							Если НЕ ЗначениеЗаполнено(полеНовогоШаблона.ПолеТаблицы) Тогда
								НовоеПолеВСистеме = Справочники.ПодсистемаИЭПоля.СоздатьЭлемент();
								НовоеПолеВСистеме.ДлинаТут 		= БазаДБФПоляШаблонов.D;
								НовоеПолеВСистеме.Комментарий 	= СокрЛП(БазаДБФПоляШаблонов.C);
								НовоеПолеВСистеме.Наименование  = СокрЛП(БазаДБФПоляШаблонов.POLNTABL);
								НовоеПолеВСистеме.ТипТут		= БазаДБФПоляШаблонов.T;
								НовоеПолеВСистеме.ТочностьТут   = БазаДБФПоляШаблонов.TO;
								НовоеПолеВСистеме.ПолеПринадлежитОбъектуТаблицы = ?(БазаДБФПоляШаблонов.PPO = 1, ИСТИНА, ЛОЖЬ);
								НовоеПолеВСистеме.ОпределенноеЗначение 		= БазаДБФПоляШаблонов.OZ;
								НовоеПолеВСистеме.ЗаголовокПоляПоУмолчанию  = СокрЛП(БазаДБФПоляШаблонов.ZPU);
								Попытка
									НовоеПолеВСистеме.Коэффициент = БазаДБФПоляШаблонов.K;
								Исключение
								КонецПопытки;
								НовоеПолеВСистеме.Записать();
								полеНовогоШаблона.ПолеТаблицы = НовоеПолеВСистеме.Ссылка;
							КонецЕсли;
						КонецЕсли;

						полеНовогоШаблона.КомментарийПоля = СокрЛП(БазаДБФПоляШаблонов.COMMENTR);
						полеНовогоШаблона.ДанноеПолеКлючевоеДляПоискаИЗаписи = ?(БазаДБФПоляШаблонов.KEY_POLE = 1, ИСТИНА, ЛОЖЬ);
						полеНовогоШаблона.ИмяПоляВФайле = СокрЛП(БазаДБФПоляШаблонов.NAMEINFL);
						Попытка
							полеНовогоШаблона.ЕслиНеЗаполненоЗначитПринимаетПредыдущееЗначение = ?(БазаДБФПоляШаблонов.ENZTPS = 1, ИСТИНА, ЛОЖЬ);
							полеНовогоШаблона.Остроке = СокрЛП(БазаДБФПоляШаблонов.OSTROKE);
						Исключение
						КонецПопытки;
					КонецЕсли;

					Если НЕ БазаДБФПоляШаблонов.Следующая() Тогда
						Прервать;
					КонецЕсли;
				КонецЦикла; // обхода ДБФ ПоляШаблонов
			КонецЕсли;

			БазаДБФПоляШаблонов.ЗакрытьФайл();
			Попытка
				Если БазаДБФБазаШаблонов.VIDSHABL = 1 Тогда

					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляКарточкиСправочникаИлиШапкиДокумента;
				ИначеЕсли БазаДБФБазаШаблонов.VIDSHABL = 2 Тогда
					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляСпискаЭлементовСправочникаИлиДокументов;
				ИначеЕсли БазаДБФБазаШаблонов.VIDSHABL = 3 Тогда
					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляТаблицыТовары;
				ИначеЕсли БазаДБФБазаШаблонов.VIDSHABL = 4 Тогда
					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляОбменаСБанком;
				ИначеЕсли БазаДБФБазаШаблонов.VIDSHABL = 5 Тогда
					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.РезультатПроизвольногоЗапроса;
				ИначеЕсли БазаДБФБазаШаблонов.VIDSHABL = 6 Тогда
					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляРегистровСведений;
				Иначе // 0
					ШаблонФайла.ВидШаблона = Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.FILE_VER = 1 Тогда
					ШаблонФайла.ФорматФайла = Перечисления.ПодсистемаИЭИмпортЭкспортФорматыФайлов.DBF ;
				ИначеЕсли БазаДБФБазаШаблонов.FILE_VER = 2 ТОгда
					ШаблонФайла.ФорматФайла = Перечисления.ПодсистемаИЭИмпортЭкспортФорматыФайлов.XLS ;
				ИначеЕсли БазаДБФБазаШаблонов.FILE_VER = 3 ТОгда
					// пока нет XML
// 					ШаблонФайла.ФорматФайла = Перечисления.ПодсистемаИЭИмпортЭкспортФорматыФайлов.XML ;
				Иначе // txt
					// БазаДБФБазаШаблонов.FILE_XLS = 0;
					ШаблонФайла.ФорматФайла = Перечисления.ПодсистемаИЭИмпортЭкспортФорматыФайлов.TXT;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.IT = 1 ТОгда
					ШаблонФайла.ИспользоватьТолькоДляИмпорта = ИСТИНА;
				ИначеЕсли БазаДБФБазаШаблонов.IT = 2 ТОгда
					ШаблонФайла.ИспользоватьТолькоДляЭкспорта = ИСТИНА;
				Иначе
					ШаблонФайла.ИспользоватьТолькоДляЭкспорта = ЛОЖЬ;
					ШаблонФайла.ИспользоватьТолькоДляИмпорта = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.КодировкаФайла = СокрЛП(БазаДБФБазаШаблонов.KODIROV);

				Если НЕ ЗначениеЗаполнено(ШаблонФайла.КодировкаФайла) Тогда
					ШаблонФайла.КодировкаФайла = "ANSI";
				КонецЕсли;

				ШаблонФайла.РазделительДаты = СокрЛП(БазаДБФБазаШаблонов.RAZDELDA);
				ШаблонФайла.ДопустимоеЧислоПустыхСтрокПриПоискеКонцаФайла = БазаДБФБазаШаблонов.DOPUSTRO;
				Если БазаДБФБазаШаблонов.USTTDDEN = 1 Тогда
					ШаблонФайла.УстанавливатьТекущуюДатуДляДокументовЕслиНеОпределена = ИСТИНА;
				Иначе
					ШаблонФайла.УстанавливатьТекущуюДатуДляДокументовЕслиНеОпределена = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.МаскаФайла = СокрЛП(БазаДБФБазаШаблонов.MASKFILE);
				ШаблонФайла.ИмяТаблицыШаблонаФайла = СокрЛП(БазаДБФБазаШаблонов.ITAB);
				Если БазаДБФБазаШаблонов.SHOWOBMN = 1 Тогда
					ШаблонФайла.ПоказыватьПрогрессПроизводстваОбмена = ИСТИНА;
				Иначе
					ШаблонФайла.ПоказыватьПрогрессПроизводстваОбмена = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.RASROKOB = 1 ТОгда
					ШаблонФайла.РассчитыватьСрокОкончанияОбмена = ИСТИНА;
				Иначе
					ШаблонФайла.РассчитыватьСрокОкончанияОбмена = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.SHOWOBJS = 1 Тогда
					ШаблонФайла.ПоказыватьОбъектыОбмена = ИСТИНА;
				Иначе
					ШаблонФайла.ПоказыватьОбъектыОбмена = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.NOTCLOSE = 1 Тогда
					ШаблонФайла.НеЗакрыватьОкноПеречняОбъектовОбмена = ИСТИНА;
				Иначе
					ШаблонФайла.НеЗакрыватьОкноПеречняОбъектовОбмена = ЛОЖЬ;
				КонецЕсли;

				БазаДБФПоляШаблонов = Новый XBase;
				БазаДБФПоляШаблонов.ОткрытьФайл(лев(АдресФайла, стрдлина(АдресФайла)-5)+"2.DBf");
				КоличествоЗаписейДБФПоляШаблонов = БазаДБФПоляШаблонов.КоличествоЗаписей();
				ШаблонФайла.УсловияФильтра.Очистить();

				Если БазаДБФПоляШаблонов.Первая() Тогда
					Пока ИСТИНА Цикл
						Если БазаДБФПоляШаблонов.COD = БазаДБФБазаШаблонов.COD Тогда
							полеНовогоШаблона = ШаблонФайла.УсловияФильтра.Добавить();
							полеНовогоШаблона.НомерПоля 		= БазаДБФБазаШаблонов.NP ;
							полеНовогоШаблона.Комментарий 		= СокрЛП(БазаДБФПоляШаблонов.COMMENTR);
							полеНовогоШаблона.УсловиеРавенства 	= СокрЛП(БазаДБФПоляШаблонов.UR);
							полеНовогоШаблона.ЗначениеПоля 		= СокрЛП(БазаДБФПоляШаблонов.ZN);;
							полеНовогоШаблона.ИмяПоляВФайле 	= СокрЛП(БазаДБФПоляШаблонов.NAMEINFL);
							Поведение = БазаДБФПоляШаблонов.P;

							Если Поведение = 1 Тогда
								полеНовогоШаблона.ПоведениеПриОбмене = Перечисления.ПодсистемаИЭИмпортЭкспортВидыПоведенияФильтра.Пропустить ;
							ИначеЕсли Поведение = 2 Тогда
								полеНовогоШаблона.ПоведениеПриОбмене = Перечисления.ПодсистемаИЭИмпортЭкспортВидыПоведенияФильтра.ПропуститьПриИмпорте ;
							ИначеЕсли Поведение = 3 Тогда
								полеНовогоШаблона.ПоведениеПриОбмене = Перечисления.ПодсистемаИЭИмпортЭкспортВидыПоведенияФильтра.ПропуститьПриЭкспорте ;
							ИначеЕсли Поведение = 4 Тогда
								полеНовогоШаблона.ПоведениеПриОбмене = Перечисления.ПодсистемаИЭИмпортЭкспортВидыПоведенияФильтра.ПринятьПустоеЗначение ;
							КонецЕсли;
						КонецЕсли;

						Если НЕ БазаДБФПоляШаблонов.Следующая() Тогда Прервать;
						КонецЕсли;
					КонецЦикла; // обхода ДБФ ПоляШаблонов
				КонецЕсли;

				БазаДБФПоляШаблонов.ЗакрытьФайл();
				ЕдиницаИзмерения = СокрЛП(БазаДБФБазаШаблонов.EINN);
				// Если ЗначениеЗаполнено(ЕдиницаИзмерения) Тогда
				// 	ШаблонФайла.ЕдиницаИзмеренияНоменклатуры = Справочники.КлассификаторЕдиницИзмерения.НайтиПоНаименованию(ЕдиницаИзмерения);
				// КонецЕсли;

				//
				// Если БазаДБФБазаШаблонов.SPNN = 1 Тогда

				// 	ШаблонФайла.СпособПополненияНоменклатуры = Перечисления.СпособыПополненияТоваров.Производство ;
				// ИначеЕсли БазаДБФБазаШаблонов.SPNN = 2 Тогда
				// 	ШаблонФайла.СпособПополненияНоменклатуры = Перечисления.СпособыПополненияТоваров.Переработка ;
				// ИначеЕсли БазаДБФБазаШаблонов.SPNN = 3 Тогда
				// 	ШаблонФайла.СпособПополненияНоменклатуры = Перечисления.СпособыПополненияТоваров.ЗакупкаТовара ;
				// КонецЕсли;

				// СчетУчетаТоваров = СокрЛП(БазаДБФБазаШаблонов.SUZPNN);

				// Если ЗначениеЗаполнено(СчетУчетаТоваров) Тогда
				// 	ШаблонФайла.СчетУчетаТоваров = ПланыСчетов.Управленческий.НайтиПоКоду(СчетУчетаТоваров);
				// КонецЕсли;

				// СчетУчетаЗатрат = СокрЛП(БазаДБФБазаШаблонов.SUZTNN);

				// Если ЗначениеЗаполнено(СчетУчетаЗатрат) Тогда
				// 	ШаблонФайла.СчетУчетаЗатрат = ПланыСчетов.Управленческий.НайтиПоКоду(СчетУчетаЗатрат);
				// КонецЕсли;

				//
				// ТипНоменклатуры = БазаДБФБазаШаблонов.TIPNN;
				// Если ТипНоменклатуры = 1 Тогда
				// 	ШаблонФайла.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.ВидРабот ;
				// ИначеЕсли ТипНоменклатуры = 2 Тогда
				// 	ШаблонФайла.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Запас;
				// ИначеЕсли ТипНоменклатуры = 3 Тогда
				// 	ШаблонФайла.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Операция;
				// ИначеЕсли ТипНоменклатуры = 4 Тогда
				// 	ШаблонФайла.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Работа;
				// ИначеЕсли ТипНоменклатуры = 5 Тогда
				// 	ШаблонФайла.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Расход;
				// ИначеЕсли ТипНоменклатуры = 6 Тогда
				// 	ШаблонФайла.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Услуга;
				// КонецЕсли;

				//
				// Если БазаДБФБазаШаблонов.SMN = 1 Тогда

				// 	ШаблонФайла.СоздаватьМаркиНоменклатуры = ИСТИНА;
				// иначе
				// 	ШаблонФайла.СоздаватьМаркиНоменклатуры = ЛОЖЬ;
				// КонецЕсли;

				// Если БазаДБФБазаШаблонов.SMPN = 1 Тогда
				// 	ШаблонФайла.СоздаватьМетодыПолученияНоменклатуры = ИСТИНА;
				// Иначе
				// 	ШаблонФайла.СоздаватьМетодыПолученияНоменклатуры = ЛОЖЬ;
				// КонецЕсли;

				ШаблонФайла.СоставлятьНаименованиеПоВыражениюИзИменПолей = СокрЛП(БазаДБФБазаШаблонов.VIRNAIM);

				Если БазаДБФБазаШаблонов.DOSO = 1 Тогда
					ШаблонФайла.ДляОбновленияСуществующихОбъектов = ИСТИНА;
				Иначе
					ШаблонФайла.ДляОбновленияСуществующихОбъектов = ЛОЖЬ;
				КонецЕсли;

				// ШаблонФайла.СоставлятьХарактеристикуПоВыражениюИзИменПолей = СокрЛП(БазаДБФБазаШаблонов.HIRNAIM);
				ШаблонФайла.РазделительВСоставномНаименовании = СокрЛП(БазаДБФБазаШаблонов.RAZVSIM);
				Если ШаблонФайла.РазделительВСоставномНаименовании = "Пробел" Тогда
					ШаблонФайла.РазделительВСоставномНаименовании = " ";
				КонецЕсли;

				ШаблонФайла.НоменклатурнаяГруппа = Справочники.НоменклатурныеГруппы.НайтиПоНаименованию(СокрЛП(БазаДБФБазаШаблонов.NG));
				ШаблонФайла.НомерЛиста = БазаДБФБазаШаблонов.NAMELIST;
				ШаблонФайла.СоставлятьНаименованиеГруппыРодителяИзИменПолей = СокрЛП(БазаДБФБазаШаблонов.SRIP);
				// Попытка
				// 	ШаблонФайла.Производитель = Справочники.SZМаркиНоменклатуры.НайтиПоНаименованию(СокрЛП(БазаДБФБазаШаблонов.MK));
				// Исключение
				// КонецПопытки;
				ШаблонФайла.ВыполнитьПрограммныйКодВНачалеЗагрузкиКаждогоПоля = СокрЛП(БазаДБФБазаШаблонов.ST1);
				ШаблонФайла.ВыполнитьПрограммныйКодВНачалеЗагрузкиСтроки = СокрЛП(БазаДБФБазаШаблонов.ST2);
				ШаблонФайла.ВыполнитьПрограммныйКодПередНачалом = СокрЛП(БазаДБФБазаШаблонов.ST3);
				ШаблонФайла.ВыполнитьПрограммныйКодПослеОкончания = СокрЛП(БазаДБФБазаШаблонов.ST4);
				ШаблонФайла.ВыполнитьПрограммныйКодПослеОкончанияЗагрузкиКаждогоПоля = СокрЛП(БазаДБФБазаШаблонов.ST5);
				ШаблонФайла.ВыполнитьПрограммныйКодПослеОкончанияЗагрузкиСтроки = СокрЛП(БазаДБФБазаШаблонов.ST6);
// 		ШаблонФайла.НаправлениеДеятельности = Справочники.НаправленияДеятельности.НайтиПоНаименованию(СокрЛП(БазаДБФБазаШаблонов.NAPRV));

				// Если БазаДБФБазаШаблонов.SPSPS = 1 Тогда
				// 	ШаблонФайла.СпособСписания = Перечисления.МетодОценкиТоваров.FIFO;
				// ИначеЕсли БазаДБФБазаШаблонов.SPSPS = 2 Тогда
				// 	ШаблонФайла.СпособСписания = Перечисления.МетодОценкиТоваров.ПоСредней;
				// КонецЕсли;

				ШаблонФайла.ГруппаДляНовойНоменклатуры = Справочники.Номенклатура.НайтиПоНаименованию(СокрЛП(БазаДБФБазаШаблонов.GNN));

				Если ЗначениеЗаполнено(ШаблонФайла.ГруппаДляНовойНоменклатуры)
					И НЕ ОбщийМодульПовтор.ЭтоГруппа(ШаблонФайла.ГруппаДляНовойНоменклатуры) Тогда

					ШаблонФайла.ГруппаДляНовойНоменклатуры = Справочники.Номенклатура.ПустаяСсылка();
				КонецЕсли;

				Если БазаДБФБазаШаблонов.VIPPR = 1 Тогда
					ШаблонФайла.ВыполнятьПрограммы = ИСТИНА;
				Иначе
					ШаблонФайла.ВыполнятьПрограммы = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.FILNS = 1 Тогда
					ШаблонФайла.ФильтроватьНеподходящиеСимволы = ИСТИНА;
				Иначе
					ШаблонФайла.ФильтроватьНеподходящиеСимволы = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.KPNS = 1 Тогда
					ШаблонФайла.КаждоеПолеНоваяСтрока = ИСТИНА;
				Иначе
					ШаблонФайла.КаждоеПолеНоваяСтрока = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.PSMZ = 1 Тогда
					ШаблонФайла.ПустыеСтрокиМеждуЗаписями = ИСТИНА;
				Иначе
					ШаблонФайла.ПустыеСтрокиМеждуЗаписями = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.ESPD = 1 Тогда
					ШаблонФайла.ЭтоПлатежныйДокумент = ИСТИНА;
				Иначе
					ШаблонФайла.ЭтоПлатежныйДокумент = ЛОЖЬ;
				КонецЕсли;

				// ШаблонФайла.ВалютаНеНациональная = Справочники.Валюты.НайтиПоКоду(СокрЛП(БазаДБФБазаШаблонов.VNN));
				ШаблонФайла.ОбрабатыватьПлатежныеДокументы = СокрЛП(БазаДБФБазаШаблонов.OPD);
				Если БазаДБФБазаШаблонов.TPRIP = 1 Тогда
					ШаблонФайла.ТолькоПриходные = ИСТИНА;
				Иначе
					ШаблонФайла.ТолькоПриходные = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.TRASP = 1 Тогда
					ШаблонФайла.ТолькоРасходные = ИСТИНА;
				Иначе
					ШаблонФайла.ТолькоРасходные = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.РазделителиВстречаютсяМеждуЗнаками = СокрЛП(БазаДБФБазаШаблонов.RVMZ);
				ШаблонФайла.УсловиеДебетаПоле 		= СокрЛП(БазаДБФБазаШаблонов.USLDP);
				ШаблонФайла.УсловиеДебета 			= СокрЛП(БазаДБФБазаШаблонов.USLD);
				ШаблонФайла.УсловиеДебетаЗначение 	= СокрЛП(БазаДБФБазаШаблонов.USLDZ);

				Если БазаДБФБазаШаблонов.SBSK = 1 Тогда
					ШаблонФайла.СоздаватьБанковскиеСчетаКлиентов = ИСТИНА;
				Иначе
					ШаблонФайла.СоздаватьБанковскиеСчетаКлиентов = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.SKPO = 1 Тогда
					ШаблонФайла.СоздаватьКонтрагентовПоОКПО = ИСТИНА;
				Иначе
					ШаблонФайла.СоздаватьКонтрагентовПоОКПО = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.SDK = 1 Тогда
					ШаблонФайла.СоздаватьДоговораКлиентов = ИСТИНА;
				Иначе
					ШаблонФайла.СоздаватьДоговораКлиентов = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.NIPSF = 1 Тогда
					ШаблонФайла.НеУчитыватьПоследнююСтрокуФайла = ИСТИНА;
				Иначе
					ШаблонФайла.НеУчитыватьПоследнююСтрокуФайла = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.ПропуститьЧислоСимволовСНачалаСтроки = БазаДБФБазаШаблонов.PROPNS;
				ШаблонФайла.ПропуститьЧислоСимволовВКонцеСтроки 	= БазаДБФБазаШаблонов.PROPKS;
				Если БазаДБФБазаШаблонов.POPRDO = 1 Тогда
					ШаблонФайла.ПопытатьсяПроводитьДокументы = ИСТИНА;
				Иначе
					ШаблонФайла.ПопытатьсяПроводитьДокументы = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.ISZBD = 1 Тогда
					ШаблонФайла.ИспользоватьЗаголовкиБлоковДанных = ИСТИНА;
				Иначе
					ШаблонФайла.ИспользоватьЗаголовкиБлоковДанных = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.УсловиеЗаголовкаБлокаДанныхПоле 				= СокрЛП(БазаДБФБазаШаблонов.USLZDP);
				ШаблонФайла.УсловиеЗаголовкаБлокаДанных 					= СокрЛП(БазаДБФБазаШаблонов.USLZD);
				ШаблонФайла.УсловиеЗаголовкаБлокаДанныхЗначение 			= СокрЛП(БазаДБФБазаШаблонов.USLZDZ);
				ШаблонФайла.УсловиеЗаголовкаБлокаДанныхНаличиеПодстроки		= СокрЛП(БазаДБФБазаШаблонов.USLZDZP);
				ШаблонФайла.РазделительПолейАльтернативный 					= СокрЛП(БазаДБФБазаШаблонов.RAZDELIT2);
				ШаблонФайла.ЧислоСтрокСКонцаФайлаКоторыеСледуетПропустить 	= БазаДБФБазаШаблонов.CHSKPRO;
				ШаблонФайла.ДобавитьТекстВШапкуФайла						= СокрЛП(БазаДБФБазаШаблонов.TSF);
				ШаблонФайла.ДобаватьТекстВПодвалФайла						= СокрЛП(БазаДБФБазаШаблонов.TPF);

				Если БазаДБФБазаШаблонов.NODOUSDV = 1 Тогда
					ШаблонФайла.НомерДокументаУстанавливатьНоНомеруВходящегоИлиИсходящегоДокумента = ИСТИНА;
				Иначе
					ШаблонФайла.НомерДокументаУстанавливатьНоНомеруВходящегоИлиИсходящегоДокумента = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.USD1 = 1 Тогда
					ШаблонФайла.УстанавливатьПервыйПодходящийДоговорКлиента = ИСТИНА;
				Иначе
					ШаблонФайла.УстанавливатьПервыйПодходящийДоговорКлиента = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.USDS1 = 1 Тогда
					ШаблонФайла.УстанавливатьДоговорКлиентаЕслиПодходитТолькоОдин = ИСТИНА;
				Иначе
					ШаблонФайла.УстанавливатьДоговорКлиентаЕслиПодходитТолькоОдин = ЛОЖЬ;
				КонецЕсли;

				Если НЕ СокрЛП(БазаДБФБазаШаблонов.SDDSR) = "" Тогда
					ШаблонФайла.СтатьяДДСРасходаПоУмолчанию = Справочники.СтатьиДвиженияДенег.НайтиПоКоду(СокрЛП(БазаДБФБазаШаблонов.SDDSR));
				КонецЕсли;

				Если НЕ СокрЛП(БазаДБФБазаШаблонов.SDDSP) = "" Тогда
					ШаблонФайла.СтатьяДДСПоступленияПоУмолчанию = Справочники.СтатьиДвиженияДенег.НайтиПоКоду(СокрЛП(БазаДБФБазаШаблонов.SDDSP));
				КонецЕсли;

				Если БазаДБФБазаШаблонов.VSNED = 1 Тогда
					ШаблонФайла.ВсегдаСоздаватьНовыйЭлементИлиДокумент = ИСТИНА;
				Иначе
					ШаблонФайла.ВсегдаСоздаватьНовыйЭлементИлиДокумент = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.IVKKTPT = 1 Тогда
					ШаблонФайла.ИспользоватьВКачествеКлючевыхТолькоПоляИзТаблицы = ИСТИНА;
				Иначе
					ШаблонФайла.ИспользоватьВКачествеКлючевыхТолькоПоляИзТаблицы = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.PVNZNSD = 1 Тогда
					ШаблонФайла.ПоискВНазначенииПлатежаНомераСчетаИДоговора = ИСТИНА;
				Иначе
					ШаблонФайла.ПоискВНазначенииПлатежаНомераСчетаИДоговора = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.SDRPOK = 1 Тогда
					ШаблонФайла.СуммироватьДанныеДокументовРасходДСПланПриВыгрузкеДляОдногоКлиентаОтОднойОрганизацииВТеченииСуток = ИСТИНА;
				Иначе
					ШаблонФайла.СуммироватьДанныеДокументовРасходДСПланПриВыгрузкеДляОдногоКлиентаОтОднойОрганизацииВТеченииСуток = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.ВставлятьМеждуТекстамиНазначенияСледующийТекст = Лев(БазаДБФБазаШаблонов.VSMTNST, БазаДБФБазаШаблонов.VSMTNSTD);

				Если БазаДБФБазаШаблонов.USPRIZA = 1 Тогда
					ШаблонФайла.УстанавливатьПризнакАвансаДокументамДенежныхСредств = ИСТИНА;
				Иначе
					ШаблонФайла.УстанавливатьПризнакАвансаДокументамДенежныхСредств = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.OTFDNP = 1 Тогда
					ШаблонФайла.ОткрыватьФормуДокументовКоторыеНеУдалосьПровести = ИСТИНА;
				Иначе
					ШаблонФайла.ОткрыватьФормуДокументовКоторыеНеУдалосьПровести = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.OTFKD = 1 Тогда
					ШаблонФайла.ОткрыватьФормуКаждогоЭлементаИлиДокумента = ИСТИНА;
				Иначе
					ШаблонФайла.ОткрыватьФормуКаждогоЭлементаИлиДокумента = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.UDFPUI = 1 Тогда
					ШаблонФайла.УдалятьФайлПослеУдачногоИмпорта = ИСТИНА;
				Иначе
					ШаблонФайла.УдалятьФайлПослеУдачногоИмпорта = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.УстанавливатьДатуДокументамПриИмпортеЕслиНеОпределена = БазаДБФБазаШаблонов.USDDPI;

				Если БазаДБФБазаШаблонов.ZAVSFIP = 1 Тогда
					ШаблонФайла.ЗагружатьВсеФайлыИзПапки = ИСТИНА;
				Иначе
					ШаблонФайла.ЗагружатьВсеФайлыИзПапки = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.VEJUIEO = 1 Тогда
					ШаблонФайла.ВестиЖурналИмпортноЭкспортныхОпераций = ИСТИНА;
				Иначе
					ШаблонФайла.ВестиЖурналИмпортноЭкспортныхОпераций = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.ISVPK = 1 Тогда
					ШаблонФайла.ИскатьВПодкаталогах = ИСТИНА;
				Иначе
					ШаблонФайла.ИскатьВПодкаталогах = ЛОЖЬ;
				КонецЕсли;

				Если БазаДБФБазаШаблонов.FAAR = 1 Тогда
					ШаблонФайла.ФайлАрхив = ИСТИНА;
				Иначе
					ШаблонФайла.ФайлАрхив = ЛОЖЬ;
				КонецЕсли;

				ШаблонФайла.ПарольАрхива = СокрЛП(БазаДБФБазаШаблонов.PAFA);
				ШаблонФайла.СообщатьОНедостаточномЗаполненииПриЭкспортеДокументовДляПОБанка = ?(БазаДБФБазаШаблонов.SONZPE = 1, ИСТИНА, ЛОЖЬ);
				ШаблонФайла.ПриЭкспортеПередЗаписьюВыводитьОкноСПеречнемВыгрузкиДляОтбора = ?(БазаДБФБазаШаблонов.PEPZVOSP = 1, ИСТИНА, ЛОЖЬ);
				ШаблонФайла.ЕслиКлиентНеНайденПриИмпортеОткрыватьПодборИзСуществующих = ?(БазаДБФБазаШаблонов.EKNNPIOP = 1, ИСТИНА, ЛОЖЬ);
				ШаблонФайла.НеВыводитьСообщениеОЗавершенииОбмена = ?(БазаДБФБазаШаблонов.NVSOOO = 1, ИСТИНА, ЛОЖЬ);
				ШаблонФайла.СуммироватьТолькоЕслиПлатежкиСОднимНомером = ?(БазаДБФБазаШаблонов.STEPSON = 1, ИСТИНА, ЛОЖЬ);
				ШаблонФайла.ПризнакДебетаОтрицательнаяСумма = ?(БазаДБФБазаШаблонов.PRDEOTSU = 1, ИСТИНА, ЛОЖЬ);
				ШаблонФайла.ИмяРегистра = СокрЛП(БазаДБФБазаШаблонов.IMAREGI);
			Исключение
				ТекстОписаниеОшибки = ОписаниеОшибки();
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Устаревший формат обмена шаблонов") + ": " + ТекстОписаниеОшибки);
			КонецПопытки;
			Попытка
				ШаблонФайла.Записать();
			Исключение
				ТекстОписаниеОшибки = ОписаниеОшибки();
				ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Произошла ошибка") + ": " + ТекстОписаниеОшибки);
			КонецПопытки;

			Если НЕ БазаДБФБазаШаблонов.Следующая() Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла; // обхода ДБФ БазаШаблонов
	КонецЕсли;

	БазаДБФБазаШаблонов.ЗакрытьФайл();
	ТекстыШаблона = Новый ЧтениеТекста(лев(АдресФайла, стрдлина(АдресФайла) - 5) + "S.TXt");
	СтрокаТекста = ТекстыШаблона.ПрочитатьСтроку();
	ВерсияКонфигурации = "" + Константы.ВерсияПрограммы.Получить();

	Если НЕ СтрокаТекста = ВерсияКонфигурации Тогда
		ОбщегоНазначения.СообщитьПользователю(ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Версия выгрузки шаблонов") + " " + СтрокаТекста + " " + ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("не совпадает с текущей") + ": " + ВерсияКонфигурации);
	КонецЕсли;

	Пока НЕ СтрокаТекста = Неопределено Цикл
		ДобавитьТекстШаблона("АдресФайла", ТекстыШаблона);
		ДобавитьТекстШаблона("ВыполнитьПрограммныйКодВНачалеЗагрузкиКаждогоПоля", ТекстыШаблона);
		ДобавитьТекстШаблона("ВыполнитьПрограммныйКодВНачалеЗагрузкиСтроки", ТекстыШаблона);
		ДобавитьТекстШаблона("ВыполнитьПрограммныйКодПередНачалом", ТекстыШаблона);
		ДобавитьТекстШаблона("ВыполнитьПрограммныйКодПослеОкончания", ТекстыШаблона);
		ДобавитьТекстШаблона("ВыполнитьПрограммныйКодПослеОкончанияЗагрузкиКаждогоПоля", ТекстыШаблона);
		ДобавитьТекстШаблона("ВыполнитьПрограммныйКодПослеОкончанияЗагрузкиСтроки", ТекстыШаблона);
		ДобавитьТекстШаблона("ДобаватьТекстВПодвалФайла", ТекстыШаблона);
		ДобавитьТекстШаблона("ДобавитьТекстВШапкуФайла", ТекстыШаблона);
		ДобавитьТекстШаблона("ИспользоватьСтрокуЗаголовок", ТекстыШаблона);
		ДобавитьТекстШаблона("Комментарий", ТекстыШаблона);
		ДобавитьТекстШаблона("СоставлятьНаименованиеГруппыРодителяИзИменПолей", ТекстыШаблона);
		ДобавитьТекстШаблона("СоставлятьНаименованиеПоВыражениюИзИменПолей", ТекстыШаблона);
		ДобавитьТекстШаблона("СоставлятьХарактеристикуПоВыражениюИзИменПолей", ТекстыШаблона);
		ДобавитьТекстШаблона("ТекстПроизвольногоЗапроса", ТекстыШаблона);
		СтрокаТекста = ТекстыШаблона.ПрочитатьСтроку();

	КонецЦикла;

	ТекстыШаблона.Закрыть();

КонецПроцедуры // ВыполнитьЗагрузкуШаблоновНаСервере(АдресФайла)

Процедура ДобавитьТекстШаблона(ИмяРеквизита, ТекстыШаблона)

	ИмяШаблона = ТекстыШаблона.ПрочитатьСтроку();
	СтрокаНачалаТекста = ТекстыШаблона.ПрочитатьСтроку();
	Если СтрокаНачалаТекста = "<BEGIN!>" Тогда
		СтрокаТекста = ТекстыШаблона.ПрочитатьСтроку();
		ТекстДляРеквизита = "";
		пока не СтрокаТекста = Неопределено
			И НЕ СтрокаТекста = "<!END>" цикл
			Если НЕ ТекстДляРеквизита = "" Тогда
				ТекстДляРеквизита = ТекстДляРеквизита + символы.пс;
			КонецЕсли;

			ТекстДляРеквизита = ТекстДляРеквизита + СтрокаТекста;
			СтрокаТекста = ТекстыШаблона.ПрочитатьСтроку();
		КонецЦикла;

		Если НЕ ТекстДляРеквизита = "" Тогда
			ЭтотШаблон = Справочники.ПодсистемаИЭШаблоны.НайтиПоНаименованию(ИмяШаблона);
			Если ЗначениеЗаполнено(ЭтотШаблон) Тогда
				ЭтотШаблонОбъект = ЭтотШаблон.ПолучитьОбъект();
				ЭтотШаблонОбъект[ИмяРеквизита] = ТекстДляРеквизита;
				ЭтотШаблонОбъект.Записать();
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьШаблоныИзФайла(Команда)

	ДиалогДляВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогФильтр = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Файл") + " (ieUNFSH0.DBf)|ieUNFSH0.DBf";
	ДиалогРасширение = "DBf";
	ДиалогДляВыбораФайла.Заголовок 		= ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выберите файл для импорта шаблонов") + ": ";
	ДиалогДляВыбораФайла.ПолноеИмяФайла 	= ПодсистемаИЭ.КонстантыОтносительныйАдресФайловПолучить() + "ieUNFSH0.DBf"; // АДРЕС
	ДиалогДляВыбораФайла.Фильтр 		= ДиалогФильтр;
	ДиалогДляВыбораФайла.Расширение 	= ДиалогРасширение;
	ДиалогДляВыбораФайла.МножественныйВыбор = ЛОЖЬ;
	ДиалогДляВыбораФайла.ПредварительныйПросмотр = ИСТИНА;
	ДиалогДляВыбораФайла.ИндексФильтра = 0;
	ДиалогДляВыбораФайла.ПроверятьСуществованиеФайла = ИСТИНА;

	Если ДиалогДляВыбораФайла.Выбрать() Тогда
		АдресФайла = ДиалогДляВыбораФайла.ПолноеИмяФайла;
		ВыполнитьЗагрузкуШаблоновНаСервере(АдресФайла);
	КонецЕсли; // когда файл АдресФайла выбран

	ОбновитьПовторноИспользуемыеЗначения();
	ОбновитьИнтерфейс();

КонецПроцедуры

&НаКлиенте
Процедура ПослеИзображенияОкнаФормы() // Когда окно уже нарисовано пользователю

	ЭтаФорма.Элементы.ФормаЗакрыть.Видимость = НЕ ЭтаФорма.Окно = Неопределено;

КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 1);

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбщийМодульКлиент.СобытиеФормы(ЭтаФорма, 0);
	ПодключитьОбработчикОжидания("ПослеИзображенияОкнаФормы", 0.3, ИСТИНА);

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)          // ПРИ СОЗДАНИИ НА СЕРВЕРЕ

	Отказ = ОбщийМодульСервисСервер.ПроверитьОтказДоступа("002700", ЭтаФорма, Отказ, );

	Если НЕ Отказ Тогда
		Если ОбщийМодульПовтор.ПолучитьЗначениеНастройкиИлиКонстанты("ИспользоватьСобственныйПереводЭлементовИнтерфейса") Тогда
			ОбщийМодульСервер.ПеревестиРеквизитыФормы(ЭтаФорма);
		КонецЕсли;

	Если Параметры.ИспользоватьОтбор = "Э" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьТолькоДляИмпорта");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.Использование = ИСТИНА;
		ЭлементОтбора.ПравоеЗначение = Параметры.ИспользоватьТолькоДляИмпорта;
	ИначеЕсли Параметры.ИспользоватьОтбор = "И" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИспользоватьТолькоДляЭкспорта");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
		ЭлементОтбора.Использование = ИСТИНА;
		ЭлементОтбора.ПравоеЗначение = Параметры.ИспользоватьТолькоДляЭкспорта;
	КонецЕсли;

	Если Параметры.ИспользоватьОтборПоВиду = "С" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляСпискаЭлементовСправочникаИлиДокументов);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	ИначеЕсли Параметры.ИспользоватьОтборПоВиду = "К" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляКарточкиСправочникаИлиШапкиДокумента);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	ИначеЕсли Параметры.ИспользоватьОтборПоВиду = "Б" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляОбменаСБанком);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	ИначеЕсли Параметры.ИспользоватьОтборПоВиду = "З" Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ВидШаблона");
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = ИСТИНА;
		ВидыШаблона = Новый СписокЗначений;
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ДляТаблицыТовары);
		ВидыШаблона.Добавить(Перечисления.ПодсистемаИЭИмпортЭкспортФайловВидыШаблонов.ЛюбойВариант);
		ЭлементОтбора.ПравоеЗначение = ВидыШаблона;
	КонецЕсли;
			  КонецЕсли;

	ОбщийМодульСервисСервер.ОбработатьНовуюФорму(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы) Экспорт // Для реакции на события для запрограммированных элементов
	ОбщийМодульКлиент.РеакцияНаПрочиеСобытияФормы(КомандаСобытияФормы, ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьШаблоныВФайл(Команда)

	ДиалогДляВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогФильтр   = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Файл") + " (ieUNFSH0.DBf)|ieUNFSH0.DBf";
	ДиалогРасширение = "DBf";
	ДиалогДляВыбораФайла.Заголовок = ОбщийМодульПовтор.ПолучитьТекстНаЯзыке("Выберите файл для экспорта шаблонов") + ": ";
	ДиалогДляВыбораФайла.ПолноеИмяФайла 	= "ieUNFSH0.DBf";
	ДиалогДляВыбораФайла.Фильтр 			= ДиалогФильтр;
	ДиалогДляВыбораФайла.Расширение 		= ДиалогРасширение;
	ДиалогДляВыбораФайла.МножественныйВыбор 		= ЛОЖЬ;
	ДиалогДляВыбораФайла.ПредварительныйПросмотр 	= ИСТИНА;
	ДиалогДляВыбораФайла.ИндексФильтра 	= 0;
	ДиалогДляВыбораФайла.ПроверятьСуществованиеФайла = ЛОЖЬ;

	Если ДиалогДляВыбораФайла.Выбрать() Тогда
		АдресФайла = ДиалогДляВыбораФайла.ПолноеИмяФайла;
		ПодсистемаИЭ.ВыполнитьВыгрузкуШаблоновНаСервере(АдресФайла);
	КонецЕсли; // когда файл АдресФайла выбран

КонецПроцедуры
