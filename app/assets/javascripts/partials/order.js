function editSendToAddress(){
  let name = $('#order_send_to_name').val();
  $('#name-input').val(name);

  let address = $('#order_send_to_address').val();
  $('#address-input').val(address);

  $('#edit-address-modal').modal("show");
}

function updateSendToAddress() {
  let name = $('#name-input').val();
  $('#name-div').html(name);
  $('#order_send_to_name').val(name);

  let address = $('#address-input').val();
  $('#address-div').html(address);
  $('#order_send_to_address').val(address);

  $('#edit-address-modal').modal('hide');
}


function editDeliveryTimeRage() {
  let time_range = $('#order_delivery_time_range').val();
  $('[id^=delivery_time_range_label_]').each(function(i, elem) {
    $(elem).toggleClass("active", elem.dataset.rangeNum === time_range); // 第2引数がtrueの場合はadd, falseの場合はremove
  });

  $('#edit_time_range_modal').modal("show");
}
function updateDeliveryTimeRage() {
  let time_range = 0;
  $('[id^=delivery_time_range_label_]').each(function(i, elem) {
    if ($(elem).hasClass("active")){
      time_range = elem.dataset.rangeNum;
      return false;  // break
    }
  });

  $('#order_delivery_time_range').val(time_range);
  $('#delivery_time_range').html(time_range_to_string(time_range));

  $('#edit_time_range_modal').modal('hide');
}

// TODO: JSにまで変換メソッドが必要になってしまうのは残念… （application_helper.rb にもある）
function time_range_to_string(time_range) {
  switch (time_range) {
    case "0":
    default:
      return '指定なし';
    case "1":
      return '午前中（12時まで）';
    case "2":
      return '14時～16時';
    case "3":
      return '16時～18時';
    case "4":
      return '18時～20時';
    case "5":
      return '19時～21時';
  }
}