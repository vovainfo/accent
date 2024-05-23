#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

//@skip-check module-region-empty
#Область ПрограммныйИнтерфейс
#КонецОбласти

#Область ОбработчикиСобытий
Процедура ОбработкаЗаполнения(ДанныеЗаполнения,СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.РеализацияТоваровУслуг") Тогда
		СтандартнаяОбработка = Ложь;
		Основание = ДанныеЗаполнения;
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	РеализацияТоваровУслуг.Дата,
			|	РеализацияТоваровУслуг.Склад,
			|	РеализацияТоваровУслуг.Контрагент,
			|	РеализацияТоваровУслуг.СмещениеВремениСклада
			|ИЗ
			|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
			|ГДЕ
			|	РеализацияТоваровУслуг.Ссылка = &Ссылка
			|	И РеализацияТоваровУслуг.Проведен
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	РеализацияТоваровУслугСписокНоменклатуры.Номенклатура,
			|	РеализацияТоваровУслугСписокНоменклатуры.Количество,
			|	РеализацияТоваровУслугСписокНоменклатуры.Цена,
			|	РеализацияТоваровУслугСписокНоменклатуры.Сумма
			|ИЗ
			|	Документ.РеализацияТоваровУслуг.СписокНоменклатуры КАК РеализацияТоваровУслугСписокНоменклатуры
			|ГДЕ
			|	РеализацияТоваровУслугСписокНоменклатуры.Ссылка = &Ссылка
			|	И РеализацияТоваровУслугСписокНоменклатуры.Номенклатура.ВидНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ВидыНоменклатуры.Услуга)";
		Запрос.Параметры.Вставить("Ссылка", ДанныеЗаполнения);
		
		РезультатПакет = Запрос.ВыполнитьПакет();
		
		ВыборкаШапка = РезультатПакет[0].Выбрать();
		ВыборкаНоменклатура = РезультатПакет[1].Выбрать();
		
		Если ВыборкаШапка.Следующий() Тогда
			Если ВыборкаНоменклатура.Количество() = 0 Тогда
				ВызватьИсключение НСтр("ru = 'В документе-основании отсутствуют услуги'");
			КонецЕсли;
			ЗаполнитьЗначенияСвойств(ЭтотОбъект, ВыборкаШапка, "Дата, Склад, Контрагент, СмещениеВремениСклада");				
		Иначе
			ВызватьИсключение НСтр("ru = 'Отсутствует проведённый документ-основание'");
		КонецЕсли;
		
		Пока ВыборкаНоменклатура.Следующий() Цикл
			НоваяСтрока = СписокНоменклатуры.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, ВыборкаНоменклатура);			
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура ПриУстановкеНовогоНомера(СтандартнаяОбработка, Префикс)
	Префикс = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Склад, "Префикс");
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	СуммаПоДокументу = СписокНоменклатуры.Итог("Сумма");
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	// пока некуда проводить;
КонецПроцедуры

#КонецОбласти

//@skip-check module-region-empty
#Область СлужебныйПрограммныйИнтерфейс
#КонецОбласти

//@skip-check module-region-empty
#Область СлужебныеПроцедурыИФункции
#КонецОбласти
#КонецЕсли