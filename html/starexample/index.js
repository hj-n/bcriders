$('.starRev span').click(function(){
  $(this).parent().children('span').removeClass('on');
  $(this).addClass('on').prevAll('span').addClass('on');
  
  $(this).parent().children('b').html( $(this).addClass('on').prevAll('span').length+1);
  return false;
});