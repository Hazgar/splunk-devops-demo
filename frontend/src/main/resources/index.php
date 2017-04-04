<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Risk Calculation Services</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="splunk-devops-demo frontend">
    <meta name="author" content="Stephane Lapie">

    <link href="../assets/css/bootstrap.css" rel="stylesheet">
    <link href="../assets/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="../assets/ico/favicon.png">
  
  </head>

  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Risk Calculation Services</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        </div><!--/.navbar-collapse -->
      </div>
    </nav>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>Welcome!</h1>
        <p>This platform is made for you to run Risk Calculations on demand. Fill-in simulation details below and enjoy a unique, fast and responsive service.</p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-6">
          <h2>Single Counterparty</h2>
          <p>Select a counterparty and a COB date on which to perform calculations:
          <p>
            <select class="form-control" name="ctrpId" id="ctrpId">
              <option selected disabled>Counterparty</option>
              <option value="AC">Accor SA</option>
              <option value="ACA">Credit Agricole</option>
              <option value="AI">Air Liquide SA</option>
              <option value="AIR">AIRBUS GROUP</option>
              <option value="ALO">Alstom SA</option>
              <option value="ALU">Alcatel-Lucent</option>
              <option value="BN">Danone</option>
              <option value="BNP">BNP Paribas</option>
              <option value="CA">Carrefour</option>
              <option value="CAP">Capgemini</option>
              <option value="CS">AXA SA</option>
              <option value="DG">Vinci</option>
              <option value="EDF">Electricit de France S.A.</option>
              <option value="EI">Essilor International SA</option>
              <option value="EN">Bouygues</option>
              <option value="FP">Total SA</option>
              <option value="FR">Valeo SA</option>
              <option value="GLE">Socit Gnrale</option>
              <option value="GSZ">GDF Suez</option>
              <option value="GTO">Gemalto</option>
              <option value="KER">Kering SA</option>
              <option value="LG">Lafarge SA</option>
              <option value="LR">Legrand SA</option>
              <option value="MC">LVMH Moet Hennessy Louis Vuitton SA</option>
              <option value="ML">Michelin</option>
              <option value="MT">ARCELORMITTAL REG</option>
              <option value="OR">L'Oreal SA</option>
              <option value="ORA">Orange</option>
              <option value="PUB">Publicis Groupe SA</option>
              <option value="RI">Pernod Ricard NV</option>
              <option value="RNO">Renault SA</option>
              <option value="SAF">Safran SA</option>
              <option value="SAN">Sanofi</option>
              <option value="SGO">Compagnie de Saint-Gobain</option>
              <option value="SOLB">SOLVAY</option>
              <option value="SU">Schneider Electric SE</option>
              <option value="TEC">Technip</option>
              <option value="UL">Unibail-Rodamco SE</option>
              <option value="VIE">Veolia Environnement SA</option>
              <option value="VIV">Vivendi SA</option>
              <option value="SPLK">Splunk Inc</option>
            </select>
          </p>
          <p>
            <input id="cobDate" type="date" class="form-control" placeholder="yyyy-mm-dd" />
          </p>
          <p><button class="btn btn-default" type="button" id="singleCalculation">Calculate &raquo;</button></p>
        </div>
        <div class="col-md-6">
          <h2>Batch Calculation</h2>
          <p>Select a COB date on which to start batch calculations:</p>
          <p>
            <input id="batchCobDate" type="date" class="form-control" placeholder="yyyy-mm-dd" />
          </p>
          <p><button class="btn btn-default" type="button" id="batchCalculation">Start Batch &raquo;</button></p>
       </div>
      </div>

      <div class="row" id="result">
      </div>

      <hr>

      <footer>
        <p>&copy; 2016 Splunk, Inc.</p>
      </footer>
    </div> <!-- /container -->
    <script src="../assets/js/jquery-1.8.3.js"></script>
    <script src="../assets/js/bootstrap-transition.js"></script>
    <script src="../assets/js/bootstrap-alert.js"></script>
    <script src="../assets/js/bootstrap-modal.js"></script>
    <script src="../assets/js/bootstrap-dropdown.js"></script>
    <script src="../assets/js/bootstrap-scrollspy.js"></script>
    <script src="../assets/js/bootstrap-tab.js"></script>
    <script src="../assets/js/bootstrap-tooltip.js"></script>
    <script src="../assets/js/bootstrap-popover.js"></script>
    <script src="../assets/js/bootstrap-button.js"></script>
    <script src="../assets/js/bootstrap-collapse.js"></script>
    <script src="../assets/js/bootstrap-carousel.js"></script>
    <script src="../assets/js/bootstrap-typeahead.js"></script>
    <script src="http://requirejs.org/docs/release/2.2.0/minified/require.js"></script>

    <script>
<?php
        $ipv4 = shell_exec("curl http://169.254.169.254/latest/meta-data/public-ipv4");
        $ipv4 = (empty($ipv4)) ? "localhost" : $ipv4;
