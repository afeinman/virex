console.log "Hello world"

updateRE = (e) ->
  console.log "Got click"
  e.preventDefault()

  test_string = $('#test_string').val().replace(/\r?\n/g, "%0A")
  regex = $('#regex').val()

  if regex? and test_string?
    # "Disable" inputs
    $('#test_string').css('color', '#888')
    $('#regex').css('color', '#888')
    $('#flags').css('color', '#888')

    $.ajax("http://virex.org/regex?text="+test_string+"&pattern="+regex)
      .done (data) ->
        $('#results').html(data)

        # "Re-enable" inputs
        $('#test_string').css('color', '#000')
        $('#regex').css('color', '#000')
        $('#flags').css('color', '#000')
  else
    $('#results').html('Please enter a non-blank string and regular expression, or this is rather boring.')

$('#update_regex').click updateRE
$('#update_regex').click -> console.log 'hi'



### Alex's old code

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


###

console.log "done loading"
