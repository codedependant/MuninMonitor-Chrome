  this.DeviceCollection = Backbone.Collection.extend
   
    url: localStorage["munin_monitor_url"]

    initialize: (models,option) ->    
      
      if option? and option.badge?
        this.badge = option.badge

      this.on("reset",this.collectionReset,this)
      this.on("add",this.deviceAdded,this)
      this.on("remove",this.deviceAdded,this)
      this.on("error",this.handleError,this)    


      localStorage['munin_monitor_url'] = (localStorage['munin_monitor_url'] || 'http://munin.ping.uio.no/')
      url = localStorage['munin_monitor_url']
      localStorage['munin_monitor_interval'] = (localStorage['munin_monitor_interval'] || (1 * 60000))

    parse: (response) ->
      url = this.url
      resp = []
      $(response).find(".warn,.crit").each( (index,element) ->
        href = $(element).attr("href")
        class_attr = $(element).attr("class")
        hrefSplit = href.split("/")

        domain = hrefSplit[hrefSplit.length-3]
        host = hrefSplit[hrefSplit.length-2]
        serviceArr = hrefSplit[hrefSplit.length-1].split("#")
        service = serviceArr[1]

        if service?
          service = service.toLowerCase().replace(/\b[a-z]/g, (letter) -> 
            return letter.toUpperCase();
          )
        
        classname =  if class_attr == "warn" then "warning" else "error"

          
        message = "#{service} #{classname} on #{host}"
        resp.push({id:url+href,class:class_attr,host:host,domain:domain,service:service,message:message})
      )
      return resp

    deviceAdded: (device) ->
      if this.badge?
        this.badge.animateFlip()


      localStorage["munin.monitor.devices"] = JSON.stringify(this.toJSON())
      chrome.browserAction.setBadgeText({text: "#{this.size()}"})  

    handleError: () =>
      chrome.browserAction.setBadgeText({text: "x"})
      localStorage["munin.monitor.devices"] = "[]"

    updateFetch: () ->
      @.fetch({"dataType" : "html","cache":false,"update":true,"removeMissing":true})

    poll: (interval) ->
      @.url = localStorage["munin_monitor_url"]
      @.updateFetch()
      @timeout = setTimeout(() =>
        @.poll(parseInt(localStorage["munin_monitor_interval"]))
      ,interval)

    comparator: (chapter) ->
      chapter.get("class")
