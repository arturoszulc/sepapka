/////////////////
// UI Messages //
////////////////

const String msgResetSent = 'Link do zresetowania hasła został wysłany na podany adres e-mail';
const String msgProgressReset = 'Wszelkie postępy zostały skasowane';
const String msgThanksForRemark = 'Dziękuję za przesłanie uwagi!';
const String msgLeaveSession = 'Czy na pewno chcesz przerwać quiz?';


////////////////
// UI Errors //
///////////////

//General Error
const String errorNotInternetConnection = 'Brak połączenia z internetem';

//UserService Errors
const String errorUsernameCharValidation = 'Nazwa użytkownika może zawierać tylko litery i cyfry';
const String errorUsernameLength = 'Nazwa użytkownika musi zawierać od 3 do 16 znaków';
const String errorUsernameTaken = 'Ta nazwa użytkownika jest już zajęta';


//QuestionService Errors
const String errorRemarkTooShort = 'Wpisz uwagę';
const String errorRemarkChars = 'Usuń znaki specjalne';

//DB Errors
const String errorDbGeneric = 'Operacja się nie powiodła. Spróbuj później';
const String errorRollBackUser = 'Coś poszło nie tak. Spróbuj zalogować się ponownie do aplikacji';


//AuthService errors
const String errorSignInGoogle = 'Błąd logowania przez Google. Sprwadź połączenie z internetem.';

//Validation errors
const String errorValEmail = 'Wprowadź prawidłowy adres e-mail';
const String errorValPasswordLength = 'Hasło musi zawierać co najmniej 6 znaków';


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






