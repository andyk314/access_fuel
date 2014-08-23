jQuery ->
  if $('.pagination').length
    alert('hi')
    $(document).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        alert('hi')
        console.log('test')
        $('.pagination').text("Loading more events....")
        $.getScript(url)
    $(window).scroll()
