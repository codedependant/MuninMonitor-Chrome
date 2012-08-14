<a href="https://chrome.google.com/webstore/detail/angbfgcchlfijepllcnedkfiajnnhljh">Munin Monitor</a> is a Chrome Extension which polls your <a href="http://munin-monitoring.org/">Munin</a> overview page for changes and displays links for any services with errors or warnings


The extentension is written in <a href='http://coffeescript.org/'>coffeescript</a> and utilizes <a href="http://backbonejs.org/">Backbone</a> for MVC tools, <a href="http://mustache.github.com/">Mustache</a> for micro-templating and <a href="http://requirejs.org/">RequireJS</a> for module loading.


This repository has been made available as both a reference on how to use the libraries listed above, as well as for users of the extension to possibly contribute.


In order to compile the <a href='http://coffeescript.org/'>coffeescript</a>  files into the scripts directory of the extension run the following:
```shell
coffee -w --output MuninMonitor/scripts --compile coffeescripts
```
