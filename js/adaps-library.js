/**
 * ADAPS Library
 * Created by Ralph Rose
 * Designed to support the Academic Document Annotation
 * and Presentation System (ADAPS)
 */

"use strict";

/*
 * The following function is supposed to take a word and look up its
 * first definition in the Pearson dictionary using their API. However,
 * there's a variable scoping problem and the return value is always
 * 'definition not found'.
 */
function getPearsonDefinition($word) {
	var $baseURL = 'http://api.pearson.com/v2/dictionaries/entries?headword=';
	var $searchURL = $baseURL + $word;
	var $result = "definition not found";
	$.getJSON($searchURL, function(data) {
		if (data.results[0].senses[0].definition !== undefined) {
			//alert(data.results[0].senses[0].definition);
			$result = data.results[0].senses[0].definition;
		}
	});
	//alert($result);
	return $result;
}

function todaydate(){
    var today_date= new Date();
    var myyear=today_date.getYear();
    var mymonth=today_date.getMonth()+1;
    var mytoday=today_date.getDate();
    document.write(myyear+"/"+mymonth+"/"+mytoday);
};

$(document).ready(function(){
    $(".paragraph").hover(function(){
        $(this).addClass("paragraph-hover");
        }, function(){
        $(this).removeClass("paragraph-hover");
    });
});

$(document).ready(function(){
    $(".sentence").hover(function(){
        $(this).addClass("sentence-hover");
        }, function(){
        $(this).removeClass("sentence-hover");
    });
});

$(document).ready(function(){
    $("#awl-button").click(function(){
    	if ($(this).text() === "AWL on") {
    		$(".awl").addClass("awl-highlight");
    		$(this).addClass("awl-highlight");
    		$(this).text("AWL off");
    	} else {
    		$(".awl").removeClass("awl-highlight");
    		$(this).removeClass("awl-highlight");
    		$(this).text("AWL on");
    	}
    });
});

$(document).ready(function(){
    $("#gsl1-button").click(function(){
    	if ($(this).text() === "GSL1 on") {
    		$(".gsl1").addClass("gsl1-highlight");
    		$(this).addClass("gsl1-highlight");
    		$(this).text("GSL1 off");
    	} else {
    		$(".gsl1").removeClass("gsl1-highlight");
    		$(this).removeClass("gsl1-highlight");
    		$(this).text("GSL1 on");
    	}
    });
});

$(document).ready(function(){
    $("#gsl2-button").click(function(){
    	if ($(this).text() === "GSL2 on") {
    		$(".gsl2").addClass("gsl2-highlight");
    		$(this).addClass("gsl2-highlight");
    		$(this).text("GSL2 off");
    	} else {
    		$(".gsl2").removeClass("gsl2-highlight");
    		$(this).removeClass("gsl2-highlight");
    		$(this).text("GSL2 on");
    	}
    });
});

$(document).ready(function(){
    $("#abbr-button").click(function(){
    	if ($(this).text() === "Abbreviations on") {
    		$(".abbreviation").addClass("abbr-highlight");
    		$(this).addClass("abbr-highlight");
    		$(this).text("Abbreviations off");
    	} else {
    		$(".abbreviation").removeClass("abbr-highlight");
    		$(this).removeClass("abbr-highlight");
    		$(this).text("Abbreviations on");
    	}
    });
});

$(document).ready(function(){
    $("#term-button").click(function(){
    	if ($(this).text() === "Technical terms on") {
    		$(".technical-term").addClass("term-highlight");
    		$(this).addClass("term-highlight");
    		$(this).text("Technical terms off");
    	} else {
    		$(".technical-term").removeClass("term-highlight");
    		$(this).removeClass("term-highlight");
    		$(this).text("Technical terms on");
    	}
    });
});

$(document).ready(function(){
    $("#connector-button").click(function(){
    	if ($(this).text() === "Connectors on") {
    		$(".connector").addClass("connector-highlight");
    		$(this).addClass("connector-highlight");
    		$(this).text("Connectors off");
    	} else {
    		$(".connector").removeClass("connector-highlight");
    		$(this).removeClass("connector-highlight");
    		$(this).text("Connectors on");
    	}
    });
});

