
//**************************//
//****컨트롤 임시 정의 파일****//
//*알파로에서 정의된 컨트롤 js 읽어야 함*//
//**************************//



//추상 클래스
class JsWidget{

    //생성자
    constructor() {
        if (new.target === JsWidget) {
          throw new Error("JsWidget class can't be instantiated directly");
        }
    }

    //메서드
    setProp() {
        throw new Error("setProp method must be implemented");
    }
}

class Button extends JsWidget{

    /**
     * @type {function(void): void}
     */
    OnClick;

    SetProp(){
        console.log("setProp is work");
        console.log("setProp is done");
    }
}

class Form extends JsWidget{

    /**
     * @type {function(String, Object): void}
     */
    OnFormInit;

    SetProp(){
        console.log("setProp is work");
        console.log("setProp is done");
    }
}