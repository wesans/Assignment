<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <link rel=stylesheet type=text/css href=CtrlCafe.css>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
   <link rel="shortcut icon" href="#">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CtrlCafe</title>
</head>

<body>
    <table>
        <tr>
            <td valign=top>
                <table class='bound' style="background-color: #e9ecef;">
                   
                    <caption>메뉴목록</caption>
                    <tr>
                        <td colspan=2 align=right>
                            <button id=btnMenu class="w-btn-outline w-btn-gray-outline">메뉴관리</button>
                        </td>
                    </tr>
               
            <tr>
                <td colspan=2 align=center>
                    <select id=selMenu size=14></select>
                </td>
            </tr>
            <tr>
                    <td>메뉴명</td>
                    <td><input type=text id=menuname readonly></td>
                </tr>
                <tr>
                    <td>수량</td>
                    <td><input type=number id=count min=1>잔</td>
                </tr>
                <tr>
                    <td>금액</td>
                    <td><input type=number id=menuprice readonly>원</td>
                </tr>
                <tr>
                    <td><button id=btnReset class="w-btn-outline w-btn-gray-outline">비우기</button></td>
                   
                  
                        
                    <td align="right"><button id=btnAdd class="w-btn-outline w-btn-gray-outline">메뉴추가</button></td>
                </tr>
                </table>
            </td>
            <td valign=top>
                <table class='bound' style="background-color: #adb5bd;" >
                    <caption>주문목록</caption>
                    <tr>
                        <td colspan=2 align=center>
                            <select id=selOrder size=16></select>
                        </td>
                    </tr>
                    <tr>
                        <td>총액</td>
                        <td><input type=number id=total></td>
                    </tr>
                    <tr>
                        <td>모바일</td>
                        <td><input type=phone id=mobile></td>
                    </tr>
                    <tr>
                        <td colspan=2 >&nbsp;</td>
                    </tr>
                    <tr>
                        <td><button id=btnCancel class="w-btn-outline w-btn-gray-outline">주문취소</button></td>
                        <td align=right><button id=btnDone class="w-btn-outline w-btn-gray-outline">주문완료</button></td>
                    </tr>
                </table>
            </td>
            <td  valign=top>
                <table class='bound' style="background-color: #343a40;">
                    <caption>판매내역</caption>
                    
                    <tr>
                        <td align=center>
                            <select id=selSales size=20></select>
                        </td>
                    </tr>
                    <tr>
                        <td align=right><button id=btnSummary class="w-btn-outline w-btn-gray-outline">Summary</button></td>
                    </tr>
                </table>
            </td>
        </tr>
        </table>
        <div id=dlgMenu style='display:none;' title="메뉴관리">
            <table>
                <tr>
                    <td>
                        <select id=selMenu1 size=10></select>
                    </td>
                    <td>
                        <table>
                        <tr>
                            <td>코드</td><td><input type=text id=code style='width:120px'></td>
                        </tr>
                        <tr>
                            <td>메뉴명</td><td><input type=text id=name style='width:120px'></td>
                        </tr>
                        <tr>
                            <td>단가(가격)</td><td><input type=number id=price min=500 step=500 style='width:50px'>원</td>
                        </tr>
                        <tr>
                               <td><button id=btnReset1>비우기</button></td>
                                <td><button id=btnGo>작성완료</button></td>
                        </tr>
                        </table>
                    </td>
                </tr>    
                </table>
        </div>
        <div id=Sales_menu style='display:none;' title="메뉴별 매출금액">
        <table>
        <tr>
           <td>
           <select id=selSales size=10></select>
           </td>
           </tr>
        </table>
        </div>
