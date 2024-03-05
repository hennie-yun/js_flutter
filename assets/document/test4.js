form.OnFormInit=function(){
    st_1.SetProp("caption", "form is initialized");
}

btn_1.OnClick=function(){
    st_1.SetProp("caption", "hi");
    me_1.SetProp("caption", "hi");
}
btn_2.OnClick=function(){
    // st_1.SetProp("caption", "hello");
    let me1Text = me_1.GetProp("caption");
    st_1.SetProp("caption", me1Text);
    me_1.SetProp("caption", "hello")
}

btn_close.OnClick=function(){
    menuManage.preHistory() // 뒤로가기
    // form.CloseScreen(); // 다이얼로그인 경우 닫기
}