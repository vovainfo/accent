#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

//@skip-check module-region-empty
#Область ПрограммныйИнтерфейс
#КонецОбласти

#Область ОбработчикиСобытий
Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
    СтандартнаяОбработка = Ложь;
    Поля.Добавить("Номер");
    Поля.Добавить("Дата");
    Поля.Добавить("СмещениеВремениСклада");
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
    СтандартнаяОбработка = Ложь;
    Представление = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Акт выполненных работ %1 от %2'"), 
    																		Данные.Номер, Данные.Дата+Данные.СмещениеВремениСклада);
КонецПроцедуры
#КонецОбласти

//@skip-check module-region-empty
#Область СлужебныйПрограммныйИнтерфейс
#КонецОбласти

//@skip-check module-region-empty
#Область СлужебныеПроцедурыИФункции
#КонецОбласти
#КонецЕсли


