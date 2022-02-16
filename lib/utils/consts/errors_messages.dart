/////////////////
// UI Messages //
////////////////

const String msgResetSent = 'Link do zresetowania hasła został wysłany na podany adres e-mail';
const String msgProgressReset = 'Wszelkie postępy zostały skasowane';
const String msgThanksForRemark = 'Dziękuję za przesłanie uwagi!';


////////////////
// UI Errors //
///////////////

//UserService Errors
const String usernameCharValidationError = 'Nazwa użytkownika może zawierać tylko litery i cyfry';
const String usernameLengthError = 'Nazwa użytkownika musi zawierać od 3 do 16 znaków';
const String usernameTakenError = 'Ta nazwa użytkownika jest już zajęta';


//QuestionService Errors
const String errorRemarkTooShort = 'Wpisz uwagę';
const String errorRemarkChars = 'Usuń znaki specjalne';

//DB Errors
const String errorDbGeneric = 'Operacja się nie powiodła. Spróbuj później';
const String errorRollBackUser = 'Coś poszło nie tak. Spróbuj zalogować się ponownie do aplikacji';


//AuthService errors
const String errorSignInGoogle = 'Błąd logowania przez Google. Spróbuj ponownie';
const String errorValEmail = 'Nieprawidłowy adres e-mail Nieprawidłowy adres e-mail Nieprawidłowy adres e-mail';
const String errorValPassword = 'Hasło musi zawierać: \n - co najmniej 8 znaków \n - co najmniej 1 cyfrę \n - co najmniej 1 znak specjalny';


//////////////////
// DEBUG Errors //
//////////////////

//QuestionService Errors
const String errorSendingRemark = '### Wysyłanie uwagi nie powiodło się ###';

//DB Errors
const String errorDbConnection = '### Brak połączenia z bazą danych ###';
const String errorGetGlobalData = '### Nie udało się pobrać danych z serwera ###';
const String errorGetQListFromDB =
    '### Nie można pobrać listy pytań. Sprawdź połączenie z internetem ###';
const String errorGetUserDataFromDB =
    '### Błąd pobierania danych użytkownika. Spróbuje utworzyć nowego... ### ';
const String errorUpdateUserInDb = '### Nie udało się zaktualizować danych użytkownika ###';

//AuthService Errors
const String errorSignIn = '### AuthService.signInEmail() error: ';
const String errorSignOut = '### AuthService.signOut() error: ';

//FileService error
const String errorWritingFile =
    '### FileService.saveQuestionListToFile() error: Couldnt write data to file ###';
const String errorReadingFile =
    '### FileService.getQuestionListFromFile() error: Couldnt read data from file ###';






