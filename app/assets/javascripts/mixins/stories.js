client = new Faye.Client("/faye", {
  retry: 5,
  timeout: 120
});

client.subscribe('/stories', function(message) {
  if(message.type == 'created') {
    alert('New record created: ' + JSON.parse(message.data).id);
  } else if(message.type == 'updated') {
    alert('Record updated: ' + JSON.parse(message.data).id);
  } else if(message.type == 'deleted') {
    alert('Record Deleted: ' + JSON.parse(message.data).id);
  }
});