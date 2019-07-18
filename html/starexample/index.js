$('.starRev span').click(function(){
  $(this).parent().children('span').removeClass('on');
  $(this).addClass('on').prevAll('span').addClass('on');
  
  $(this).parent().parent().prop('value', $(this).parent().parent().text( $(this).addClass('on').prevAll('span').length+1))
  return false;
});