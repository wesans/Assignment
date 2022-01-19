<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cafe Main</title>
</head>
<style>
table.bound {
    border-collapse:collapse;
    border:1px solid green;
    height:340px;
    width:260px;
    background-color:lightgrey;
}
td.bound {
    border:1px solid blue;
}
#selMenu,#selOrder,#selSales,#selMenu1 {
    width:240px ;
}
</style>
<body>
<table>
<tr>
    <td valign=top>
        <table class='bound'>
        <caption>메뉴목록&nbsp;&nbsp;&nbsp;<button id=btnMenu align=right>메뉴관리</button></caption>
            <tr>
                <td colspan=2>
                    <select id=selMenu size=13></select>
                </td>
            </tr>
            <tr>
                <td>메뉴명</td>
                <td><input type=text id=menuname readonly></td>
            </tr>
            <tr>
                <td>수량</td>
                <td><input type=number id=count min=1 style='width:50px'>잔</td>
            </tr>
            <tr>
                <td>금액</td>
                <td><input type=number id=menuprice readonly>원</td> <!--type:number 원땜에 text변경한거 롤백-->
            </tr>
            <tr>
                <td><button id=btnReset>비우기</button></td>
                <td align=right><button id=btnAdd>메뉴추가</button></td>
            </tr>
        </table>
    </td>
    <td valign=top>
        <table class='bound'>
        <caption>주문목록</caption>
            <tr>
                <td colspan=2>
                    <select id=selOrder size=13></select>
                </td>
            </tr>
            <tr>
                <td>모바일</td>
                <td><input type=phone id=mobile size=13></td>
            </tr>
            <tr>
                <td>총액</td>
                <td><input type=number id=total size=6></td>
            </tr>

            <tr>
                <td colspan=2>&nbsp;</td>
            </tr>
            <tr>
                <td><button id=btnCancel>주문취소</button></td>
                <td align=right><button id=btnDone>주문완료</button></td>
            </tr>
        </table>
    </td>
    <td valign=top>
        <table class='bound'>
        <caption>판매내역&nbsp;&nbsp;&nbsp;<button id=btnSummary>Summary</button></caption>
        <tr>
             <td colspan=2 align=right>
                </tr>
            <tr>
                <td>
                    <select id=selSales size=20></select>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
<div id=dlgMenu style='display:none;' title='메뉴관리'>
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
                    <td>단가(가격)</td><td><input type=number id=price min=0 step=500 style='width:50px'>원</td>
                </tr>
                <tr>
               		<td colspan=2 align=left><button id=btnErase>지우기</button></td>
                    <td colspan=2 align=right><button id=btnGo>추가</button>&nbsp;
                    </td>
                </tr>
                </table>
             </td>
        	</tr>
    </table>
</div>
<div id=dlgSales style='display:none;' title='Summary'>
	<table align=left>
		<tr><td align=center>메뉴별 매출금액</td></tr>
              <tr><td>
                 <select id=salesMenu size=20></select>
              </td></tr>
     </table>
 	<table align="right">
 	<tr><td align=center>고객별 매출금액</td></tr>
              <tr><td>
                 <select id=salesMobile size=20></select>
              </td></tr>
   	</table>
</div>
</body>

<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script>

let TOT=0;
TOT=parseInt(TOT);

$(document)
.ready(function() { //실행시
   Menu();
   Sales();
   $('#total').val();
   return false;
})

.on('click','#selMenu',function(){ //#selMenu > 메인 1 메뉴목록view > 메뉴 선택시 하단 출력
    str=$('#selMenu option:selected').text();
    let ar=str.split(' ');
    $('#menuname').val(ar[1]);
    $('#count').val(1);
    $('#menuprice').val(ar[2]);
})

.on('change','#count',function() { //#count > 메인 1 - 수량체크 변경 > 가격 변경값 표시
   str=$('#selMenu option:selected').text();
   let ar=str.split(' ');
   cnt=$('#count').val();
   $('#menuprice').val(ar[2]*cnt);
})

.on('click','#btnReset',function() { //#btnReset > 메인 1 좌측 비우기btn
   $('#menuname,#menuprice,#count').val('')
})

.on('click','#btnAdd',function(){ //#btnAdd > 메인 1 우측 메뉴추가btn
     Addmpr=$('#menuprice').val();
     strOrder='<option>'+$('#menuname').val()+' x'+$('#count').val()+' '+$('#menuprice').val()+'</option>';
     $('#selOrder,#selOrder1').append(strOrder);
     Addmpr=parseInt(Addmpr);
     TOT+=Addmpr;
     $("#total").val(TOT);
 })
