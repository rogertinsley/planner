# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".table > tbody > tr").on "click", ->
    owner = $(this).data("owner")
    repo = $(this).data("repo")
    document.location = "/" + owner + "/" + repo + "/backlog"
    return false;

$(document).ready(ready)
$(document).on "page:load", ready
