package model;
class Card {

    public var id:Int;
    public var langId:Int;
    public var name:String;
    public var cost:String;
    public var type:String;
    public var att:String;
    public var def:String;
    public var description:String;
    public var image:String;
    public var tags:Array<String>;
    public var costHtml:String;


    public function new() {
        image = "repeat.jpg";
    }
}
