$(document).on('turbolinks:load', function() {
  $('#course_select').on('change', function() {
    // Mounting route
    branch = $(this).data("branch");
    course_id = $(this).children("option:selected").val();
    route = "/app/institutions/branches/" + branch + "/courses/" + course_id + "/units_codes";
    // Cleaning old option values
    $('#grade_unit_unit_id').find('option').remove().end();

    // Removing d-none classes
    $('.hidden-fields').removeClass('d-none');

    // Appending new select values
    $.get(route, function(data) {
      for (var i = 0; i < data.length; i++) {
        $('#grade_unit_unit_id').append(new Option(data[i][1], data[i][0]));;
      }
    });

    setTimeout(function() {
      // Mounting route
      course_id = $("#course_select").children("option:selected").val();
      unit_id = $("#grade_unit_unit_id").children("option:selected").val();
      route = "/app/institutions/branches/" + branch + "/courses/" + course_id + "/units/" + unit_id + "/teachers_groups/groups_codes";

      // Appending new select values
      $.get(route, function(data) {
        $('#grade_unit_group_id').find('option').remove().end();
        for (var i = 0; i < data.length; i++) {
          $('#grade_unit_group_id').append(new Option(data[i][0], data[i][1]));;
        }
      });
    }, 500);
  });

  $('#grade_unit_unit_id').on('change', function() {
    // Mounting route
    course_id = $("#course_select").children("option:selected").val();
    unit_id = $("#grade_unit_unit_id").children("option:selected").val();
    route = "/app/institutions/branches/" + branch + "/courses/" + course_id + "/units/" + unit_id + "/teachers_groups/groups_codes";

    // Appending new select values
    $.get(route, function(data) {
      $('#grade_unit_group_id').find('option').remove().end();
      for (var i = 0; i < data.length; i++) {
        $('#grade_unit_group_id').append(new Option(data[i][0], data[i][1]));;
      }
    });
  });
});
