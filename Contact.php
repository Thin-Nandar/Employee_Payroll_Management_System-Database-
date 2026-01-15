<section id="content">
  <div class="container">
    <div class="row">
      <!-- Contact Form -->
      <div class="col-md-6">
        <form name="sentMessage" id="contactForm" novalidate>
          <h3>Contact Me</h3>

          <div class="control-group">
            <div class="controls">
              <input type="text" class="form-control" 
                placeholder="Full Name" id="name" required
                data-validation-required-message="Please enter your name" />
              <p class="help-block"></p>
            </div>
          </div>   

          <div class="control-group">
            <div class="controls">
              <input type="email" class="form-control" placeholder="Email" 
                id="email" required
                data-validation-required-message="Please enter your email" />
            </div>
          </div>   

          <div class="control-group">
            <div class="controls">
              <textarea rows="10" cols="100" class="form-control" 
                placeholder="Message" id="message" required
                data-validation-required-message="Please enter your message" 
                minlength="5" 
                data-validation-minlength-message="Min 5 characters" 
                maxlength="999" style="resize:none"></textarea>
            </div>
          </div>      

          <div id="success"></div> <!-- For success/fail messages -->
          <button type="button" class="btn btn-primary pull-right">Send</button><br />
        </form>
      </div>

      <!-- Google Map -->
      <div class="col-md-6">
        <div id="gmap_canvas" style="height:500px;width:600px;"></div>
      </div>
    </div>
  </div>
</section>

<!-- Google Maps Script -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY"></script>
<script type="text/javascript">
  function init_map() {
    var myOptions = {
      zoom: 14,
      center: new google.maps.LatLng(20.7892, 97.0376), // Taunggyi coordinates
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions);

    var marker = new google.maps.Marker({
      map: map,
      position: new google.maps.LatLng(20.7892, 97.0376)
    });

    var infowindow = new google.maps.InfoWindow({
      content: "<b>Taunggyi</b><br/>Shan State<br/>Myanmar"
    });

    google.maps.event.addListener(marker, "click", function () {
      infowindow.open(map, marker);
    });

    infowindow.open(map, marker);
  }

  google.maps.event.addDomListener(window, 'load', init_map);
</script>