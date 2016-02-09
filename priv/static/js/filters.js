var to_tag = function(str) {
  return str.trim().toLowerCase()
}

var noVisibleCandidates = function() {
  return $(".candidate:visible").length == 0
}

var showCandidate = function(candidate) {
  $(candidate).parent().removeClass("hidden-lg")
  $(candidate).show()
}

var hideCandidate = function(candidate) {
  $(candidate).parent().addClass("hidden-lg")
}

var insertCandidates = function(candidates) {
  $.map($(".candidate:visible"), hideCandidate)
  $.map(candidates, showCandidate)
}

var resetCandidates = function() {
  $.map($(".candidate"), hideCandidate)
  tags = $.map($(".btn-toolbar .btn-selected"), function(btn) { return to_tag($(btn).text()) })

  $.each(tags, function(i, tag) {
    $.map(candidatesWithTag(tag), showCandidate)
  });
}

var candidateYears = function(candidate) {
  return parseInt($(candidate).find(".years-at-current-company").text())
}

var candidatesWithTag = function (tag) {
  css = ".experience-" + tag;   // .experience-mobile
  candidates = noVisibleCandidates() ? $(".candidate") : $(".candidate:visible")

  return candidates.filter(function() { return $(this).find(css).length > 0})
}

var toggleButton = function() {
  var button = this
  var $button = $(button)
  var markActive = !$button.hasClass("btn-selected")
  var tag = to_tag($button.text())
  var candidates = candidatesWithTag(tag)

  if (markActive) {
    button.className = "btn btn-selected"
    insertCandidates(candidates)
  } else {
    button.className = "btn btn-tag"
    resetCandidates()
  }
}

var updateSliderCandidates = function(years) {

  if ($(".btn-toolbar .btn-selected").length == 0) {
    candidates = $(".candidate")
  } else {
    resetCandidates()
    candidates = $(".candidate:visible")
  }

  $.each(candidates, function(i, candidate) {
    if (candidateYears(candidate) >= years) {
      showCandidate(candidate)
    } else {
      hideCandidate(candidate)
    }
  })
};

$(function(){
  $('.btn-toolbar button').on('click', toggleButton);

  var slider = $('#years-slider').slider();
  slider.on('change', function(e) { updateSliderCandidates(e.value.newValue) })
})