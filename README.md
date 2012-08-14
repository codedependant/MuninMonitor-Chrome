Munin Monitor polls your Munin overview page for changes and displays links for any services with errors or warnings

The extentension is written in coffeescript and utilizes Backbone, Mustache and RequireJS.


In order to compile the coffeescript files into the scripts directory of the extension run the following:
coffee -w --output MuninMonitor/scripts --compile coffeescripts

