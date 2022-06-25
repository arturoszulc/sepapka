

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



  //Question list
  listQuestion('list-question'),
  listQuestionSingle('list-question-single'),
  listQuestionFilter('list-question-filter'),

  //Academy
  academyMenu('academy'),
  tablesMenu('tables'),
  tableWireColors('table-wire-colors'),
  tableWireAmpacity('table-wire-ampacity'),
  tableWireSymbols('table-wire-symbols'),
  units('units'),

  //Calcs
  calcMenu('calc'),
  calcHeatingPowerThreePhase('calc-heating-power-three-phase'),

  //Purchase
  purchasePending('purchase-pending'),
  purchaseError('purchases-error'),
  purchaseSuccess('purchase-success'),

  //Other
  settings('settings'),
  remark('/remark'),
  debug('/debug'),
  purchase('/purchase');




  final String path;

  const MyScreen(this.path);
///UNUSED
  // purchasePatronite,

}