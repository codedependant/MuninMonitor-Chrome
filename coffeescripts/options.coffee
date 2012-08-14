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
   '../../libs/text!../templates/options.html',
   'models/Device',
   'models/DeviceCollection'
],
($,_, Backbone,Mustache,options_template,Device,DeviceCollection)->
  OptionsView = Backbone.View.extend
    el: "body"

    events:
      'click button#submit' : 'savePreferences'
      'change input#intervalSlider' : 'updateSlider'

    initialize: (collection) ->
      @render()

    render: () ->
      options = 
        munin_monitor_url: localStorage["munin_monitor_url"]
        munin_monitor_interval: parseInt(localStorage["munin_monitor_interval"]) / 60000

      html = Mustache.to_html(options_template,options)
      @.$el.html(html)

    savePreferences: (event) =>
      url = $("#muninPage").val()
      interval = $("#pollingInterval").val()
      messages = []


      if ! /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.test(url)
        messages.push("#{url} is not a valid URL")

      if ! parseInt(interval)
        messages.push("Please enter a number for interval")

      if messages.length == 0
        localStorage["munin_monitor_interval"] = interval * 60000
        localStorage["munin_monitor_url"] = url
        messages.push("Settings saved")


      $("#messages").html("")
      for message in messages
        $("#messages").append("<label>#{messages}</label>")
      $("#messages").show(300)

      devices = new DeviceCollection()
      devices.model = Device
      devices.url = localStorage["munin_monitor_url"]
      devices.updateFetch()

    updateSlider: (event) =>
      $("#pollingInterval").val($("#intervalSlider").val())


  options = new OptionsView()
)