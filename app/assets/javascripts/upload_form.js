
document.addEventListener("turbolinks:load", function() {

  var init = function() {
    $("#final_btn").css("display", "none");
    $("#exploit_save").css("display", "inline-block");
    $("#exploit_reset").css("display", "none");
    $("#loading").css("display", "none");
  };

  var is_src = function() {
    return document.getElementById('source_code_check').checked;
  };

  var is_angr = function() {
    return document.getElementById('angr_check').checked;
  };

  var is_afl = function() {
    return document.getElementById('afl_check').checked;
  };

  var is_network = function() {
    return document.getElementById('network_fuzz_check').checked;
  };

  var is_metasploits = function() {
    return document.getElementById('metasploits_check').checked;
  };

  var final_btn_on = function() {
    $("#final_btn").css("display", "inline-block");
    $("#exploit_save").css("display", "none");
    $("#exploit_reset").css("display", "inline-block");
    $("#source_code_check").attr('disabled', true);
    $("#angr_check").attr('disabled', true);
    $("#afl_check").attr('disabled', true);
    $("#network_fuzz_check").attr('disabled', true);
    $("#metasploits_check").attr('disabled', true);
  }

  var exploit_reset = function() {
    $("#final_btn").css("display", "none");
    $("#exploit_save").css("display", "inline-block");
    $("#exploit_reset").css("display", "none");
    $("#source_code_check").attr('disabled', false);
    $("#angr_check").attr('disabled', false);
    $("#afl_check").attr('disabled', false);
    $("#network_fuzz_check").attr('disabled', false);
    $("#metasploits_check").attr('disabled', false);
  }


  init();

  $("#exploit_reset").on('click', function() {
    exploit_reset();
  });


  $("#final_btn").on('click', function() {
    var $this = $(this);
    $this.fadeOut("fast", function(){$("#loading").fadeIn("slow", function(){})});
  });

  $('#exploit_save').on('click', function() {
    final_btn_on();

    var a = document.getElementById("target_attachment");
    var fullPath = a.value;
    var filename = fullPath.replace(/^.*[\\\/]/, '');
    console.log(filename);
    document.getElementById('target_name').value = filename.replace(' ','_');

    if (is_src()) {
      document.getElementById('target_source_code').value = -1;
    }
    else {
      document.getElementById('target_source_code').value = -2;
    }

    if (is_angr()) {
      document.getElementById('target_angr').value = -1;
    }
    else {
      document.getElementById('target_angr').value = -2;
    }

    if (is_afl()) {
      document.getElementById('target_afl').value = -1;
    }
    else {
      document.getElementById('target_afl').value = -2;
    }

    if (is_network()) {
      document.getElementById('target_network_fuzz').value = -1;
    }
    else {
      document.getElementById('target_network_fuzz').value = -2;
    }

    if (is_metasploits()) {
      document.getElementById('target_metasploits').value = -1;
    }
    else {
      document.getElementById('target_metasploits').value = -2;
    }
  });



});
