package model;
class Lang {

    public var id:Int;
    public var name:String;
    public var cards:Array<Card>;

    public function new(name="") {
        cards = [];
        this.name = name;
    }
}
