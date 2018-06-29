package model;

import middleware.Logger;
import js.Node;
import node.XLSX.Workbook;

class ModelLocator {

    private static var _instance:ModelLocator;

    public var langs(default, null):Array<Lang>;

    private function new() {
        langs = [];
    }

    public function fromWorkbook(workbook:Workbook):Void {
        langs = [];
        for (i in 0...workbook.SheetNames.length) {
            var lang = new Lang(workbook.SheetNames[i]);
            this.langs.push(lang);

            var sheet = workbook.Sheets[lang.name];
            var fields = Reflect.fields(sheet);
            for (field in fields) {
                var letter:String = field.charAt(0);
                var index:Int = Std.parseInt(field.substring(1));
                if (lang.cards[index] == null) {
                    lang.cards[index] = new Card();
                }
                var card = lang.cards[index];
                switch(letter){
                    case 'A':
                        card.name = Reflect.field(sheet, field).h;
                    case 'B':
                        card.cost = Reflect.field(sheet, field).h;
                    case 'C':
                        card.type = Reflect.field(sheet, field).h;
                        card.tags = card.type != null ? card.type.split(" ") : [];
                    case 'D':
                        card.att = Reflect.field(sheet, field).h;
                    case 'E':
                        card.def = Reflect.field(sheet, field).h;
                    case 'F':
                        card.description = Reflect.field(sheet, field).h ;
                        if (card.description != null) {
                            card.description = StringTools.htmlUnescape(card.description).split("&apos;").join("'");
                        }

                    default :
                        Logger.error("unknown letter " + letter);
                }
            }
        }
    }

    public static function getInstance():ModelLocator {
        if (_instance == null) {
            _instance = new ModelLocator();
        }
        return _instance;
    }
}
