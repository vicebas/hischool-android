$(document).on('focus', '#branch_cep', function() {
  $("#branch_neighborhood").val('')
  $("#branch_federation_id").val('')
  $("#branch_city").val('')
  $("#branch_street").val('')
});

$(document).on('change', '#branch_cep', function() {
  cep = $('#branch_cep').val();
  route = "https://viacep.com.br/ws/" + cep + "/json/"
  $.get(route, function(data) {
    console.log(data['bairro']);
    $("#branch_neighborhood").val(data['bairro'])
    $("#branch_federation_id").val(data['uf'])
    $("#branch_city").val(data['localidade'])
    $("#branch_street").val(data['logradouro'])
    console.log(data);
  });
});
