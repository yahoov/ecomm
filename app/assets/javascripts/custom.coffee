click_mk_pay = ->
  $('div.order').on 'click', 'a#mk_pay', (e) ->
    setTimeout ->
      $('#md_payment').modal('hide')
      document.getElementById('alias_mk_pay').click()
    , 3000

c_scrolling = ->
  scrollEnabled = true
  $(document).scroll ->
    dt = $('.products_grid').attr('data')
    divHeight = $('body').height() - $('.products_grid').height() - 10
    if window.fetchMore && scrollEnabled && ($(document).scrollTop() > divHeight)
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


$(document).ready ->
  setTimeout ->
    $('.flash_messages').fadeOut(500)
  , 2000

  click_mk_pay()
  if $('.products_grid').length > 0
    c_scrolling()

# document.addEventListener "turbolinks:load", ->
#   click_mk_pay()
#   if $('.products_grid').length > 0
#     c_scrolling()