?>
      var SPLUNK_SERVER = "54.246.234.235:8088";
      var SPLUNK_TOKEN = "D13C414F-6D66-4BC1-B936-2D6E277E37D1";
      var APP_SERVER  = "<?=$ipv4?>:8080";

      function genGUID()
      {
        function s4()
        {
          return Math.floor((1 + Math.random()) * 0x10000)
            .toString(16)
            .substring(1);
        }
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
      }

      function splunkLog(severity, message)
      {
        if (SPLUNK_SERVER == "")
            return ;
        var payload = {"event": {"message" : message, "severity" : severity}};
        $.ajax({
          url: 'http://'+SPLUNK_SERVER+'/services/collector/event',
          type: 'POST',
          async: false,
          dataType: 'text',
          beforeSend: function (request)
          {
            request.setRequestHeader("Authorization", 'Splunk '+SPLUNK_TOKEN);
          },
          data: JSON.stringify(payload)
        })
        .fail(function(data)
        {
          console.log("SplunkLog: FAILED to send payload: "+payload);
        });
      }

      $(document).ready(function()
      {
        // Single Calculation
        $('#singleCalculation').click( function()
        {
          var guid = genGUID();

          $.ajax({
            url: 'http://'+APP_SERVER+'/calculator/calculation/single/'+$('#cobDate').val()+'/'+$('#ctrpId').val(),
            type: 'GET',
            async: false,
            crossDomain: true,
            beforeSend: function (request)
            {
              $("#alerts").empty();
              request.setRequestHeader("Content-Type", 'application/xml');
              request.setRequestHeader("appTag", 'singleCalculation');
              splunkLog("INFO", {
                "action" : "singleCalculation",
                "step" : "start",
                "cob" : $('#cobDate').val(),
                "ctrpId" : $('#ctrpId').val(),
                "session" : guid
              });
            },
            data: ''
          })
          .fail(function(data)
          {
            //alert(data);
            var array = [];
            console.log(data);

            splunkLog("INFO", {
              "action" : "singleCalculation",
              "step" : "end",
              "status" : "failed",
              "cob" : $('#cobDate').val(),
              "ctrpId" : $('#ctrpId').val(),
              "session" : guid
            });

            array.push('<div class="alert alert-danger" style="margin-bottom: 0" role="alert">');
            array.push('No result: '+data.statusText);
            array.push("</div>");            
            $("#result").append(array.join(''));

          })
          .success(function(data)
          {
            console.log(data);
            $('#result').empty();

            splunkLog("INFO", {
              "action" : "singleCalculation",
              "step" : "end",
              "status" : "success",
              "cob" : $('#cobDate').val(),
              "ctrpId" : $('#ctrpId').val(),
              "calculationId" : data.id,
              "session" : guid
            });

            var array = [];

            array.push('<hr />');
            array.push('<h2>Counterparty: '+data.counterparty.name+'</h2>');
            array.push('<h4>Number of deals: '+data.counterparty.deals+'</h4>');
            array.push('<table class="table table-striped">');
            array.push('<thead><tr><th>Metric</th><th>Value</th></tr></thead>');
            array.push('<tbody>');
            array.push('<tr><td>cosinus</td><td>'+data.cos+'</td></tr>');
            array.push('<tr><td>sinus</td><td>'+data.sin+'</td></tr>');
            array.push('<tr><td>tangent</td><td>'+data.tan+'</td></tr>');
            array.push('<tr><td>square root</td><td>'+data.sqrt+'</td></tr>');
            array.push('<tr><td>power</td><td>'+data.pow+'</td></tr>');
            array.push('<tr><td>log10</td><td>'+data.log10+'</td></tr>');
            array.push('<tr><td>factorial</td><td>'+data.factorial+'</td></tr>');
            array.push('<tr><td>prime number</td><td>'+data.prime+'</td></tr>');
            array.push('</tbody>');
            array.push('</table>');
            $('#result').append(array.join(' '));
            
          });
        }); // Single Calculation

        // Batch Calculation
        $('#batchCalculation').click( function()
        {
          $.ajax({
            url: 'http://54.194.101.160:8080/calculator/calculation/batch/'+$('#batchCobDate').val(),
            type: 'GET',
            async: false,
            crossDomain: true,
            beforeSend: function (request)
            {
              $("#alerts").empty();
              request.setRequestHeader("Content-Type", 'application/xml');
              request.setRequestHeader("appTag", 'batchCalculation');
            },
            data: ''
          })
          .fail(function(data)
          {
            //alert(data);
            var array = [];
            console.log(data);

            array.push('<div class="alert alert-danger" style="margin-bottom: 0" role="alert">');
            array.push('No result: '+data.statusText);
            array.push("</div>");            
            $("#result").append(array.join(''));
          })
          .success(function(data)
          {
            console.log(data);
            $('#result').empty();

            data.results.forEach(function (result, idx)
            {
              var array = [];

              array.push('<hr />');
              array.push('<h2>Counterparty: '+result.counterparty.name+'</h2>');
              array.push('<h4>Number of deals: '+result.counterparty.deals+'</h4>');
              array.push('<table class="table table-striped">');
              array.push('<thead><tr><th>Metric</th><th>Value</th></tr></thead>');
              array.push('<tbody>');
              array.push('<tr><td>cosinus</td><td>'+result.cos+'</td></tr>');
              array.push('<tr><td>sinus</td><td>'+result.sin+'</td></tr>');
              array.push('<tr><td>tangent</td><td>'+result.tan+'</td></tr>');
              array.push('<tr><td>square root</td><td>'+result.sqrt+'</td></tr>');
              array.push('<tr><td>power</td><td>'+result.pow+'</td></tr>');
              array.push('<tr><td>log10</td><td>'+result.log10+'</td></tr>');
              array.push('<tr><td>factorial</td><td>'+result.factorial+'</td></tr>');
              array.push('<tr><td>prime number</td><td>'+result.prime+'</td></tr>');
              array.push('</tbody>');
              array.push('</table>');
              $('#result').append(array.join(' '));
            });
          });
        }); // Batch Calculation
      });
    </script>
  </body>
</html>



