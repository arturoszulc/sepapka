

enum MyScreen {

  loading('/loading'),
  menu('/menu'),
  signIn('/sign-in'),

  //Sign In subroute
  resetPassword('reset-password'),


  //Quiz
  quizMenu('quiz'),
  quizChooseLevel('choose-level'),
  quizChooseCategory('choose-category'),
  quizQuestionSingle('quiz-question-single'),
  quizFinished('quiz-finished'),
  remark('remark'),



  //Question list
  listQuestion('list-question'),
  listQuestionSingle('list-question-single'),
  listQuestionFilter('list-question-filter'),

  //Academy
  academyMenu('academy'),
  academyUnit('unit'),
  academyLesson('lesson'),
  academyIndex('index'),


  //Tables
  tablesMenu('tables'),
  tableWireColors('table-wire-colors'),
  tableWireAmpacity('table-wire-ampacity'),
  tableWireSymbols('table-wire-symbols'),
  tableWireDiameter('table-wire-diameter'),
  tableUnits('units'),

  //Calcs
  calcMenu('calc'),
  calcHeatingPowerThreePhase('calc-heating-power-three-phase'),

  //Purchase
  purchaseWrapper('purchase'),
  // purchaseLoading('loading'),
  // purchaseError('error'),
  // purchasePending('pending'),
  // purchaseSuccess('success'),

  //Other
  settings('settings'),
  debug('/debug'),
  purchase('/purchase');




  final String path;

  const MyScreen(this.path);
///UNUSED
  // purchasePatronite,

}