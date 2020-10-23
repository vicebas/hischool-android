function enableElement(...ids) {
  for (let i=0; i < ids.length; i++) {
    $(ids[i]).removeAttr("readonly");
    $(ids[i]).removeAttr("disabled");
    $(ids[i]).removeClass("d-none");
    $(ids[i]).removeClass("disabled");
  }
}
