
//**************************//
//****JS에서 Dart코드 실행****//
//**************************//


class MenuManage{

  constructor() {
  }

  ///화면 이동 메서드
  async moveScreen(screenId, objData) {
    console.log("moveScreen called");
    try{
        var result = await sendMessage('moveScreen', `{"screenId":"${screenId}", "objData":"${objData}"}`);
        return result;
    }
    catch (error){
        console.log("**error in MenuManage.moveScreen**");
        console.error(error);
    }
  }
x
  ///화면 뒤로가기 메서드
  async preHistory() {
      try{
          var result = await sendMessage('preHistory', `{}`);
          return result;
      }
      catch (error){
          console.log("**error in MenuManage.preHistory**");
          console.error(error);
      }
  }

}

const menuManage = new MenuManage();

