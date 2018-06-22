package node;

@:jsRequire("xlsx")
extern class XLSX {

    public static function read(buffer:js.node.Buffer,options:ParsingOptions):Workbook;

}

typedef ParsingOptions = {
    type:String
}

interface Workbook {

    var SheetNames:Array<String>;

}
