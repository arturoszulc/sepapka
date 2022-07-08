

enum MyScreen {

  loading('/loading'),
  menu('/menu'),
  sing_in('/sign-in'),

  //Sign In subroute
  reset_password('reset-password'),


  //Quiz
  quiz_menu('quiz'),
  quiz_choose_level('choose-level'),
  quiz_choose_category('choose-category'),
  quiz_question_single('quiz-question-single'),
  quiz_finished('quiz-finished'),
  remark('remark'),



  //Question list
  list_question('list-question'),
  list_question_single('list-question-single'),
  list_question_filter('list-question-filter'),

  //Academy
  academy_menu('academy'),
  academy_unit('unit'),
  academy_lesson('lesson'),
  academy_index('index'),


  //Tables
  tables_menu('tables'),
  table_wire_colors('table-wire-colors'),
  table_wire_ampacity('table-wire-ampacity'),
  table_wire_symbols('table-wire-symbols'),
  table_wire_diameter('table-wire-diameter'),
  table_units('units'),

  //Calcs
  calc_menu('calc'),
  calc_heating_power_three_phase('calc-heating-power-three-phase'),
  calc_ohms_law('calc-ohms-law'),

  //Purchase
  purchase_wrapper('purchase'),
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