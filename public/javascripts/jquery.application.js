// Place your application-specific jQuery JavaScript functions and classes here
$(function() {
	setTimeout(function() {
		$('.flash').effect('shake');
		$('.flash').hide('puff', {}, 'slow');
  }, 3500
  );

	function dialog_response(title, message) {
		$("<p>"+message+"</p>").dialog({
			title: title,
			modal: true
		});
  }

	$('.voteLink').click(function(event) {
		event.preventDefault();
		var span = $(this).parent();
		$(this).parent().html("<img src=\"/images/spinner.gif\" />");
		var url = $(this).attr("href");
                url = url.replace(/\?return_to=.*$/, '');
        if (url.substring(url.length - 5) == '.html') {
          url = url.substring(0, url.length - 5) + ".json";
        } else {
          url = url + ".json";
        }

		$.ajax({
			type: "POST",
			url: url,
			// Yet another chrome hack
			// chrome sends this xml if both contentType and data are not set
			// and as a result rails flips out
			contentType: 'application/json',
			data: "foo", // data has to be set to explicitly set the content type
			dataType: "json",
			success: function(data, status) {
				span.fadeOut("normal", function() {
				  span.html(data.msg).fadeIn("normal");
        });
      },
      error: function(xhr, status, errorThrown) {
      	var result = JSON.parse(xhr.responseText);
      	if (xhr.status == 401) {
      	  dialog_response(result.error, result.dialog);
          span.fadeOut("normal", function() {
            span.html(data.msg).fadeIn("normal");
          });
        }
      }
    });
  });
});


/* 
 * Post Story Functionality
 */
$(function() {
	var my_carousel = null;
	function set_carousel(carousel) {
		my_carousel = carousel;
  }

	$('#content_url').blur(function() {
		if ($(this).val() != '') {
      $(this).addClass('process');
      $('#content_title').addClass('process');
      $.post("/stories/parse_page", 
        {url: $(this).val()},
        function(data, status) {
          $('#content_title').val(data.title);
          if (data.description) {
            $('#content_caption').val(data.description);
          }
          if (data.images.length > 0) {
            // Hack to make this work in chrome..
            // can't use your typical itemLoadCallback
            $("#image_selector").jcarousel({
              initCallback: set_carousel
            });

            my_carousel.size(data.images.length);
            jQuery.each(data.images, function(i, url) {
              my_carousel.add(i+1, '<img src="'+url+'" width="75" height="75" />');
            });
            my_carousel.reload();

            $('.jcarousel-item:first').addClass('jcarousel-selected');
            $('#content_image_url').val(data.images[0]);
            $('.jcarousel-item').click(function() {
            	$('.jcarousel-item.jcarousel-selected').removeClass('jcarousel-selected');
            	$(this).addClass('jcarousel-selected');
            	$('#content_image_url').val($(this).find('img:first').attr('src'));
            });
            $('#images').show();
          }
          $('#content_url').removeClass('process');
          $('#content_title').removeClass('process');
        },
        "json");
    }
  });
});
