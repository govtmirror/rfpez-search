fpdsTemplate = _.template """
  <li>
    <dl>
      <dt>Contract ID</dt>
      <dd><%= contract_id %></dd>

      <dt>Date Signed</dt>
      <dd><%= date_signed %></dd>

      <dt>Office Name</dt>
      <dd><%= contracting_office_name %></dt>

      <dt>Agency</dt>
      <dd><%= contracting_agency %></dd>

      <dt>Action Obligation</dt>
      <dd><%= action_obligation %></dd>
    </dl>
  </li>
"""

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

  fpdsUrl = "http://rfpez-apis.presidentialinnovationfellows.org/awards?q=#{duns}&per_page=100000"

  $.getJSON fpdsUrl, (r) ->

    hasResults = r.results?[0]

    dd = $("[data-fpds]")
    dd.find(".result").find("a.yesno").attr('href', fpdsUrl).text(if hasResults then "Yes" else "No")

    if hasResults
      $("#fpds-list").show()

      for result in r.results
        $("#fpds-list").html('').append(fpdsTemplate(result))

    else
      $("#fpds-list").html('').hide()

    dd.addClass("loaded")

