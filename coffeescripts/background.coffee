requirejs.config(
  shim: 
    '../../libs/underscore':
      exports: "_" 

    '../../libs/backbone': 
      deps: ['../../libs/underscore', 'jquery'],
      exports: 'Backbone'


    'models/Device':
      deps: ['../../libs/underscore', '../../libs/backbone', 'jquery']
      exports: 'Device'     

    'models/DeviceCollection':
      deps: ['../../libs/underscore', '../../libs/backbone', 'jquery','models/Device']
      exports: 'DeviceCollection'           

      'BadgeAnimator':
        deps: []
        exports: 'BadgeAnimator'
)

define(['jquery',
        '../../libs/underscore',
        '../../libs/backbone',
        'models/Device',
        'models/DeviceCollection',
        'BadgeAnimator'],
($,_, Backbone,Device,DeviceCollection,BadgeAnimator) ->
  badge = new this.BadgeAnimator()

  devices = new DeviceCollection([],{badge:badge})
  devices.model = Device
  devices.poll(parseInt(localStorage["munin_monitor_interval"]))
)