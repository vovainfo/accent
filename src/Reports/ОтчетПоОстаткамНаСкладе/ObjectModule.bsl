
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

//@skip-check module-region-empty
#Область ОписаниеПеременных
#КонецОбласти

//@skip-check module-region-empty
#Область ПрограммныйИнтерфейс
#КонецОбласти

#Область ОбработчикиСобытий
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	НастройкиОтчета = КомпоновщикНастроек.ПолучитьНастройки();	
	ПараметрСклад = НастройкиОтчета.ПараметрыДанных.Элементы.Найти("Склад").Значение;
	ПараметрПериодФилиал = НастройкиОтчета.ПараметрыДанных.Элементы.Найти("ПериодФилиал").Значение;
	//@skip-check bsl-legacy-check-string-literal
	ТаймШифтСек = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрСклад, "ВременноеСмещение") * 3600;
	
	
	Параметр = КомпоновщикНастроек.Настройки.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ПериодСервера"));
	Параметр.Значение = Новый СтандартнаяДатаНачала(ПараметрПериодФилиал.Дата - ТаймШифтСек);
	Параметр.Использование = Истина;	
КонецПроцедуры
#КонецОбласти

//@skip-check module-region-empty
#Область СлужебныйПрограммныйИнтерфейс
#КонецОбласти

//@skip-check module-region-empty
#Область СлужебныеПроцедурыИФункции
#КонецОбласти

//@skip-check module-region-empty
#Область Инициализация
#КонецОбласти

#КонецЕсли
