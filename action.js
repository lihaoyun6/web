$(document).ready(function(){var web = new Array();web['种子搜'] ={url:"http://www.zhongziso.com/list/{key}/1",encode:"utf8"};  

web['BT之家'] ={url:"http://www.cilihome.com/word/{key}.html",encode:"utf8"};  

web['屌丝磁力'] ={url:"http://www.diaosisou.com/list/{key}/1",encode:"utf8"};  

web['bt快搜'] ={url:"http://www.btkuaisou.cc/word/{key}.html",encode:"utf8"};    

web['磁力百科'] ={url:"http://www.cilibaike.net/word/{key}.html",encode:"utf8"};  

web['遨游搜'] ={url:"http://www.aoyoso.com/search/{key}_ctime_1.html",encode:"utf8"};  

web['必应磁链'] ={url:"http://cn.bing.com/search?q={key}磁力链接",encode:"utf8"}; 
                             
web['百度磁链'] ={url:"https://www.baidu.com/s?word={key}磁力链接",encode:"utf8"};

$(".submitbox .submit").click(function(){	var sweb=$(this).val();    var url=web[sweb]['url'];   var keyword=""; if(web[sweb]['encode']=='utf8'){keyword=encodeURI($("#s_text").val() );  }else if (web[sweb]['encode']=='gb2312' ) {	keyword= URLEncodeGB2312($("#s_text").val() ) ; } if(keyword==""){  if(window.confirm('关键词为空是否打开'+sweb+'首页')){ 	 window.open(url.match(/http[s]?:\/\/(.*?)([:\/]|$)/)[0] );} }else{ window.open(url.replace("{key}",keyword) ); }	});});