//
//
 .on('click','#btnCancel',function() { //#btnCancel > 메인 2 주문취소btn >> 모두 지워짐
    $('#selOrder').empty();
    $('#mobile,#total').val('');
 })
 
 .on('click','#btnDone',function() { //#btnDone > 메인 2 주문완료btn
    $('#selOrder option').each(function() {
       if($('#total').val()!=0) {
          strAll='<option>'+'['+$('#mobile').val()+'] '+$(this).text()+'</option>';
          $('#selSales').append(strAll);
       }
    })
    $('#selOrder').empty();
    $('#mobile,#total').val('');
 })
  
// 메뉴관리 Button
//  

.on('click','#btnMenu',function() {//#btnMenu > 메인 1 (우상단)메뉴관리btn
   $('#dlgMenu').dialog({  //#dlgMenu 소환
      width:560,
      open:function() {
      $.get('menuSelect', {}, function(txt) {  // 연결 menuSelect
             if (txt=='')
                return false;
             let rec = txt.split(';');
             for (i=0 ; i < rec.length ; i++) { 
                let field = rec[i].split(',');
                let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
                $('#selMenu1').append(html);
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
   
.on('change','#selMenu1',function() { //#selMenu1 > 메인 1 (우상단)메뉴관리btn > 
      let strr=$('#selMenu1 option:selected').text();
      let arr=strr.split(' ');
      $('#code').val(arr[0]);
      $('#name').val(arr[1]);
      $('#price').val(arr[2]);

  })
  
.on('click','#btnGo',function() { //#btnGo > 메인 1 (우상단)메뉴관리btn > 추가btn
 let operation = '';
 if ($('#code').val() == '') {  // code 공백일시
    if ($('#name').val() != '' && $('#price').val() != '') { //name,price 공백 아님
       operation = "menuInsert";     //연결 menuInsert
    } else { //name,price 중 하나라도 공백
       alert('입력값 모두 채워주세요.');
       return false;
       }
    } else { //code 공백 아닐시
       if ($('#code').val() != '' && $('#name').val() != '' && $('#price').val() != '') { //셋다 공백 아닐때
          operation = "menuUpdate";   //연결 menuUpdate
       } else {
          operation = "menuDelete";   //연결 menuDelete
       }
    }   
    $.get(operation, {code : $('#code').val(),name : $('#name').val(),price : $('#price').val()}, function(txt) {
       $('#code,#name,#price').val('');
       Menu();
       Menu1();
    }, 'text');
    return false;
   })
   
.on('click','#btnErase',function() { //#btnErase > 메인 1 (우상단)메뉴관리btn > 지우기btn
	$('#code,#name,#price').val('')
	})

//
.on('click','#btnSummary',function() {
   $('#dlgSales').dialog({  
      width:560,
      open:function() {
      $.get('salesMenu', {}, function(txt) {  // 연결 salesSelect
             if (txt=='')
                return false;
             let rec = txt.split(';');
             for (i=0 ; i < rec.length ; i++) { 
                let field = rec[i].split(',');
                let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
                $('#salesMenu').append(html);
              }
				    }, 'text')
				$.get('salesMobile', {}, function(txt) {
		       		if (txt == "") return false;
		       		let rec = txt.split(';');
		       		for (i = 0; i < rec.length; i++) {
		          		let field = rec[i].split(',');
		          		let html ='<option>'+field[0]+' '+field[1]+'</option>';
		          		$('#salesMobile').append(html);
		       		}
		    	}, 'text')
			},
			 close:function() {
				
			 }
			});
		})
//
// Menu(), Menu1()
function Menu(){
   $('#selMenu').empty();
   $.get('menuSelect',{},function(txt){
      if(txt==''){
         return false;
      }
      let rec=txt.split(';');
      for (i=0; i < rec.length; i++){
         let field = rec[i].split(',');
         let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
         $('#selMenu').append(html);
      }
   })
}

function Menu1(){
   $('#selMenu1').empty();
   $.get('menuSelect',{},function(txt){
      if(txt==''){
         return false;
      }
      let rec=txt.split(';');
      for (i=0 ; i < rec.length ; i++){
         let field = rec[i].split(',');
         let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
         $('#selMenu1').append(html);
      }
   })
}
//
// function Sales(){}

</script>
</html>