// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  $('#student_cellphone').mask('(00) 00000-0000');
  $('#student_tax_id').mask('000.000.000-00');
})
