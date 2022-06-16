

enum MyScreen {

  loading('/loading'),
  signIn('/sign-in'),
  resetPassword('reset-password'),
  menu('/menu'),
  quizChooseLevel('choose-level'),
  quizChooseCategory('choose-category'),
  settings('settings'),
  quizQuestionSingle('quiz-question-single'),
  listQuestionSingle('list-question-single'),
  listQuestionFilter('list-question-filter'),
  listQuestion('list-question'),
  sessionFinished('/session-finished'),
  remark('/remark'),
  debug('/debug'),
  purchase('/purchase'),
  purchasePending('/purchase-pending'),
  purchaseError('/purchases-error'),
  purchaseSuccess('purchase-success'),
  academyMenu('academy'),
  tablesMenu('tables'),
  tableWireColors('/table-wire-colors'),
  tableWireAmpacity('/table-wire-ampacity'),
  tableWireSymbols('/table-wire-symbols'),
  units('/units'),

  calcMenu('calc'),
  calcHeatingPowerThreePhase('calc-heating-power-three-phase');

  final String path;

  const MyScreen(this.path);
///UNUSED
  // purchasePatronite,

}