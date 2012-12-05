// Generated by CoffeeScript 1.3.3
(function() {

  $(document).on("submit", "#search-form", function(e) {
    var dsbsUrl, duns, dunsUrl;
    e.preventDefault();
    duns = $(this).find("input").val();
    if (!duns) {
      return;
    }
    $("dd").removeClass('loaded');
    $(".results").fadeIn(300);
    dunsUrl = "http://rfpez-apis.presidentialinnovationfellows.org/exclusions?duns=" + duns;
    $.getJSON(dunsUrl, function(r) {
      var dd;
      dd = $("[data-epls]");
      dd.find(".result").attr('href', dunsUrl).text(r.results.length ? "Yes" : "No");
      return dd.addClass("loaded");
    });
    dsbsUrl = "http://rfpez-apis.presidentialinnovationfellows.org/bizs?duns=" + duns;
    return $.getJSON(dsbsUrl, function(r) {
      var dd, key, result, _ref;
      result = (_ref = r.results) != null ? _ref[0] : void 0;
      dd = $("[data-dsbs]");
      dd.find(".result").find("a.yesno").attr('href', dsbsUrl).text(result ? "Yes" : "No");
      if (result) {
        $("#dsbs-table").show();
        for (key in result) {
          $("#dsbs-table td[data-key=" + key + "]").text(result[key]);
        }
      } else {
        $("#dsbs-table").hide();
      }
      return dd.addClass("loaded");
    });
  });

}).call(this);