DS.ActiveModelAdapter.reopen({
  namespace: 'api/v1',
  headers: { 
    "Accept": "application/json, text/javascript; q=0.01"
  }
})

App.ApplicationSerializer = DS.ActiveModelSerializer()