</body>
<script src='https://code.jquery.com/jquery-3.5.0.js'></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>

   $(document)
   .ready(function() {
      Menu();
      $('#total').val();
      return false;
   })
   
   .on('change','#selMenu',function(){
       str=$('#selMenu option:selected').text();
       let ar=str.split(' ');
       $('#menuname').val(ar[1]);
       $('#count').val(1);
       $('#menuprice').val(ar[2]);
   })
   
   .on('change','#count',function() {
      str=$('#selMenu option:selected').text();
      let ar=str.split(' ');
      cnt=$('#count').val();
      $('#menuprice').val(ar[2]*cnt);
   })
   
   .on('click','#btnReset',function() {
      $('#menuname, #menuprice, #count').val('')
   })
   
    .on('click','#btnReset1',function() {
      $('#code, #name, #price').val('')
   })
   
   .on('click','#btnAdd',function(){
        Addmenuprice=$('#menuprice').val();
        strOrder='<option>'+$('#menuname').val()+' x'+$('#count').val()+' '+$('#menuprice').val()+'</option>';
        $('#selOrder,#selOrder1').append(strOrder);
        Addmenuprice=parseInt(Addmenuprice);
        nTotal+=Addmenuprice;
        $("#total").val(nTotal);
    })
    
    .on('click','#btnCancel',function() {
       $('#selOrder').empty();
       $('#total').val('');
       $('#mobile').empty();
    })
    
    .on('click','#btnDone',function() {
       $('#selOrder option').each(function() {
          if($('#total').val() == 0) {
             alert('값을 입력하세요..');
             return false;
          } else {
             str='<option>'+'['+$('#mobile').val()+']'+' '+$(this).text()+'</option>';
             $('#selSales').append(str);
          }
       })
       $('#selOrder').empty();
       $('#total').val(0);
       $('#mobile').val(null);
       $('total').val(nTotal);
    })
     
     // ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 메뉴관리(다이얼로그)
     
   .on('click','#btnMenu',function() {
      $('#dlgMenu').dialog({
         width:560,
         open:function() {
         $.get('menuSelect', {}, function(txt) {
                if (txt == "")
                   return false;
                let rec = txt.split(';');
                for (i = 0; i < rec.length; i++) {  /*위에서 구한 값들을 여기서 처리한다..각셀에 집어넣는다는 뜻*/
                   let field = rec[i].split(',');
                   let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
                   $('#selMenu1').append(html);
                   console.log(html);
                }
             })
          },
          close:function() {
             $('#selMenu').empty();
             $('#selMenu1').empty();
             Menu();
         }
         });
      })
      
      .on('change','#selMenu1',function() {
            let strr=$('#selMenu1 option:selected').text();
            let arr=strr.split(' ');
            $('#code').val(arr[0]);
            $('#name').val(arr[1]);
            $('#price').val(arr[2]);

        })
        
        .on('click','#btnGo',function() {
         let operation = '';
         if ($('#code').val() == '') {
            if ($('#name').val() != '' && $('#price').val() != '') {
               operation = "menuInsert";   //insert
            } else {
               alert('입력값이 모두 채워지지 않았습니다.');
               return false;
            }
            } else {
               if ($('#code').val() != '' && $('#name').val() != '' && $('#price').val() != '') {
                  operation = "menuUpdate";   //update
               } else {
                  operation = "menuDelete";   //delete
               }
            }   
            $.get(operation, {code : $('#code').val(),name : $('#name').val(),price : $('#price').val()}, function(txt) {
               $('#code,#name,#price').val("");
               Menu();
               Menu1();
            }, 'text');
            return false;
           })
   
   function Menu(){
      $('#selMenu').empty();
      $.get('menuSelect',{},function(txt){
         if(txt ==""){
            return false;
         }
         let rec=txt.split(';');
         for (i=0; i < rec.length; i++){
            let field = rec[i].split(',');
            let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
            $('#selMenu').append(html);
            console.log(html);
         }
      })
   }
   
   function Menu1(){
      $('#selMenu1').empty();
      $.get('menuSelect',{},function(txt){
         if(txt ==""){
            return false;
         }
         let rec=txt.split(';');
         for (i=0; i < rec.length; i++){
            let field = rec[i].split(',');
            let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
            $('#selMenu1').append(html);
            console.log(html);
         }
      })
   }
   
   nTotal=0;
   nTotal=parseInt(nTotal);
        
</script>
</html>