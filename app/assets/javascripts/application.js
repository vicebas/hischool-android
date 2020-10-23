//= require jquery3
//= require popper
//= require bootstrap
//= require app/sb-admin-2
//= require app/dashboard
//= require app/branches
//= require app/students
//= require app/teachers
//= require app/grades
//= require app/grade_unit
//= require app/students_groups
//= require app/teachers_groups
//= require rails-ujs
//= require activestorage
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all
//= require turbolinks
//= require jquery-ui/widgets/datepicker
//= require_self
//= require_tree .

$(document).on('turbolinks:load', function() {
  setTimeout(function(){
    // Flash toasts
    $('#flash-toast').toast('show');

    // Universal tooltips
    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })
  }, 500);

  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy',
    dateFormat: 'dd/mm/yy'
  });
});

// change region function
function changeRegion(id) {
  origin = window.location.origin;
  controller_name = window.location.pathname.split('/')[5];
  window.location.href = origin + '/app/institutions/branches/' + id + '/' + controller_name;
}
