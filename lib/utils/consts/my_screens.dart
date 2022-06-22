

enum MyScreen {

  loading('/loading'),
  menu('/menu'),
  signIn('/sign-in'),
  quizQuestionSingle('/quiz-question-single'),
  listQuestion('/list-question'),
  resetPassword('reset-password'),
  quizChooseLevel('choose-level'),
  quizChooseCategory('choose-category'),
  settings('settings'),
  listQuestionSingle('list-question-single'),
  listQuestionFilter('list-question-filter'),
  sessionFinished('session-finished'),
  remark('/remark'),
  debug('/debug'),
  purchase('/purchase'),
  purchasePending('purchase-pending'),
  purchaseError('purchases-error'),
  purchaseSuccess('purchase-success'),
  academyMenu('academy'),
  tablesMenu('tables'),
  tableWireColors('table-wire-colors'),
  tableWireAmpacity('table-wire-ampacity'),
  tableWireSymbols('table-wire-symbols'),
  units('units'),

  calcMenu('calc'),
  calcHeatingPowerThreePhase('calc-heating-power-three-phase');

  final String path;

  const MyScreen(this.path);
///UNUSED
  // purchasePatronite,

}