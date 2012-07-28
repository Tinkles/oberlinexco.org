# we must use root to create global functions
root = exports ? this

# removes the fields div surrounding link
#
# checkout RailsCast 197
root.remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val("1")
  $(link).closest(".fields").hide()

# adds a fields div before link
#
# checkout RailsCast 197
root.add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
