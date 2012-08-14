requirejs.config(
  shim: 
    '../../libs/underscore':
      exports: "_" 

    '../../libs/backbone': 
      deps: ['../../libs/underscore', 'jquery'],
      exports: 'Backbone'

    '../../libs/Mustache':
      exports: "Mustache"     

    'models/Device':
      deps: ['../../libs/underscore', '../../libs/backbone', 'jquery']
      exports: 'Device'     

    'models/DeviceCollection':
      deps: ['../../libs/underscore', '../../libs/backbone', 'jquery','models/Device']
      exports: 'DeviceCollection'                 
)


define([
   'jquery',
   '../../libs/underscore',
   '../../libs/backbone',
   '../../libs/Mustache',
   '../../libs/text!../templates/popup.html',
   'models/Device',
   'models/DeviceCollection'
],
($,_, Backbone,Mustache,popup_template,Device,DeviceCollection)->
  PopupView = Backbone.View.extend
    el: "body"

    events:
      'click li' : 'openTab'

    initialize: (collection) ->
      @collection = new DeviceCollection(collection)

      @render()

    render: () ->
      html = Mustache.to_html(popup_template, {devices: @collection.toJSON(),url:localStorage["munin_monitor_url"]});
      
      @.$el.html(html)

    openTab: (event) =>
      url = $(event.currentTarget).data("url")
      chrome.tabs.create({url: url });

 
  popup = new PopupView(JSON.parse(localStorage['munin.monitor.devices']))
)