$(document).ready(function(){
    $("#topic-button").click(function(){
    	if ($(this).text() === "Topic sentences on") {
    		$(".topic").addClass("topic-highlight");
    		$(this).addClass("topic-highlight");
    		$(this).text("Topic sentences off");
    	} else {
    		$(".topic").removeClass("topic-highlight");
    		$(this).removeClass("topic-highlight");
    		$(this).text("Topic sentences on");
    	}
    });
});

$(document).ready(function(){
    $("#all-button").click(function(){
    	if ($(this).text() === "All on") {
    		$(".awl").addClass("awl-highlight");
    		$("#awl-button").addClass("awl-highlight");
    		$("#awl-button").text("AWL off");
    		$(".gsl1").addClass("gsl1-highlight");
    		$("#gsl1-button").addClass("gsl1-highlight");
    		$("#gsl1-button").text("GSL1 off");
    		$(".gsl2").addClass("gsl2-highlight");
    		$("#gsl2-button").addClass("gsl2-highlight");
    		$("#gsl2-button").text("GSL2 off");
    		$(".abbreviation").addClass("abbr-highlight");
    		$("#abbr-button").addClass("abbr-highlight");
    		$("#abbr-button").text("Abbreviations off");
    		$(".technical-term").addClass("term-highlight");
    		$("#term-button").addClass("term-highlight");
    		$("#term-button").text("Technical terms off");
    		$(".connector").addClass("connector-highlight");
    		$("#connector-button").addClass("connector-highlight");
    		$("#connector-button").text("Connectors off");
    		$(".topic").addClass("topic-highlight");
    		$("#topic-button").addClass("topic-highlight");
    		$("#topic-button").text("Topic sentences off");
    		$(this).text("All off");
    	} else {
    		$(".awl").removeClass("awl-highlight");
    		$("#awl-button").removeClass("awl-highlight");
    		$("#awl-button").text("AWL on");
    		$(".gsl1").removeClass("gsl1-highlight");
    		$("#gsl1-button").removeClass("gsl1-highlight");
    		$("#gsl1-button").text("GSL1 on");
    		$(".gsl2").removeClass("gsl2-highlight");
    		$("#gsl2-button").removeClass("gsl2-highlight");
    		$("#gsl2-button").text("GSL2 on");
    		$(".abbreviation").removeClass("abbr-highlight");
    		$("#abbr-button").removeClass("abbr-highlight");
    		$("#abbr-button").text("Abbreviations on");
    		$(".technical-term").removeClass("term-highlight");
    		$("#term-button").removeClass("term-highlight");
    		$("#term-button").text("Technical terms on");
    		$(".connector").removeClass("connector-highlight");
    		$("#connector-button").removeClass("connector-highlight");
    		$("#connector-button").text("Connectors on");
    		$(".topic").removeClass("topic-highlight");
    		$("#topic-button").removeClass("topic-highlight");
    		$("#topic-button").text("Topic sentences on");
    		$(this).text("All on");
    	}
    });
});

$(document).ready(function(){
    $(".awl").mouseenter(function(){
    	if ($(this).css("background-color") === "rgb(240, 230, 140)") {
    		var popupID = "#" + $(this).attr("id") + "-popup";
    		$(this).html("<a href='" + popupID + "' data-rel='popup'>" + $(this).attr("content") + "</a>");
//    		$(this).html("<a href='#" + $(this).attr("id") + ".popup' data-rel='popup' class='ui-btn ui-btn-inline ui-corner-all'>" + $(this).attr("content") + "</a>");
//    		var definition = getPearsonDefinition($(this).attr("content"));
    		var $baseURL = 'http://api.pearson.com/v2/dictionaries/entries?headword=';
    		var $searchURL = $baseURL + $(this).attr("content");
    		$.getJSON($searchURL, function(data) {
       			$(popupID).css("background-color", "Khaki");
    			if (data.results[0].senses[0].definition !== undefined) {
    				//alert(data.results[0].senses[0].definition);
    	   			$(popupID).html("<p>" + data.results[0].senses[0].definition + "</p>");
    			} else {
    	   			$(popupID).html("<p>(definition not found)</p>");
    			}
    		});
    	} else {
    	}
    });
});

$(document).ready(function(){
    $(".awl").mouseleave(function(){
    	if ($(this).css("background-color") === "rgb(240, 230, 140)") {
    		$(this).text($(this).attr("content"));
    	} else {
    	}
    });
});
