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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

/* Tooltips */
$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});
/* Accordion */
$(document).ready(function(){
  $(".panel-collapse").on("hide.bs.collapse", function(){
    gs = this.previousElementSibling.getElementsByClassName("glyphicon-minus");
	if (gs.length>0) gs[0].className = gs[0].className.replace("minus", "plus");  
  });
  $(".panel-collapse").on("show.bs.collapse", function(){
    gs = this.previousElementSibling.getElementsByClassName("glyphicon-plus");
	if (gs.length>0) gs[0].className = gs[0].className.replace("plus", "minus");  
  });
});