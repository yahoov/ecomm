$(document).ready ->
  setTimeout ->
    $('.flash_messages').fadeOut(500)
  , 2000

  if $('.products_grid').length > 0
    scrollEnabled = true
    $(document).scroll ->
      dt = $('.products_grid').attr('data')
      divHeight = $('body').height() - $('.products_grid').height() - 50
      if window.fetchMore && scrollEnabled && ($('body').scrollTop() > divHeight)
        scrollEnabled = false
        $('#loading_txt').show()
        $.ajax
          type: "GET"
          dataType: "script"
          url: "/fetch_products"
          data:
            last_dt: dt
          success: ->
            scrollEnabled = true
            $('#loading_txt').hide()
