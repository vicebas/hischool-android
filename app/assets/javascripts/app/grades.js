$(document).on('turbolinks:load', function() {
  // Course filter
  $("#course_filter").on("change", function() {
    // Mounting route
    course_id = $("#course_filter").children("option:selected").val();
    if (course_id != '0') {
      branch_id = window.location.href.split('/')[6]
      grade_id = window.location.href.split('/')[8]
      route = "/app/institutions/branches/" + branch_id + "/grades/" + grade_id + "/course_filter?course_id=" + course_id;
      window.location.replace(window.location.origin + route);
    } else {
      branch_id = window.location.href.split('/')[6]
      grade_id = window.location.href.split('/')[8]
      route = "/app/institutions/branches/" + branch_id + "/grades/" + grade_id;
      window.location.replace(window.location.origin + route);
    }
  });

  // Teacher filter
  $("#teacher_filter").on("change", function() {
    // Mounting route
    teacher_id = $("#teacher_filter").children("option:selected").val();
    if (teacher_id != '0') {
      branch_id = window.location.href.split('/')[6]
      grade_id = window.location.href.split('/')[8]
      route = "/app/institutions/branches/" + branch_id + "/grades/" + grade_id + "/teacher_filter?teacher_id=" + teacher_id;
      window.location.replace(window.location.origin + route);
    } else {
      branch_id = window.location.href.split('/')[6]
      grade_id = window.location.href.split('/')[8]
      route = "/app/institutions/branches/" + branch_id + "/grades/" + grade_id;
      window.location.replace(window.location.origin + route);
    }
  });

  // Unit filter
  $("#unit_filter").on("change", function() {
    // Mounting route
    unit_id = $("#unit_filter").children("option:selected").val();
    if (unit_id != '0') {
      branch_id = window.location.href.split('/')[6]
      grade_id = window.location.href.split('/')[8]
      route = "/app/institutions/branches/" + branch_id + "/grades/" + grade_id + "/unit_filter?unit_id=" + unit_id;
      window.location.replace(window.location.origin + route);
    } else {
      branch_id = window.location.href.split('/')[6]
      grade_id = window.location.href.split('/')[8]
      route = "/app/institutions/branches/" + branch_id + "/grades/" + grade_id;
      window.location.replace(window.location.origin + route);
    }
  });

  if (location.pathname.split("/")[location.pathname.split("/").length - 1].split("_")[1] == 'filter') {
    if (location.search.replace('?','').split('=')[0] == 'course_id') {
      $('#course_filter_button').removeClass('btn-outline-primary').addClass('btn-primary');
    } else if (location.search.replace('?','').split('=')[0] == 'teacher_id') {
      $('#teacher_filter_button').removeClass('btn-outline-primary').addClass('btn-primary');
    } else {
      $('#unit_filter_button').removeClass('btn-outline-primary').addClass('btn-primary');
    }
  }

  if ($('#calendar').length) {
    $.getJSON(window.location.href, function(data) {
      mapped_data = data.map(function(event) {
        return {
          "title": event['unit_name'],
          "branch_id": event['branch_id'],
          "grade_id": event['grade_id'],
          "grade_unit_id": event['id'],
          "textColor": "#FFF",
          "start": event['pretty_start'],
          "end": event['pretty_end'],
          "allDay": false
        };
      });

      $('#calendar').fullCalendar({
        events: mapped_data,
        selectable: true,
        select: function (data) {
          // modal
          $('#new_grade_unit_modal').modal({
            keyboard: false
          });

          // Changing default dates
          var day = data.date();
          var day = data.date();
          var month = data.month();
          var year = data.year();
          $("#grade_unit_starts_on_1i").val(year);
          $("#grade_unit_starts_on_2i").val(month + 1);
          $("#grade_unit_starts_on_3i").val(day);
          $("#grade_unit_ends_on_1i").val(year);
          $("#grade_unit_ends_on_2i").val(month + 1);
          $("#grade_unit_ends_on_3i").val(day);

          // Setting default checkbox
          $('.custom-control-input').prop('checked', false)
          $("#" + data.format('dddd').toLowerCase() + "_checkbox").prop('checked', true);
        },
        locale: 'pt-br',
        eventClick: function(eventClickInfo) {
          route = "/app/institutions/branches/" + mapped_data[1]["branch_id"] + "/grades/" + mapped_data[1]["grade_id"] + "/grade_units/" + eventClickInfo['grade_unit_id'];
          $.getJSON(route, function(data) {
            $("#modal-title").html(data['unit_name']);
            $(".course-name").html(data['course_name']);

            date = new Date(data['pretty_start']);
            var day = date.getDate();
            var month = date.getMonth();
            var year = date.getFullYear();
            var dateString = day + "/" + (month + 1) + "/" + year;
            var start = date.getHours() + ":" + (date.getUTCMinutes().toString().length == 1 ? (date.getUTCMinutes() + "0") : date.getUTCMinutes());

            date = new Date(data['pretty_end']);
            var end =  date.getHours() + ":" + (date.getUTCMinutes().toString().length == 1 ? (date.getUTCMinutes() + "0") : date.getUTCMinutes());

            $(".grade-unit-schedule").html(dateString + ", " + start + " até " + end);

            var teachers_array = [];
            for (let teacher of data["teachers"]) {
              teachers_array.push(teacher["name"]);
            }

            if (teachers_array.length > 0) {
              $('#docencia-title').removeClass('d-none');
              $(".grade-unit-teachers").html(teachers_array.join(', '))
            } else {
              $('#docencia-title').addClass('d-none');
            }
          })

          // modals
          $('#grade_unit_modal').modal({
            keyboard: false
          })

          var new_grade_unit_destroy_path = "/app/institutions/branches/" + eventClickInfo['branch_id'] + "/grades/" + eventClickInfo['grade_id'] + "/grade_units/" + eventClickInfo['grade_unit_id'];
          $('#destroy_grade_unit').attr('href', new_grade_unit_destroy_path);
        },
        displayEventEnd: true,
        eventTimeFormat: "H:mm"
      });
    });
  }
});
