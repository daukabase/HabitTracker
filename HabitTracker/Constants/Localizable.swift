// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Account {
    internal enum Detail {
      /// Номер счёта: 
      internal static let accountNumber = L10n.tr("Localizable", "Account.Detail.accountNumber")
      /// Остаток на счёте:
      internal static let balance = L10n.tr("Localizable", "Account.Detail.balance")
      /// Банк: 
      internal static let bank = L10n.tr("Localizable", "Account.Detail.bank")
      /// БИК Банка: 
      internal static let bankBik = L10n.tr("Localizable", "Account.Detail.bankBik")
      /// БИН Банка: 
      internal static let bankBin = L10n.tr("Localizable", "Account.Detail.bankBin")
      /// Счёт корреспондента: 
      internal static let correspondentAccount = L10n.tr("Localizable", "Account.Detail.correspondentAccount")
      /// Банк-корреспондента: 
      internal static let correspondentBank = L10n.tr("Localizable", "Account.Detail.correspondentBank")
      /// БИК корреспондента: 
      internal static let correspondentBik = L10n.tr("Localizable", "Account.Detail.correspondentBik")
      /// ИИН корреспондента: 
      internal static let correspondentInn = L10n.tr("Localizable", "Account.Detail.correspondentInn")
      /// SWIFT код корреспондента: 
      internal static let correspondentSwift = L10n.tr("Localizable", "Account.Detail.correspondentSwift")
      /// Валюта: 
      internal static let currency = L10n.tr("Localizable", "Account.Detail.currency")
      /// БИН/ИИН: 
      internal static let iinBin = L10n.tr("Localizable", "Account.Detail.iin/bin")
      internal enum Language {
        /// Анг
        internal static let eng = L10n.tr("Localizable", "Account.Detail.Language.eng")
        /// Каз
        internal static let kaz = L10n.tr("Localizable", "Account.Detail.Language.kaz")
        /// Рус
        internal static let rus = L10n.tr("Localizable", "Account.Detail.Language.rus")
      }
    }
    internal enum Share {
      /// Направляю вам реквизиты счета нашей компании
      internal static let header = L10n.tr("Localizable", "Account.Share.Header")
    }
  }

  internal enum AccountType {
    /// Расчетный счет
    internal static let account = L10n.tr("Localizable", "AccountType.account")
    /// Cчет арестован
    internal static let arrested = L10n.tr("Localizable", "AccountType.arrested")
    /// Карточный счет
    internal static let card = L10n.tr("Localizable", "AccountType.card")
    /// Депозитный счет
    internal static let deposite = L10n.tr("Localizable", "AccountType.deposite")
  }

  internal enum Common {
    /// Применить
    internal static let apply = L10n.tr("Localizable", "Common.Apply")
    /// Версия приложения
    internal static let appVersion = L10n.tr("Localizable", "Common.AppVersion")
    /// Банкоматы
    internal static let atm = L10n.tr("Localizable", "Common.ATM")
    /// Отделения
    internal static let branches = L10n.tr("Localizable", "Common.Branches")
    /// Позвонить
    internal static let call = L10n.tr("Localizable", "Common.Call")
    /// Отмена
    internal static let cancel = L10n.tr("Localizable", "Common.cancel")
    /// Очистить
    internal static let clear = L10n.tr("Localizable", "Common.clear")
    /// Закрыть
    internal static let close = L10n.tr("Localizable", "Common.close")
    /// Контакты
    internal static let contacts = L10n.tr("Localizable", "Common.Contacts")
    /// Готово
    internal static let done = L10n.tr("Localizable", "Common.done")
    /// Отправить квитанцию
    internal static let download = L10n.tr("Localizable", "Common.download")
    /// Список пуст
    internal static let emptyList = L10n.tr("Localizable", "Common.emptyList")
    /// Написать
    internal static let feedback = L10n.tr("Localizable", "Common.Feedback")
    /// Фильтры
    internal static let filters = L10n.tr("Localizable", "Common.Filters")
    /// Вход
    internal static let login = L10n.tr("Localizable", "Common.Login")
    /// Выход
    internal static let logout = L10n.tr("Localizable", "Common.logout")
    /// Новости
    internal static let news = L10n.tr("Localizable", "Common.News")
    /// Далее
    internal static let next = L10n.tr("Localizable", "Common.Next")
    /// Ок
    internal static let ok = L10n.tr("Localizable", "Common.ok")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "Common.Password")
    /// Курс валют
    internal static let rate = L10n.tr("Localizable", "Common.Rate")
    /// Регистрация
    internal static let registration = L10n.tr("Localizable", "Common.Registration")
    /// Сервис
    internal static let service = L10n.tr("Localizable", "Common.Service")
    /// Настройки
    internal static let settings = L10n.tr("Localizable", "Common.Settings")
    /// Номер телефона
    internal static let username = L10n.tr("Localizable", "Common.Username")
    /// Выйти
    internal static let yes = L10n.tr("Localizable", "Common.yes")
    internal enum Action {
      /// Отмена
      internal static let cancel = L10n.tr("Localizable", "Common.Action.cancel")
      /// Выбрать
      internal static let choose = L10n.tr("Localizable", "Common.Action.choose")
      /// Изменить
      internal static let edit = L10n.tr("Localizable", "Common.Action.edit")
      /// Далее
      internal static let next = L10n.tr("Localizable", "Common.Action.next")
    }
    internal enum Button {
      /// Обновить
      internal static let refresh = L10n.tr("Localizable", "Common.Button.refresh")
    }
    internal enum Error {
      internal enum Network {
        /// Не удалось обработать запрос. Проверьте наличие сети интернет и попробуйте снова, если ошибка повторится, обратитесь в службу поддержки.
        internal static let message = L10n.tr("Localizable", "Common.Error.Network.message")
        internal enum NoInternet {
          /// Интернет недоступен
          internal static let message = L10n.tr("Localizable", "Common.Error.Network.noInternet.message")
        }
      }
      internal enum Serialization {
        /// Ошибка сериализации. Не удалось получить список, попробуйте обновить позднее.
        internal static let message = L10n.tr("Localizable", "Common.Error.Serialization.message")
      }
    }
    internal enum Placeholder {
      /// Код активации
      internal static let activationcode = L10n.tr("Localizable", "Common.Placeholder.activationcode")
      /// Компания (AB123456)
      internal static let company = L10n.tr("Localizable", "Common.Placeholder.company")
      /// Электронная почта
      internal static let email = L10n.tr("Localizable", "Common.Placeholder.email")
      /// ИИН
      internal static let iin = L10n.tr("Localizable", "Common.Placeholder.iin")
      /// Пароль
      internal static let password = L10n.tr("Localizable", "Common.Placeholder.password")
      /// Мобильный номер
      internal static let phone = L10n.tr("Localizable", "Common.Placeholder.phone")
      /// Сохранить
      internal static let save = L10n.tr("Localizable", "Common.Placeholder.save")
      /// Пользователь
      internal static let username = L10n.tr("Localizable", "Common.Placeholder.username")
    }
    internal enum Search {
      /// Поиск по сумме
      internal static let title = L10n.tr("Localizable", "Common.Search.title")
    }
    internal enum Logout {
      /// Вы точно хотите выйти?
      internal static let title = L10n.tr("Localizable", "Common.logout.title")
    }
  }

  internal enum Contractors {
    internal enum Accounts {
      /// Счета
      internal static let accounts = L10n.tr("Localizable", "Contractors.Accounts.accounts")
      /// Добавить новый счёт
      internal static let addAccount = L10n.tr("Localizable", "Contractors.Accounts.addAccount")
      /// Страна
      internal static let country = L10n.tr("Localizable", "Contractors.Accounts.country")
      /// Удалить
      internal static let delete = L10n.tr("Localizable", "Contractors.Accounts.delete")
      /// Редактировать
      internal static let edit = L10n.tr("Localizable", "Contractors.Accounts.edit")
      internal enum Add {
        /// Счет уже существует, необходимо добавить реквизиты в режиме редактирования.
        internal static let accountExist = L10n.tr("Localizable", "Contractors.Accounts.Add.accountExist")
        /// Длина счета должна быть 20 символов
        internal static let accountLength = L10n.tr("Localizable", "Contractors.Accounts.Add.accountLength")
        /// Наименование банка
        internal static let bankName = L10n.tr("Localizable", "Contractors.Accounts.Add.bankName")
        /// БИК банка
        internal static let bic = L10n.tr("Localizable", "Contractors.Accounts.Add.bic")
        /// Корректный номер счета
        internal static let correctNumber = L10n.tr("Localizable", "Contractors.Accounts.Add.correctNumber")
        /// Валюта
        internal static let currency = L10n.tr("Localizable", "Contractors.Accounts.Add.currency")
        /// Редактирование счета
        internal static let editAccount = L10n.tr("Localizable", "Contractors.Accounts.Add.editAccount")
        /// Номер счета
        internal static let enterAccount = L10n.tr("Localizable", "Contractors.Accounts.Add.enterAccount")
        /// Некорректный номер счета
        internal static let incorrectNumber = L10n.tr("Localizable", "Contractors.Accounts.Add.incorrectNumber")
        /// Новый счет
        internal static let newAccount = L10n.tr("Localizable", "Contractors.Accounts.Add.newAccount")
      }
    }
    internal enum Add {
      /// Редактировать
      internal static let editContractor = L10n.tr("Localizable", "Contractors.Add.editContractor")
      /// Введите БИН/ИИН
      internal static let enterBin = L10n.tr("Localizable", "Contractors.Add.enterBin")
      /// Код получателя (КБе)
      internal static let enterKbe = L10n.tr("Localizable", "Contractors.Add.enterKbe")
      /// Название
      internal static let enterName = L10n.tr("Localizable", "Contractors.Add.enterName")
      /// Контрагент уже существует
      internal static let existContractor = L10n.tr("Localizable", "Contractors.Add.existContractor")
      /// Некоректный БИН/ИИН
      internal static let incorrectBin = L10n.tr("Localizable", "Contractors.Add.incorrectBin")
      /// Некорректный КБе
      internal static let inCorrectKbe = L10n.tr("Localizable", "Contractors.Add.inCorrectKbe")
      /// Новый контрагент
      internal static let newContractor = L10n.tr("Localizable", "Contractors.Add.newContractor")
      /// Сохранить и добавить счет
      internal static let saveAndAdd = L10n.tr("Localizable", "Contractors.Add.saveAndAdd")
    }
    internal enum List {
      /// Добавить нового контрагента
      internal static let addContractor = L10n.tr("Localizable", "Contractors.List.addContractor")
      /// Добавьте контрагентов, чтобы сэкономить время на заполнении реквизитов
      internal static let emptyDescription = L10n.tr("Localizable", "Contractors.List.emptyDescription")
      /// Контрагентов нет
      internal static let emptyTitle = L10n.tr("Localizable", "Contractors.List.emptyTitle")
      /// Контрагенты
      internal static let title = L10n.tr("Localizable", "Contractors.List.title")
    }
    internal enum Requisities {
      /// Наименование Банка
      internal static let bankName = L10n.tr("Localizable", "Contractors.Requisities.bankName")
      /// БИН/ИИН клиента
      internal static let bin = L10n.tr("Localizable", "Contractors.Requisities.bin")
      /// Валюта
      internal static let currency = L10n.tr("Localizable", "Contractors.Requisities.currency")
      /// КБе
      internal static let kbe = L10n.tr("Localizable", "Contractors.Requisities.kbe")
      /// Наименование клиента
      internal static let name = L10n.tr("Localizable", "Contractors.Requisities.name")
      /// Номер счета
      internal static let number = L10n.tr("Localizable", "Contractors.Requisities.number")
      /// Заплатить
      internal static let payment = L10n.tr("Localizable", "Contractors.Requisities.payment")
      /// Реквизиты счета
      internal static let requisities = L10n.tr("Localizable", "Contractors.Requisities.requisities")
      /// Реквизиты счета
      internal static let title = L10n.tr("Localizable", "Contractors.Requisities.title")
    }
  }

  internal enum CreatePinCode {
    internal enum Pin {
      /// Введите старый PIN-код
      internal static let oldPinText = L10n.tr("Localizable", "CreatePinCode.Pin.oldPinText")
      /// Придумайте PIN-код
      internal static let text = L10n.tr("Localizable", "CreatePinCode.Pin.text")
    }
  }

  internal enum CurrencyPayments {
    /// Валютный платеж
    internal static let title = L10n.tr("Localizable", "CurrencyPayments.title")
    internal enum Account {
      internal enum Signature {
        /// Подпись
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.Account.signature.placeholder")
      }
    }
    internal enum Actions {
      /// Сохранить
      internal static let save = L10n.tr("Localizable", "CurrencyPayments.Actions.save")
      /// Подписать и отправить
      internal static let sign = L10n.tr("Localizable", "CurrencyPayments.Actions.sign")
    }
    internal enum Amount {
      /// Сумма платежа
      internal static let title = L10n.tr("Localizable", "CurrencyPayments.Amount.title")
    }
    internal enum Autocomplete {
      /// СПИСОК
      internal static let list = L10n.tr("Localizable", "CurrencyPayments.Autocomplete.List")
      /// ЧАСТЫЕ
      internal static let often = L10n.tr("Localizable", "CurrencyPayments.Autocomplete.Often")
    }
    internal enum Done {
      /// Вернуться в платежи
      internal static let backPayments = L10n.tr("Localizable", "CurrencyPayments.Done.backPayments")
      /// Новый\nплатеж
      internal static let newPayment = L10n.tr("Localizable", "CurrencyPayments.Done.newPayment")
      internal enum Save {
        /// Для принятия платежа в обработку необходимо подписать платеж
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.Done.Save.description")
        /// Платеж №%@ сохранен на подпись
        internal static func message(_ p1: String) -> String {
          return L10n.tr("Localizable", "CurrencyPayments.Done.Save.message", p1)
        }
      }
      internal enum Sign {
        /// В среднем платеж обрабатывается около 1-ого часа
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.Done.Sign.description")
        /// Платеж №%@ принят в обработку
        internal static func message(_ p1: String) -> String {
          return L10n.tr("Localizable", "CurrencyPayments.Done.Sign.message", p1)
        }
      }
    }
    internal enum InputProperty {
      internal enum AccountBeneficiar {
        /// Счёт № / IBAN
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.accountBeneficiar.placeholder")
      }
      internal enum AccountComission {
        /// Счёт списания комиссии
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.accountComission.placeholder")
      }
      internal enum AccountWriteOff {
        /// Счёт списания
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.accountWriteOff.placeholder")
      }
      internal enum Address {
        /// Например: Almaty, Nazarbayev st. 226
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.address.description")
        /// Адрес
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.address.placeholder")
      }
      internal enum Amount {
        /// Сумма перевода (32A)
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.amount.placeholder")
      }
      internal enum BeneficiarInfo {
        /// Заполнять при необходимости
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.beneficiarInfo.description")
        /// Информация получателю
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.beneficiarInfo.placeholder")
      }
      internal enum BeneficiarName {
        /// Например: LLP GOLDEN EAGLE
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.beneficiarName.description")
        /// Наименование получателя
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.beneficiarName.placeholder")
      }
      internal enum CodeBank {
        /// Например: ALFA
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.codeBank.description")
        /// Код банка (БИК) / SWIFT
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.codeBank.placeholder")
      }
      internal enum Contract {
        /// Контракт
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.contract.placeholder")
      }
      internal enum Country {
        /// Например: KAZAKHSTAN
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.country.description")
        /// Страна
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.country.placeholder")
      }
      internal enum DetailContract {
        /// Например: VO, № контракта, УНК
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.detailContract.description")
        /// Детали контракта
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.detailContract.placeholder")
      }
      internal enum Inn {
        /// ИНН
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.inn.placeholder")
      }
      internal enum Kbe {
        /// КБе
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.kbe.placeholder")
      }
      internal enum Kpp {
        /// КПП
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.kpp.placeholder")
      }
      internal enum NameBank {
        /// Наименование банка
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.nameBank.placeholder")
      }
      internal enum PaymentPurpose {
        /// Например: Для предоставления услуг
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.paymentPurpose.description")
        /// Дополнительная информация
        internal static let info = L10n.tr("Localizable", "CurrencyPayments.InputProperty.paymentPurpose.info")
        /// Назначение платежа
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.paymentPurpose.placeholder")
      }
      internal enum PaymentPurposeCode {
        /// Например: 711 или 221
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.paymentPurposeCode.description")
        /// Код назначения платежа
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.paymentPurposeCode.placeholder")
      }
      internal enum Signature {
        /// Подпись
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.signature.placeholder")
      }
      internal enum ValutationDate {
        /// Дата валютирования
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.valutationDate.placeholder")
      }
      internal enum VoCode {
        /// Например: 12050 или 22100
        internal static let description = L10n.tr("Localizable", "CurrencyPayments.InputProperty.voCode.description")
        /// Код VO
        internal static let placeholder = L10n.tr("Localizable", "CurrencyPayments.InputProperty.voCode.placeholder")
      }
    }
    internal enum Section {
      /// Банк-получателя
      internal static let bankBeneficiar = L10n.tr("Localizable", "CurrencyPayments.Section.bankBeneficiar")
      /// Получатель
      internal static let beneficiar = L10n.tr("Localizable", "CurrencyPayments.Section.beneficiar")
      /// Детали платежа
      internal static let details = L10n.tr("Localizable", "CurrencyPayments.Section.details")
    }
    internal enum Validator {
      /// По международному формату Swift на поля %@ должны в сумме содержать не более %@ символов.
      internal static func text(_ p1: String, _ p2: String) -> String {
        return L10n.tr("Localizable", "CurrencyPayments.Validator.text", p1, p2)
      }
    }
  }

  internal enum Dashboard {
    /// Последние платежи
    internal static let transactionheader = L10n.tr("Localizable", "Dashboard.Transactionheader")
    internal enum Search {
      /// Поиск по сумме платежа
      internal static let placeholder = L10n.tr("Localizable", "Dashboard.Search.Placeholder")
    }
  }

  internal enum EmployeeDoneList {
    internal enum Main {
      /// Количество сотрудников:
      internal static let sectionTitle = L10n.tr("Localizable", "EmployeeDoneList.Main.SectionTitle")
      /// Список на оплату
      internal static let title = L10n.tr("Localizable", "EmployeeDoneList.Main.Title")
    }
  }

  internal enum EmployeeList {
    /// Справочник
    internal static let title = L10n.tr("Localizable", "EmployeeList.Title")
    internal enum Error {
      /// Укажите период
      internal static let period = L10n.tr("Localizable", "EmployeeList.Error.period")
      /// Укажите сумму
      internal static let sum = L10n.tr("Localizable", "EmployeeList.Error.sum")
      /// Укажите сумму и период
      internal static let sumAndPeriod = L10n.tr("Localizable", "EmployeeList.Error.sumAndPeriod")
    }
    internal enum Main {
      /// Добавлено
      internal static let added = L10n.tr("Localizable", "EmployeeList.Main.Added")
      /// Добавить нового сотрудника
      internal static let addNewEmployee = L10n.tr("Localizable", "EmployeeList.Main.AddNewEmployee")
      /// Реестр пуст
      internal static let empty = L10n.tr("Localizable", "EmployeeList.Main.Empty")
      /// Список пустой
      internal static let emptyList = L10n.tr("Localizable", "EmployeeList.Main.EmptyList")
      /// Сотрудники
      internal static let searchSection = L10n.tr("Localizable", "EmployeeList.Main.SearchSection")
      /// Поиск по ФИО
      internal static let searchTextField = L10n.tr("Localizable", "EmployeeList.Main.SearchTextField")
    }
  }

  internal enum Error {
    internal enum Authorization {
      /// Проверьте введенные данные и попробуйте снова\nЕсли ошибка повторится, обратитесь в службу поддержки
      internal static let message = L10n.tr("Localizable", "Error.Authorization.message")
      /// Ошибка Авторизации
      internal static let title = L10n.tr("Localizable", "Error.Authorization.title")
    }
    internal enum Invalid {
      /// Неверно введен "Код"\nПопробуйте снова
      internal static let code = L10n.tr("Localizable", "Error.Invalid.Code")
      /// Неверно введено "Компания"\nПопробуйте снова
      internal static let company = L10n.tr("Localizable", "Error.Invalid.Company")
      /// Неверно введено "Пароль"\nПопробуйте снова
      internal static let password = L10n.tr("Localizable", "Error.Invalid.Password")
      /// Неверно введен "Номер телефона"\nПопробуйте снова
      internal static let phone = L10n.tr("Localizable", "Error.Invalid.Phone")
      /// Неверно введено "Номер телефона"\nПопробуйте снова
      internal static let username = L10n.tr("Localizable", "Error.Invalid.Username")
    }
    internal enum Required {
      /// Поле "Код активации" обязательно к заполнению
      internal static let code = L10n.tr("Localizable", "Error.Required.Code")
      /// Поле "Компания" обязательно к заполнению
      internal static let company = L10n.tr("Localizable", "Error.Required.Company")
      /// Поле "Пароль" обязательно к заполнению
      internal static let password = L10n.tr("Localizable", "Error.Required.Password")
      /// Поле "Номер телефона" обязательно к заполнению
      internal static let phone = L10n.tr("Localizable", "Error.Required.Phone")
      /// Поле "Номер телефона" обязательно к заполнению
      internal static let username = L10n.tr("Localizable", "Error.Required.Username")
    }
  }

  internal enum Exchange {
    /// Покупка
    internal static let buy = L10n.tr("Localizable", "Exchange.Buy")
    /// Валюта
    internal static let currency = L10n.tr("Localizable", "Exchange.Currency")
    /// Валютная пара
    internal static let currencyPair = L10n.tr("Localizable", "Exchange.CurrencyPair")
    /// Курс
    internal static let rate = L10n.tr("Localizable", "Exchange.Rate")
    /// Продажа
    internal static let sale = L10n.tr("Localizable", "Exchange.Sale")
    /// Курсы валют
    internal static let title = L10n.tr("Localizable", "Exchange.Title")
    /// Курс валют на сегодня
    internal static let today = L10n.tr("Localizable", "Exchange.Today")
    /// Курс валют на завтра
    internal static let tomorrow = L10n.tr("Localizable", "Exchange.Tomorrow")
    internal enum Bank {
      /// Альфа-Банк
      internal static let alfa = L10n.tr("Localizable", "Exchange.Bank.Alfa")
      /// НБ РК
      internal static let nbrk = L10n.tr("Localizable", "Exchange.Bank.NBRK")
      /// Сегодня
      internal static let today = L10n.tr("Localizable", "Exchange.Bank.Today")
      /// Завтра
      internal static let tomorrow = L10n.tr("Localizable", "Exchange.Bank.Tomorrow")
      /// Номинал
      internal static let value = L10n.tr("Localizable", "Exchange.Bank.Value")
    }
    internal enum Section {
      /// Национальный Банк на
      internal static let nbrk = L10n.tr("Localizable", "Exchange.Section.NBRK")
      /// День в день
      internal static let today = L10n.tr("Localizable", "Exchange.Section.Today")
      /// Будущая дата валютирования
      internal static let tomorrow = L10n.tr("Localizable", "Exchange.Section.Tomorrow")
    }
  }

  internal enum ExchangeSetting {
    /// Настройки
    internal static let title = L10n.tr("Localizable", "ExchangeSetting.Title")
  }

  internal enum Filter {
    internal enum OperationType {
      /// Все
      internal static let all = L10n.tr("Localizable", "Filter.OperationType.all")
      /// Приход
      internal static let income = L10n.tr("Localizable", "Filter.OperationType.income")
      /// Расход
      internal static let outcome = L10n.tr("Localizable", "Filter.OperationType.outcome")
    }
    internal enum Period {
      /// Задать период
      internal static let custom = L10n.tr("Localizable", "Filter.Period.custom")
      /// 7 дней
      internal static let month = L10n.tr("Localizable", "Filter.Period.month")
      /// Текущий месяц
      internal static let threeMonths = L10n.tr("Localizable", "Filter.Period.threeMonths")
      /// Сегодня
      internal static let week = L10n.tr("Localizable", "Filter.Period.week")
    }
    internal enum Section {
      /// Период
      internal static let period = L10n.tr("Localizable", "Filter.Section.period")
      /// Сумма
      internal static let sum = L10n.tr("Localizable", "Filter.Section.sum")
      /// Тип операций
      internal static let type = L10n.tr("Localizable", "Filter.Section.type")
    }
    internal enum Title {
      /// Фильтр
      internal static let main = L10n.tr("Localizable", "Filter.Title.main")
    }
  }

  internal enum Information {
    internal enum CallCenter {
      /// 8-8000-8000-75
      internal static let mobile = L10n.tr("Localizable", "Information.CallCenter.mobile")
      /// 2510 (для мобильных)
      internal static let phone = L10n.tr("Localizable", "Information.CallCenter.phone")
      /// +7 (727) 244 75 75
      internal static let work = L10n.tr("Localizable", "Information.CallCenter.work")
    }
  }

  internal enum LockScreen {
    /// Введите Pin Код
    internal static let title = L10n.tr("Localizable", "LockScreen.Title")
    internal enum Exit {
      /// Выход
      internal static let title = L10n.tr("Localizable", "LockScreen.exit.title")
    }
  }

  internal enum More {
    /// Сервисы
    internal static let services = L10n.tr("Localizable", "More.Services")
    /// Техническая поддержка
    internal static let techSupport = L10n.tr("Localizable", "More.TechSupport")
    internal enum Contacts {
      /// Call center
      internal static let callCenter = L10n.tr("Localizable", "More.Contacts.CallCenter")
      /// Для международных
      internal static let international = L10n.tr("Localizable", "More.Contacts.International")
      /// Для связи с банком Вы можете позвонить по следующим номерам
      internal static let message = L10n.tr("Localizable", "More.Contacts.Message")
      /// С мобильного
      internal static let mobile = L10n.tr("Localizable", "More.Contacts.Mobile")
      /// Контакты
      internal static let title = L10n.tr("Localizable", "More.Contacts.Title")
    }
  }

  internal enum MyTemplatesCollection {
    /// Все
    internal static let all = L10n.tr("Localizable", "MyTemplatesCollection.all")
    /// Мои шаблоны
    internal static let myTemplates = L10n.tr("Localizable", "MyTemplatesCollection.myTemplates")
    /// Шаблоны
    internal static let templates = L10n.tr("Localizable", "MyTemplatesCollection.templates")
  }

  internal enum NewPayments {
    internal enum Search {
      /// Ничего не найдено
      internal static let empty = L10n.tr("Localizable", "NewPayments.Search.empty")
      /// Поиск
      internal static let searchTitle = L10n.tr("Localizable", "NewPayments.Search.searchTitle")
    }
  }

  internal enum News {
    /// Новости
    internal static let navigation = L10n.tr("Localizable", "News.navigation")
    /// Новости
    internal static let tabbar = L10n.tr("Localizable", "News.tabbar")
    internal enum Error {
      internal enum Content {
        /// Новостей нет, но вы держитесь
        internal static let message = L10n.tr("Localizable", "News.Error.Content.message")
        /// Новости нет
        internal static let title = L10n.tr("Localizable", "News.Error.Content.title")
      }
      internal enum Network {
        /// Не удалось загрузить. Проверьте наличие сети интернет и попробуйте снова, если ошибка повторится, обратитесь в службу поддержки.
        internal static let message = L10n.tr("Localizable", "News.Error.Network.message")
        /// Ошибка загрузки
        internal static let title = L10n.tr("Localizable", "News.Error.Network.title")
      }
    }
  }

  internal enum Password {
    internal enum Entry {
      /// Восстановление пароля
      internal static let forgotNavTitle = L10n.tr("Localizable", "Password.Entry.forgotNavTitle")
      /// Забыли пароль?
      internal static let forgotPasswordTitle = L10n.tr("Localizable", "Password.Entry.forgotPasswordTitle")
      /// Введите пароль
      internal static let passwordPlaceholder = L10n.tr("Localizable", "Password.Entry.passwordPlaceholder")
    }
    internal enum Network {
      /// Проверьте наличие сети интернет и попробуйте снова, если ошибка повторится, обратитесь в службу поддержки.
      internal static let errorMessage = L10n.tr("Localizable", "Password.Network.errorMessage")
      /// Ошибка сериализации
      internal static let serializationError = L10n.tr("Localizable", "Password.Network.serializationError")
      /// Неверный номер телефона или пароль
      internal static let wrongNumberOrPassword = L10n.tr("Localizable", "Password.Network.wrongNumberOrPassword")
    }
  }

  internal enum Payment {
    internal enum Destination {
      /// Платежное поручение
      internal static let title = L10n.tr("Localizable", "Payment.Destination.title")
    }
    internal enum Tax {
      /// НДС 12%%
      internal static let nds = L10n.tr("Localizable", "Payment.Tax.nds")
      /// НДС не облагается
      internal static let notax = L10n.tr("Localizable", "Payment.Tax.notax")
    }
    internal enum Urgent {
      /// Срочный платеж
      internal static let placeholder = L10n.tr("Localizable", "Payment.Urgent.placeholder")
    }
  }

  internal enum PaymentList {
    internal enum Kbe {
      /// Нерезидент
      internal static let notResident = L10n.tr("Localizable", "PaymentList.KBE.notResident")
      /// Резидент
      internal static let resident = L10n.tr("Localizable", "PaymentList.KBE.resident")
    }
    internal enum List {
      /// КБе
      internal static let kbe = L10n.tr("Localizable", "PaymentList.List.kbe")
      /// КБК
      internal static let kbk = L10n.tr("Localizable", "PaymentList.List.kbk")
      /// КНП
      internal static let knp = L10n.tr("Localizable", "PaymentList.List.knp")
    }
  }

  internal enum Payments {
    internal enum Card {
      /// Валютный платеж
      internal static let accountUsd = L10n.tr("Localizable", "Payments.Card.accountUsd")
      /// Зарплатные отчисления
      internal static let cashback = L10n.tr("Localizable", "Payments.Card.cashback")
      /// Конвертация валюты
      internal static let convert = L10n.tr("Localizable", "Payments.Card.convert")
      /// Социальные отчисления
      internal static let health = L10n.tr("Localizable", "Payments.Card.health")
      /// Платежное поручение
      internal static let invoicePayment = L10n.tr("Localizable", "Payments.Card.invoicePayment")
      /// Медицинские отчисления
      internal static let medical = L10n.tr("Localizable", "Payments.Card.medical")
      /// ОСМС платежи
      internal static let medicalText = L10n.tr("Localizable", "Payments.Card.medicalText")
      /// Пенсионные отчисления
      internal static let moneyBox = L10n.tr("Localizable", "Payments.Card.moneyBox")
      /// Платежи в бюджет
      internal static let paymentState = L10n.tr("Localizable", "Payments.Card.paymentState")
      /// Платежи и переводы
      internal static let title = L10n.tr("Localizable", "Payments.Card.title")
    }
    internal enum Confirm {
      /// Введен неверный код
      internal static let error = L10n.tr("Localizable", "Payments.Confirm.error")
      /// Введите одноразовый пароль
      internal static let info = L10n.tr("Localizable", "Payments.Confirm.info")
      /// Отправить повторно
      internal static let resend = L10n.tr("Localizable", "Payments.Confirm.resend")
      internal enum Save {
        internal enum Failure {
          /// Произошла ошибка при сохранении платежа
          internal static let message = L10n.tr("Localizable", "Payments.Confirm.save.failure.message")
          /// Ошибка сохранения
          internal static let title = L10n.tr("Localizable", "Payments.Confirm.save.failure.title")
        }
        internal enum Succes {
          /// Платеж успешно сохранен
          internal static let message = L10n.tr("Localizable", "Payments.Confirm.save.succes.message")
          /// Платеж сохранен
          internal static let title = L10n.tr("Localizable", "Payments.Confirm.save.succes.title")
        }
      }
      internal enum Sign {
        internal enum Failure {
          /// Произошла ошибка при подписании платежа
          internal static let message = L10n.tr("Localizable", "Payments.Confirm.sign.failure.message")
          /// Ошибка подписания
          internal static let title = L10n.tr("Localizable", "Payments.Confirm.sign.failure.title")
        }
        internal enum Succes {
          /// Платеж успешно подписан
          internal static let message = L10n.tr("Localizable", "Payments.Confirm.sign.succes.message")
          /// Платеж подписан
          internal static let title = L10n.tr("Localizable", "Payments.Confirm.sign.succes.title")
        }
      }
    }
    internal enum Destination {
      /// БИН/ИИН
      internal static let bin = L10n.tr("Localizable", "Payments.Destination.bin")
      /// КБе
      internal static let kbe = L10n.tr("Localizable", "Payments.Destination.kbe")
      /// Уведомить получателя
      internal static let notification = L10n.tr("Localizable", "Payments.Destination.notification")
      /// Номер счёта
      internal static let number = L10n.tr("Localizable", "Payments.Destination.number")
      /// Получатель
      internal static let receiver = L10n.tr("Localizable", "Payments.Destination.receiver")
      /// Платежное поручение
      internal static let title = L10n.tr("Localizable", "Payments.Destination.title")
    }
    internal enum Detail {
      /// В том числе НДС 12%
      internal static let addtax = L10n.tr("Localizable", "Payments.Detail.addtax")
      /// Выберите VIN код
      internal static let choosevin = L10n.tr("Localizable", "Payments.Detail.choosevin")
      /// Дата валютирования
      internal static let date = L10n.tr("Localizable", "Payments.Detail.date")
      /// Назначение платежа
      internal static let destination = L10n.tr("Localizable", "Payments.Detail.destination")
      /// Срочный платеж
      internal static let express = L10n.tr("Localizable", "Payments.Detail.express")
      /// КНП
      internal static let knp = L10n.tr("Localizable", "Payments.Detail.knp")
      /// НДС 12%%
      internal static let nds = L10n.tr("Localizable", "Payments.Detail.nds")
      /// НДС не облагается
      internal static let notax = L10n.tr("Localizable", "Payments.Detail.notax")
      /// Укажите КНП
      internal static let selectKnp = L10n.tr("Localizable", "Payments.Detail.selectKnp")
      /// Счёт списания
      internal static let title = L10n.tr("Localizable", "Payments.Detail.title")
      /// VIN-код автомобиля
      internal static let vin = L10n.tr("Localizable", "Payments.Detail.vin")
      internal enum Cell {
        /// Детали платежа
        internal static let section = L10n.tr("Localizable", "Payments.Detail.Cell.section")
      }
      internal enum Sum {
        internal enum Description {
          /// Общая сумма реестра
          internal static let common = L10n.tr("Localizable", "Payments.Detail.Sum.Description.common")
          /// Сумма платежа
          internal static let payment = L10n.tr("Localizable", "Payments.Detail.Sum.Description.payment")
          /// Сумма налога
          internal static let tax = L10n.tr("Localizable", "Payments.Detail.Sum.Description.tax")
        }
      }
    }
    internal enum Status {
      /// Обрабатывается банком
      internal static let processing = L10n.tr("Localizable", "Payments.Status.processing")
      /// Отклонённые банком
      internal static let rejected = L10n.tr("Localizable", "Payments.Status.rejected")
      /// На подпись
      internal static let toSignature = L10n.tr("Localizable", "Payments.Status.toSignature")
    }
    internal enum Tax {
      internal enum Main {
        /// Оплата налогов
        internal static let sectiontitle = L10n.tr("Localizable", "Payments.Tax.Main.sectiontitle")
        internal enum Cell {
          /// KBK
          internal static let kbk = L10n.tr("Localizable", "Payments.Tax.Main.Cell.kbk")
        }
        internal enum Placeholder {
          /// Тип платежа
          internal static let payment = L10n.tr("Localizable", "Payments.Tax.Main.Placeholder.payment")
          /// Город
          internal static let region = L10n.tr("Localizable", "Payments.Tax.Main.Placeholder.region")
          /// УГД
          internal static let ugd = L10n.tr("Localizable", "Payments.Tax.Main.Placeholder.ugd")
          /// VIN коды
          internal static let vin = L10n.tr("Localizable", "Payments.Tax.Main.Placeholder.vin")
        }
      }
    }
  }

  internal enum PaymentsCollection {
    /// Все
    internal static let all = L10n.tr("Localizable", "PaymentsCollection.all")
    /// Платежи
    internal static let payments = L10n.tr("Localizable", "PaymentsCollection.payments")
  }

  internal enum PensionContribution {
    internal enum Add {
      /// Дата рождения
      internal static let birthday = L10n.tr("Localizable", "PensionContribution.Add.birthday")
      /// Редактирование
      internal static let editTitle = L10n.tr("Localizable", "PensionContribution.Add.editTitle")
      /// Сотрудник
      internal static let employee = L10n.tr("Localizable", "PensionContribution.Add.employee")
      /// Укажите дату рождения
      internal static let errorBirthday = L10n.tr("Localizable", "PensionContribution.Add.errorBirthday")
      /// Укажите имя
      internal static let errorFirsname = L10n.tr("Localizable", "PensionContribution.Add.errorFirsname")
      /// Укажите фамилию
      internal static let errorSurname = L10n.tr("Localizable", "PensionContribution.Add.errorSurname")
      /// Имя
      internal static let firsname = L10n.tr("Localizable", "PensionContribution.Add.firsname")
      /// Новый сотрудник
      internal static let newEmployee = L10n.tr("Localizable", "PensionContribution.Add.newEmployee")
      /// Отчество
      internal static let patronymic = L10n.tr("Localizable", "PensionContribution.Add.patronymic")
      /// Реестр
      internal static let reestr = L10n.tr("Localizable", "PensionContribution.Add.reestr")
      /// Фамилия
      internal static let surname = L10n.tr("Localizable", "PensionContribution.Add.surname")
    }
    internal enum Cell {
      /// Некорректная сумма
      internal static let incorrectSumm = L10n.tr("Localizable", "PensionContribution.Cell.incorrectSumm")
      /// Некорректный ИИН
      internal static let incorrectUin = L10n.tr("Localizable", "PensionContribution.Cell.incorrectUin")
    }
  }

  internal enum PersonalManager {
    /// Персональный менеджер
    internal static let personalManager = L10n.tr("Localizable", "PersonalManager.PersonalManager")
  }

  internal enum PinCode {
    internal enum Change {
      /// Смена кода
      internal static let title = L10n.tr("Localizable", "PinCode.Change.title")
    }
    internal enum InfoLabel {
      /// Введите код-пароль
      internal static let title = L10n.tr("Localizable", "PinCode.InfoLabel.title")
    }
    internal enum Touch {
      /// Приложите палец, чтобы войти
      internal static let title = L10n.tr("Localizable", "PinCode.Touch.title")
    }
  }

  internal enum Recovery {
    internal enum Password {
      /// Позвоните нам
      internal static let mainTitle = L10n.tr("Localizable", "Recovery.Password.mainTitle")
      /// Для восстановления пароля Вам\nпотребуется БИН, название компании\nи кодовое слово.
      internal static let subTitle = L10n.tr("Localizable", "Recovery.Password.subTitle")
    }
  }

  internal enum Result {
    /// Сервис временно не доступен.\nПопробуйте зайти позже
    internal static let noBranches = L10n.tr("Localizable", "Result.noBranches")
    /// Данные не найдены
    internal static let noData = L10n.tr("Localizable", "Result.noData")
    /// КБК не найдено
    internal static let noKbk = L10n.tr("Localizable", "Result.noKbk")
    /// Сервис временно не доступен.\nПопробуйте зайти позже
    internal static let noMachines = L10n.tr("Localizable", "Result.noMachines")
    /// Транзакций не найдено
    internal static let noTransactions = L10n.tr("Localizable", "Result.noTransactions")
    /// За вашей компанией не закреплен автотранспорт
    internal static let noVin = L10n.tr("Localizable", "Result.noVin")
  }

  internal enum Screen {
    /// Выписка
    internal static let events = L10n.tr("Localizable", "Screen.Events")
    /// Главная
    internal static let main = L10n.tr("Localizable", "Screen.Main")
    /// Еще
    internal static let more = L10n.tr("Localizable", "Screen.More")
    /// Платежи
    internal static let payments = L10n.tr("Localizable", "Screen.Payments")
    internal enum PaymentStatus {
      /// На подпись
      internal static let signature = L10n.tr("Localizable", "Screen.PaymentStatus.Signature")
    }
  }

  internal enum Settings {
    internal enum Pin {
      /// Сменить код доступа
      internal static let change = L10n.tr("Localizable", "Settings.Pin.change")
      /// Использовать FaceID
      internal static let faceidid = L10n.tr("Localizable", "Settings.Pin.faceidid")
      /// Использовать TouchID
      internal static let touchid = L10n.tr("Localizable", "Settings.Pin.touchid")
      internal enum Autologin {
        /// Если вы разблокируете ваш телефон через TouchId, в течении 10 секунд вы сможите зайти а приложение AlfaBuisness без дополнительной разблокировки.
        internal static let detail = L10n.tr("Localizable", "Settings.Pin.Autologin.detail")
        /// Автовход
        internal static let title = L10n.tr("Localizable", "Settings.Pin.Autologin.title")
      }
    }
  }

  internal enum SignIn {
    internal enum Error {
      /// Неверный номер телефона
      internal static let phone = L10n.tr("Localizable", "SignIn.Error.phone")
    }
    internal enum Phone {
      /// Чтобы продолжить работу, необходимо зарегистрироваться. Приложение бесплатное.
      internal static let detail = L10n.tr("Localizable", "SignIn.Phone.detail")
      /// Укажите мобильный номер
      internal static let title = L10n.tr("Localizable", "SignIn.Phone.title")
    }
    internal enum Uin {
      /// Введите свой ИИН
      internal static let title = L10n.tr("Localizable", "SignIn.UIN.title")
    }
  }

  internal enum SignInInfromation {
    /// Для работы \nв интернет-банкинге \nобратитесь в Call-Center
    internal static let description = L10n.tr("Localizable", "SignInInfromation.description")
  }

  internal enum Signup {
    /// Подтвердить
    internal static let confirm = L10n.tr("Localizable", "Signup.Confirm")
    internal enum Button {
      /// Регистрация
      internal static let text = L10n.tr("Localizable", "Signup.Button.text")
    }
    internal enum Code {
      /// Код активации
      internal static let activationcode = L10n.tr("Localizable", "Signup.Code.activationcode")
      /// отправить повторно
      internal static let resend = L10n.tr("Localizable", "Signup.Code.resend")
      /// Повторная отправка SMS будет доступна через
      internal static let sms = L10n.tr("Localizable", "Signup.Code.sms")
      internal enum Phone {
        /// На Ваш номер %@ был отправлен SMS c кодом подтверждения.
        internal static func info(_ p1: String) -> String {
          return L10n.tr("Localizable", "Signup.Code.Phone.info", p1)
        }
      }
      internal enum Seconds {
        /// секунд
        internal static let many = L10n.tr("Localizable", "Signup.Code.Seconds.many")
      }
    }
    internal enum Detail {
      /// Компания
      internal static let company = L10n.tr("Localizable", "Signup.Detail.Company")
      /// ФИО
      internal static let fullname = L10n.tr("Localizable", "Signup.Detail.fullname")
      /// ИИН
      internal static let iin = L10n.tr("Localizable", "Signup.Detail.iin")
    }
    internal enum Info {
      /// Используйте компанию, пользователя, пароль из Интернет-Банка
      internal static let text = L10n.tr("Localizable", "Signup.Info.text")
    }
    internal enum Label {
      /// 
      internal static let text = L10n.tr("Localizable", "Signup.Label.text")
    }
  }

  internal enum Templates {
    internal enum List {
      /// Здесь появятся шаблоны
      internal static let emptyDescription = L10n.tr("Localizable", "Templates.List.emptyDescription")
      /// Шаблонов нет
      internal static let emptyTitle = L10n.tr("Localizable", "Templates.List.emptyTitle")
    }
  }

  internal enum TemplatesList {
    internal enum Card {
      /// USD, EUR, RUB, KZT
      internal static let convertDescription = L10n.tr("Localizable", "TemplatesList.Card.convertDescription")
      /// Медицинские отчисления
      internal static let medicalDescription = L10n.tr("Localizable", "TemplatesList.Card.medicalDescription")
      /// Перевод контрагенту
      internal static let paymentDescription = L10n.tr("Localizable", "TemplatesList.Card.paymentDescription")
      /// Обязательные, Добровольные, Профессиональные
      internal static let pensionDescription = L10n.tr("Localizable", "TemplatesList.Card.pensionDescription")
      /// Налоги
      internal static let taxDescription = L10n.tr("Localizable", "TemplatesList.Card.taxDescription")
    }
  }

  internal enum Transaction {
    /// Расчетный счет
    internal static let account = L10n.tr("Localizable", "Transaction.Account")
    /// Банк
    internal static let bank = L10n.tr("Localizable", "Transaction.Bank")
    /// БИН/ИИН
    internal static let iin = L10n.tr("Localizable", "Transaction.IIN")
    /// Платёж №
    internal static let payment = L10n.tr("Localizable", "Transaction.Payment")
    /// Получатель
    internal static let receiver = L10n.tr("Localizable", "Transaction.Receiver")
    /// Отправить квитанцию
    internal static let send = L10n.tr("Localizable", "Transaction.Send")
    internal enum Filter {
      /// От
      internal static let from = L10n.tr("Localizable", "Transaction.Filter.From")
      /// Период
      internal static let period = L10n.tr("Localizable", "Transaction.Filter.Period")
      /// Сумма
      internal static let summ = L10n.tr("Localizable", "Transaction.Filter.Summ")
      /// До
      internal static let to = L10n.tr("Localizable", "Transaction.Filter.To")
    }
    internal enum Info {
      /// Квитанция
      internal static let pdf = L10n.tr("Localizable", "Transaction.Info.pdf")
      /// Повторить
      internal static let `repeat` = L10n.tr("Localizable", "Transaction.Info.repeat")
      /// В шаблон
      internal static let templates = L10n.tr("Localizable", "Transaction.Info.templates")
      internal enum Alert {
        /// Сохраненный шаблон можно найти на странице платежей
        internal static let message = L10n.tr("Localizable", "Transaction.Info.Alert.message")
        /// Шаблон успешно создан
        internal static let successfull = L10n.tr("Localizable", "Transaction.Info.Alert.successfull")
        /// Название шаблона
        internal static let templateName = L10n.tr("Localizable", "Transaction.Info.Alert.templateName")
        /// Как назвать шаблон?
        internal static let title = L10n.tr("Localizable", "Transaction.Info.Alert.title")
      }
    }
    internal enum Requisites {
      /// Счет списания: 
      internal static let accountDebit = L10n.tr("Localizable", "Transaction.Requisites.accountDebit")
      /// Счет получателя: 
      internal static let accountReceiver = L10n.tr("Localizable", "Transaction.Requisites.accountReceiver")
      /// Счет отправителя: 
      internal static let accountSender = L10n.tr("Localizable", "Transaction.Requisites.accountSender")
      /// БАНК: 
      internal static let bank = L10n.tr("Localizable", "Transaction.Requisites.bank")
      /// Исполнен
      internal static let fulfilled = L10n.tr("Localizable", "Transaction.Requisites.fulfilled")
      /// БИН/ИИН: 
      internal static let iin = L10n.tr("Localizable", "Transaction.Requisites.IIN")
      /// Назначение платежа: 
      internal static let purposeOfPayment = L10n.tr("Localizable", "Transaction.Requisites.purposeOfPayment")
      /// Получатель: 
      internal static let receiver = L10n.tr("Localizable", "Transaction.Requisites.receiver")
      /// Счет пополнения: 
      internal static let replenishment = L10n.tr("Localizable", "Transaction.Requisites.replenishment")
      /// Отправитель: 
      internal static let sender = L10n.tr("Localizable", "Transaction.Requisites.sender")
    }
    internal enum Share {
      /// Направляю вам детализацию выписки
      internal static let header = L10n.tr("Localizable", "Transaction.Share.Header")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
