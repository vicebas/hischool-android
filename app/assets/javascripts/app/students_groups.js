$(document).on('turbolinks:load', function() {

  $('#master_checkbox').click(function() {
    if ($(this).is(':checked')) {
      $(".custom-control-input").prop('checked', true);
      $("#add_students_btn").removeClass('disabled');
    } else {
      $(".custom-control-input").prop('checked', false);
      $("#add_students_btn").addClass('disabled');
    }
  });

  $('.custom-control-input').click(function() {
    if ($("input:checkbox:checked").length > 0) {
      $("#add_students_btn").removeClass('disabled');
    } else {
      $("#add_students_btn").addClass('disabled');
    }
  });

  $('#add_students_btn').click(function() {
    // Getting infos
    branch = $(this).data('branch');
    course = $(this).data('course');
    unit = $(this).data('unit');
    group = $(this).data('group');

    // Mounting route
    route = "/app/institutions/branches/" + branch + "/courses/" + course + "/units/" + unit + "/students_groups/" + group + "/add_students";

    // Getting checked students
    students = { student_ids: [] }
    $("input:checkbox:checked").map(function() {
      if (!($(this)[0].id.split('_')[0] == 'master')) {
        students['student_ids'].push($(this)[0].id.split('_')[0]);
      }
    });

    // Performing the request
    $.ajax({
      type: "POST",
      url: route,
      data: students,
      success: function() {
        for (id of students['student_ids']) {
          $('.' + id + '_row').fadeOut();
        }
        // Flash toasts
        $('#add-students-toast').toast('show');
      },
      dataType: 'json'
    });

  });

});
