this.BadgeAnimator = class BadgeAnimator
  constructor: () ->
    @rotation = 0
    @canvas = $('canvas')[0]
    @canvasContext = canvas.getContext('2d')
    @loggedInImage = $('#icon')[0]


  drawIconAtRotation: () ->
    @canvasContext.save();
    @canvasContext.clearRect(0, 0, @canvas.width, @canvas.height);
    @canvasContext.translate(Math.ceil(@canvas.width/2),Math.ceil(@canvas.height/2));
    @canvasContext.rotate(2*Math.PI* this.ease(@rotation));
    @canvasContext.drawImage(@loggedInImage,-Math.ceil(@canvas.width/2),-Math.ceil(@canvas.height/2));
    @canvasContext.restore();
    
    chrome.browserAction.setIcon({imageData:@canvasContext.getImageData(0, 0,@canvas.width,@canvas.height)});


  animateFlip: () =>
    @rotation += 1/30;
    @drawIconAtRotation(@rotation)
    if (@rotation <= 1)
      setTimeout(this.animateFlip, 10);
    else
      @rotation = 0;
      this.drawIconAtRotation()
      
  ease: (x) ->
    (1-Math.sin(Math.PI/2 + x * Math.PI))/2