// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require underscore
//= require_tree .

$(function () {
	$('#members').on('click', 'th a, .pagination a' , function () {
    $.getScript(this.href);
    return false;
	});
	$("#members_search #search").keyup(function() {
		$.get($("#members_search").attr("action"), $("#members_search").serialize(), null, "script");
		return false;
	});
  	$('#members_search').submit(function () {
    	$.get(this.action, $(this).serialize(), null, 'script');
    	return false;
  	});
});

