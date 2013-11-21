parseRE = ->
  re = $("#re").html()
  re = re.replace /&nbsp;/g, ' '
  flags = $("#flags").text() ? ""
  string = $("#string").html() ? ""
  string = string.replace /&nbsp;/g, ' '
  string = string.replace /\<div\>(\<br\>)?/g, '\n'
  string = string.replace /\<\/div\>/g,''
  console.log ">#{re}< / >#{flags}< on |#{string}|"

  try
    splits = string.split new RegExp "(#{re})",flags
    classes = ["inter", "match"]
    for s, idx in splits
      s = '#' unless (idx % 2 is 1) or s? or (not s.match /^\s*$/)
      splits[idx] = "<span class='#{classes[idx % 2]}'>#{s}</span>"
    result = splits.join('')
    result = result.replace ' ','&nbsp;'
#    result = "<div>" + splits.join('') + "</div>"
    result = result.replace /\n/, '<div>'
    $("#results").html(result)

  catch e
    $("#results").html("There's something fishy in your regexp:<br/>"+e)

update_re = ->
  test_string = $('#string').val().replace(/\r?\n/g, "%0A")
  regex = $("#re").val()

  return unless regex? and test_string?
  $('#match_result').css('background-color', '#EBEBEB');
  $('#match_groups').css('background-color', '#EBEBEB');

  $.ajax("/regex?text="+test_string+"&pattern="+regex)
    .done (data) ->
      ('#results').html(data)
      $('#match_result').css('background-color', 'white')
      $('#match_groups').css('background-color', 'white')


$("#go").click ->
  console.log "click!"
  $('#go').css('animation-name', 'godown')
# update_re()
#  setTimeout parseRE, 200

#parseRE()
