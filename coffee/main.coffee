$(document).on "submit", "#search-form", (e) ->
  e.preventDefault()

  duns = $(this).find("input").val()
  return if !duns

  $("dd").removeClass('loaded')

  $(".results").fadeIn(300)

  dunsUrl = "http://rfpez-apis.presidentialinnovationfellows.org/exclusions?duns=#{duns}"

  $.getJSON dunsUrl, (r) ->

    dd = $("[data-epls]")
    dd.find(".result").attr('href', dunsUrl).text(if r.results.length then "Yes" else "No")
    dd.addClass("loaded")

  dsbsUrl = "http://rfpez-apis.presidentialinnovationfellows.org/bizs?duns=#{duns}"

  $.getJSON dsbsUrl, (r) ->

    result = r.results?[0]

    dd = $("[data-dsbs]")
    dd.find(".result").find("a.yesno").attr('href', dsbsUrl).text(if result then "Yes" else "No")

    if result
      $("#dsbs-table").show()
      $("#dsbs-table td[data-key=#{key}]").text(result[key]) for key of result

    else
      $("#dsbs-table").hide()

    dd.addClass("loaded")

