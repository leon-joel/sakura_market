function editSendToAddress(){
  let name = $('#name-div').html();
  $('#name-input').val(name);

  let address = $('#address-div').html();
  $('#address-input').val(address);

  $('#edit-address-modal').modal("show");
}

function updateSendToAddress() {
  let name = $('#name-input').val();
  $('#name-div').html(name);

  let address = $('#address-input').val();
  $('#address-div').html(address);

  $('#edit-address-modal').modal('hide');
}


function editDeliveryTimeRage() {

}